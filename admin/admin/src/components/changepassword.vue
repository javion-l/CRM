<!--修改密码-->
<template>
    <div>
        <el-card class="box_card">
            <div slot="header" class="clearfix">
                <span>重置密码</span>
            </div>
            <el-form
        class="login_form"
        :model="loginForm"
        :rules="loginFormRules"
        ref="loginFormRef"
        style="width: 300px"
      >
        <el-form-item prop="password">
          <el-input
            prefix-icon="iconfont icon-suoding"
            placeholder="请输入新密码"
            :type="pwdType"
            v-model="loginForm.password"
          >
          </el-input>
          <div class="eye" @click="isClosed">
            <i :class="eyes ? icon1 : icon2"></i>
          </div>
        </el-form-item>
        <el-form-item prop="subpassword">
          <el-input
            prefix-icon="iconfont icon-suoding"
            placeholder="请输入确认密码"
            :type="pwdType"
            v-model="loginForm.subpassword"
          >
          </el-input>
          <div class="eye" @click="isClosed">
            <i :class="eyes ? icon1 : icon2"></i>
          </div>
        </el-form-item>
        <el-form-item prop="code" style="width:150px;">
            <el-input
                    prefix-icon="el-icon-edit"
                    placeholder="请输入验证码"
                    v-model="loginForm.code"
            ></el-input>
        </el-form-item>
            <el-button
                    v-if="Sending==false"
                    type="primary"
                    style="width: 130px; height: 35px;margin-left:10px;margin-top:-52px !important;position:absolute;"
                    @click="getCode"
            >发送验证码</el-button>
            <el-button
                    v-else
                    type="primary"
                    style="width: 130px; height: 35px;margin-left:10px;margin-top:-52px !important;position:absolute;"
                    disabled
            >{{time}}秒后可再次发送</el-button>
        <el-form-item class="form_button">
          <el-button type="primary" round class="btn1" @click="update"
            >提交<i class="el-icon-right"></i>
          </el-button>
        </el-form-item>
      </el-form>
        </el-card>
    </div>
</template>

<script>
export default {
  name: "changepassord",
  inject: ["reload"],
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.loginForm.password !== "") {
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.loginForm.password) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
        Sending:false,
        time:59,
        timer: "",

      loginForm: {
        subpassword: "",
        password: "",
        email:"",
      },
        user:{},
      pwdType: "password",
      eyes: true,
      icon1: "iconfont icon-hide",
      icon2: "iconfont icon-browse",
      loginFormRules: {
        password: [{ validator: validatePass, trigger: "blur" }],
        subpassword: [{ validator: validatePass2, trigger: "blur" }],
          code: [
              { required: true, message: "请输入验证码", trigger: "blur" },
          ],
      },
    };
  },
  mounted() {
      this.$http.get("/user/finduser?id=" + JSON.parse(localStorage.getItem('userdata')).id, {
          headers: {
              Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
          }
      }).then(resp => {
          if (resp.status === 200) {
              this.user = resp.data.obj;
          }
      })
  },
  methods: {
      update() {
          this.$refs.loginFormRef.validate(async (valid) => {
              if (!valid) return this.$message.error("修改密码失败");
              this.loginForm.id = JSON.parse(localStorage.getItem('userdata')).id;
              this.loginForm.email = this.user.email;
              const result = await this.$http.post(
                  "/user/pwdModify",
                  this.loginForm, {
                      headers: {
                          Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
                      }
                  }
              );
              // console.log("login", result);
              if (result.data.code === 200) {
                  this.$message.success("修改成功");
                  localStorage.removeItem("userdata")
                  this.$router.push("/login");
              } else {
                  this.$message.error(result.data.message);
              }
          });
      },
      getCode(){
          this.Sending=true;
          // //发送验证码
          this.$http.post("/user/email/"+this.user.email).then(res=>{
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
    isClosed() {
      this.pwdType = this.pwdType === "password" ? "text" : "password";
      this.eyes = !this.eyes;
    },
  },
};
</script>


<style lang="less" scoped>
.box_card {
    width: 400px;
}

.psdForm {
    padding-right: 30px;
}

.resetBtn {
    margin-left: 30px;
}
.password{
  margin-left:10px;
}
.eye {
  margin-left: 320px;
  margin-top: -40px;
}
</style>
