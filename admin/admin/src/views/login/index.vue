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
        <el-form-item prop="userName">
          <el-input
            prefix-icon="el-icon-user"
            placeholder="请输入用户名"
            v-model="loginForm.userName"
          ></el-input>
        </el-form-item>
        <el-form-item prop="userPassword">
          <el-input
            prefix-icon="iconfont icon-suoding"
            placeholder="请输入密码"
            :type="pwdType"
            v-model="loginForm.userPassword"
          >
          </el-input>
          <div class="eye" @click="isClosed">
            <i :class="eyes ? icon1 : icon2"></i>
          </div>
        </el-form-item>
        <el-form-item prop="code" style="width:200px;">
          <el-input
            prefix-icon="el-icon-edit"
            placeholder="请输入验证码"
            v-model="loginForm.code"
          ></el-input>
        </el-form-item>
<!--        验证码图片-->
        <img style="width: 120px; height: 40px;margin-left:50px;margin-top:-70px !important;position:absolute;"
            :src="captchUrl"
            @click="updateCaptcha"
        />
        <el-form-item class="form_button">
          <el-button type="primary" round class="btn1" @click="login">登录<i class="el-icon-right"></i></el-button>
        </el-form-item>
        <div style="display: flex">
          <div class="sign_up1" @click='jump("/loginEmail")'><span>邮箱登录</span></div>
          <div class="sign_up" @click='jump("/register")'><span>新用户注册</span></div>
        </div>

      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "login",
  // inject: ["reload"],
  data() {
    return {
      //获取验证码，加时间戳
      captchUrl:"/api/captcha?time="+new Date(),
      loginForm: {
        userName: "",
        userPassword:"",
        number: "",
        code:""
      },
      pwdType: "password",
      eyes: true,
      icon1: "iconfont icon-hide",
      icon2: "iconfont icon-browse",
      //登录验证的规则
      loginFormRules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          // { message: '长度最多不超过 12 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { max: 10, message: '长度最多不超过 10 个字符', trigger: 'blur' }
        ],
        code: [
          { required: true, message: "请输入验证码", trigger: "blur" },
          // { max: 4, message: '长度最多不超过4个字符', trigger: 'blur' }
        ],
      },
    };
  },
  methods: {
    //登录
    login() {
      this.$refs.loginFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error("用户登录失败！");
        // console.log(this.loginForm);
        var user = this.loginForm;
        // console.log(user);
        // 登录接口
        const result = await this.$http.post("/user/login", user);
        // console.log("login", result);
        //登陆成功
        if (result.data.code === 200) {
          this.$message.success("登陆成功");
          //当前用户登录信息存储在localStorage中
          localStorage.setItem("userdata", JSON.stringify(result.data.obj));
          //跳转到主页
          this.$router.push("/page");
          console.log("localstorage", JSON.parse(localStorage.getItem("userdata")));
        } else {
          this.$message.error(result.data.message);
          this.captchUrl = "/api/captcha?time=" + new Date();
        }
      });
    },
    //跳转注册页面
    jump(path) {
      this.$router.push(path);
    },
    //重新获取验证码
    updateCaptcha(){
      this.captchUrl = "/api/captcha?time=" + new Date();
    },
    //显示/隐藏密码
    isClosed() {
      this.pwdType = this.pwdType === "password" ? "text" : "password";
      this.eyes = !this.eyes;
    },
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
  height: 380px;
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
