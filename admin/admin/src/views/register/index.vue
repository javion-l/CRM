<!--注册页面-->
<template>
  <div class="sign_container">
    <div class="signForm_box">
      <div class="title_box"><span>Register</span></div>
        <el-form
          class="sign_form"
          :model="signForm"
          :rules="signFormRules"
          ref="signFormRef"
        >
        <el-form-item prop="username">
          <el-input
            prefix-icon="iconfont icon-BasicIcons-all-"
            placeholder="请输入用户名"
            v-model.trim="signForm.userName"
            @change="inputLimit"
          ></el-input>
        </el-form-item>
        <el-form-item prop="pwd">
          <el-input
            prefix-icon="iconfont icon-suoding"
            placeholder="请输入密码"
            type="password"
            v-model="signForm.userPassword"
          ></el-input>
        </el-form-item>
        <el-form-item prop="pass">
          <el-input
            prefix-icon="iconfont icon-suoding"
            placeholder="请确认密码"
            type="password"
            v-model="signForm.pass"
          ></el-input>
        </el-form-item>
          <el-form-item prop="email">
            <el-input
                    prefix-icon="el-icon-message"
                    placeholder="请输入邮箱"
                    v-model="signForm.email"
            ></el-input>
          </el-form-item>
          <el-form-item prop="code" style="width:200px;">
            <el-input
                    prefix-icon="el-icon-edit"
                    placeholder="请输入验证码"
                    v-model="signForm.code"
            ></el-input>
          </el-form-item>
            <el-button
                    v-if="Sending==false"
                    type="primary"
                    style="width: 150px; height: 40px;margin-left:30px;margin-top:-55px !important;position:absolute;"
                    @click="getCode"
            >发送验证码</el-button>
            <el-button
                    v-else
                    type="primary"
                    style="width: 150px; height: 40px;margin-left:30px;margin-top:-55px !important;position:absolute;"
                    disabled
            >{{time}}秒后可再次发送</el-button>
        <el-form-item class="form_button">
          <el-button type="primary" round class="btn1" @click="signUp">注册<i class="el-icon-right"></i></el-button>
        </el-form-item>
        <div class="sign_up" @click="jumpHome"><span>点击登录</span></div>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "register",
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.signForm.pass !== "") {
          // this.$refs.signFormRef.validateField('code')
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.signForm.userPassword) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      Sending:false,
      time:59,
      timer: "",

      signForm: {
        userName: "",
        userPassword: "",
        pass: "",
        email: "",
        code:"",
      },

      //表单验证规则
      signFormRules: {
        userName: [{ required: true, message: "请输入用户名", trigger: "blur" }],
        name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
        role: [{ required: true, message: "请选择角色", trigger: "change" }],
        pwd: [{ validator: validatePass, trigger: "blur" }],
        pass: [{ validator: validatePass2, trigger: "blur" }],
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
    //跳转登录页面
    jumpHome() {
      this.$router.push("/");
    },
    // 注册成功，跳转到首页
    signUp() {
      this.$refs.signFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error("用户注册失败");
        //delete this.signForm.pass;
        var user = this.signForm;
        const result = await this.$http.post("/user/register", user);
        if (result.data.code === 200) {
          this.$message.success("注册成功！");
          this.$router.push("/");
        } else {
          this.$message.error(result.data.message);
          // location.reload();
        }
      });
    },
    // 用户名校验
    inputLimit(val) {
       console.log(val);
       this.signForm.username = this.signForm.username.replace(/[^\a-\z\A-\Z0-9]/g, "");
       let n = val.search(/[^\a-\z\A-\Z0-9]/g);
       console.log(n)
       if(n==0){
         this.$message.error("账号由英文和数字组成")
       }
    },
    getCode(){
      if(!this.signForm.email){
        this.$message.warning("请输入邮箱");
        return;
      }
      if(!/^\w+((.\w+))@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+).[A-Za-z0-9]+$/.test(this.signForm.email)){
        this.$message.warning("请输入正确的邮箱");
        return;
      }
      this.Sending=true;
      // //发送验证码
      this.$http.post("/user/email/"+this.signForm.email).then(res=>{
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
    },
  },
};
</script>

<style lang="less" scoped>
.sign_container {
  height: 100%;
  background-image: linear-gradient(to top, #fff1eb 0%, #ace0f9 100%);
  background-size: cover;
}

.signForm_box {
  width: 500px;
  height: 470px;
  background-color: #fff;
  border-radius: 5px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.title_box {
  width: 100%;
  height: 100px;
  line-height: 85px;
  // background: green;
  text-align: center;
  > span {
    font: 400 40px "Times New Roman", Georgia, Serif;
    color: #88d3ce;
  }
}

.sign_form {
  width: 100%;
  padding: 0 60px;
  box-sizing: border-box;
  position: absolute;
  bottom: 0;
  > .el-form-item {
    margin-bottom: 15px;
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

.res_ys {
  display: flex;
  .el-input {
    width: 200px;
    margin-right: 10px;
  }
  .el-button {
    width: 120px;
  }
}

.btnCode {
  position: relative;
}
.btn1 {
  width: 150px;
}
</style>
