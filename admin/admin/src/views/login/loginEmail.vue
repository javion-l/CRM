<!--登录页面-->
<template>
    <div class="login_container">
        <div class="loginForm_box">
            <div class="title_box"><span>Login In</span></div>
            <el-form
                    class="login_form"
                    :model="loginForm"
                    :rules="loginFormRules"
                    ref="loginFormRef"
            >
                <el-form-item prop="email">
                    <el-input
                            prefix-icon="el-icon-message"
                            placeholder="请输入邮箱"
                            v-model="loginForm.email"
                    ></el-input>
                </el-form-item>
                <el-form-item prop="code" style="width:170px;">
                    <el-input
                            prefix-icon="el-icon-edit"
                            placeholder="请输入验证码"
                            v-model="loginForm.code"
                    ></el-input>
                </el-form-item>
                <el-button
                        v-if="Sending==false"
                        type="primary"
                        style="width: 150px; height: 40px;margin-left:20px;margin-top:-70px !important;position:absolute;"
                        @click="getCode"
                >发送验证码</el-button>
                <el-button
                        v-else
                        type="primary"
                        style="width: 150px; height: 40px;margin-left:20px;margin-top:-70px !important;position:absolute;"
                        disabled
                >{{time}}秒后可再次发送</el-button>
                <el-form-item class="form_button">
                    <el-button type="primary" round class="btn1" @click="login">登录<i class="el-icon-right"></i></el-button>
                </el-form-item>
                <div style="display: flex">
                    <div class="sign_up1" @click='jump("/login")'><span>用户名登录</span></div>
                    <div class="sign_up" @click='jump("/register")'><span>新用户注册</span></div>
                </div>

            </el-form>
        </div>
    </div>
</template>

<script>
    export default {
        name: "login",
        data() {
            return {
                Sending:false,
                time:59,
                timer: "",

                loginForm: {
                    email:"",
                    code:""
                },

                //登录验证的规则
                loginFormRules: {
                    email: [
                        { required: true, message: "请输入邮箱", trigger: "blur" },
                        {
                            pattern:
                                /^\w+((.\w+))@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+).[A-Za-z0-9]+$/,
                            message: "请输入有效的邮箱",
                        },
                    ],
                    code: [
                        { required: true, message: "请输入验证码", trigger: "blur" },
                    ],
                },
            };
        },
        methods: {
            //登录
            login() {
                this.$refs.loginFormRef.validate(async (valid) => {
                    if (!valid) return this.$message.error("用户登录失败！");
                    var user = this.loginForm;
                    const result = await this.$http.post("/user/loginEmail", user);
                    if (result.data.code === 200) {
                        this.$message.success("登陆成功");
                        //当前用户登录信息存储在localStorage中
                        localStorage.setItem("userdata", JSON.stringify(result.data.obj));
                        //跳转到主页
                        this.$router.push("/page");
                        console.log("localstorage", JSON.parse(localStorage.getItem("userdata")));
                    } else {
                        this.$message.error(result.data.message);
                    }
                });
            },
            //跳转注册页面
            jump(path) {
                this.$router.push(path);
            },

            getCode(){
                if(!this.loginForm.email){
                    this.$message.warning("请输入邮箱");
                    return;
                }
                if(!/^\w+((.\w+))@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+).[A-Za-z0-9]+$/.test(this.loginForm.email)){
                    this.$message.warning("请输入正确的邮箱");
                    return;
                }
                this.Sending=true;
                // //发送验证码
                this.$http.post("/user/email/"+this.loginForm.email).then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.$message.success("验证码发送成功");
                    }else{
                        this.$message.error("验证码发送失败");
                    }
                })
                this.timer = setInterval(this.timeChange, 1000);
            },

            timeChange(){
                this.time--;
                if(this.time==0){
                    //调用提交的函数
                    clearInterval(this.timer);
                    this.Sending=false;
                    this.time=59;
                }
            }
        },
    };
</script>

<style lang="less" scoped>
    .login_container {
        height: 100%;
        // background: url('https://img1.baidu.com/it/u=1490431314,2325918058&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500') no-repeat;
        background-size: cover;
        //  background: linear-gradient(to bottom right,#f1f0f0, #6699CC, #b8b6b6);
        background-image: linear-gradient(to top, #fff1eb 0%, #ace0f9 100%);
    }

    .loginForm_box {
        width: 450px;
        height: 320px;
        background-color: #fff;
        border-radius: 5px;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }

    .title_box {
        width: 100%;
        height: 85px;
        line-height: 85px;
        // background: green;
        text-align: center;
        > span {
            font: 400 40px "Times New Roman", Georgia, Serif;
            color: #88d3ce;
        }
    }

    .login_form {
        width: 100%;
        padding: 0 60px;
        box-sizing: border-box;
        position: absolute;
        bottom: 0;
        > .el-form-item {
            margin-bottom: 30px;
        }
    }

    .form_button {
        display: flex;
        justify-content: center;
    }

    .sign_up {
        position: absolute;
        right: 17px;
        bottom: 11px;
        color: #909399;
        cursor: pointer;
    }
    .sign_up1 {
        position: absolute;
        left: 17px;
        bottom: 11px;
        color: #909399;
        cursor: pointer;
    }

    .eye {
        position: absolute;
        bottom: -2px;
        right: 0px;
    }
    .select {
        width: 330px;
        margin-top: -10px;
        margin-bottom: 20px;
    }
    .btn1 {
        width: 100px;
    }
    .code {
        width: 200px;
        margin-top: -50px;
    }
</style>
