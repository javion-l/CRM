<!--用户列表-->
<template>
  <div>
    <el-card class="box-card" style="width: 100%">
      <el-breadcrumb style="margin-bottom:15px;" separator="/">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/' }">基础数据</el-breadcrumb-item>
        <el-breadcrumb-item>用户及权限管理</el-breadcrumb-item>
      </el-breadcrumb>
      <el-divider></el-divider>
      <div style="display: flex">
        <div style="padding: 10px 0;">
          <el-input class="ml-5" suffix-icon="el-icon-search" placeholder="请输入用户名" style="width: 200px;margin:5px;" v-model="username_select"></el-input>
          <el-input class="ml-5" suffix-icon="el-icon-search" placeholder="请输入邮箱" style="width: 200px;margin:5px;" v-model="email_select"></el-input>
          <el-button class="ml-5" type="primary" @click="conditionSelect">搜索</el-button>
        </div>
        <div></div>
      </div>
      <!-- 添加信息 -->
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <el-form-item>
          <div>
            <el-button type="primary" @click="dialogFormVisible = true">添加 <i class="el-icon-circle-plus-outline"></i></el-button>
            <el-button type="danger" @click="deleteBatch">批量删除 <i class="el-icon-remove-outline"></i></el-button>
          </div>
<!--          添加用户弹出框-->
          <el-dialog
            title="添加用户"
            :visible.sync="dialogFormVisible"
            width="40%"
            append-to-body
            center
          >
            <el-upload
                  class="avatar-uploader"
                  :action="doupload()"
                  :show-file-list="false"
                  :on-success="handleAvatarSuccess"
                  :before-upload="beforeAvatarUpload"
                  style="display: inline-block; width: 120px; margin-left: 35%;margin-bottom: 20px;">
              <!-- 上传成功后展示的图片 -->
              <img v-if="form.avatar" :src="form.avatar" class="avatar" />
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
            <el-form
              :model="form"
              style=":form"
              :rules="loginFormRules"
              ref="loginFormRef"
            >
              <el-form-item
                label="用户名:"
                :label-width="formLabelWidth"
                prop="userName"
              >
                <el-input @change="inputLimit" v-model.trim="form.userName" autocomplete="off"></el-input>
              </el-form-item>
              <el-form-item
                label="邮箱:"
                :label-width="formLabelWidth"
                prop="email"
              >
                <el-input v-model="form.email" autocomplete="off"></el-input>
              </el-form-item>
              <el-form-item
                label="密码:"
                :label-width="formLabelWidth"
                prop="userPassword"
              >
                <el-input v-model="form.userPassword" autocomplete="off"></el-input>
              </el-form-item>
              <el-form-item label="身份:" :label-width="formLabelWidth">
                <el-select v-model="form.userRoleId" placeholder="请选择身份">
                  <el-option label="系统管理员" value="1"></el-option>
                  <el-option label="销售主管" value="2"></el-option>
                  <el-option label="客户经理" value="3"></el-option>
                  <el-option label="高管" value="4"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="所属地区:" :label-width="formLabelWidth">
                <el-select
                        v-model="form.daName"
                >
                  <el-option
                          v-for="item in this.AreaList"
                          :key="item.daName"
                          :label="item.daName"
                          :value="item.daName"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
              <el-button type="primary" @click="submitadd()">添加</el-button>
              <el-button @click="dialogFormVisible = false">取消</el-button>
            </div>
          </el-dialog>
        </el-form-item>
      </el-form>

      <!-- 编辑用户信息 -->
      <el-dialog
              title="修改用户信息"
              :visible.sync="dialogFormVisible1"
              width="40%"
              append-to-body
              center
      >
        <el-upload
                class="avatar-uploader"
                :action="doupload()"
                :show-file-list="false"
                :on-success="handleAvatarSuccess1"
                :before-upload="beforeAvatarUpload1"
                style="display: inline-block; width: 120px; margin-left: 35%;margin-bottom: 20px;">
          <!-- 上传成功后展示的图片 -->
          <img v-if="form1.avatar" :src="form1.avatar" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        <el-form
                :model="form1"
                style=":form1"
                :rules="loginFormRules"
                ref="loginFormRef"
        >
          <el-form-item
                  label="用户名:"
                  :label-width="formLabelWidth"
                  prop="userName"
          >
            <el-input
                    v-model="form1.userName"
                    autocomplete="off"
                    disabled
            ></el-input>
          </el-form-item>
          <el-form-item
                  label="邮箱:"
                  :label-width="formLabelWidth"
                  prop="email"
          >
            <el-input disabled v-model="form1.email" autocomplete="off"></el-input>
          </el-form-item>

          <el-form-item label="身份:" :label-width="formLabelWidth">
            <el-select
                    v-model="form1.roleName"
                    :placeholder="form1.roleName"
            >
              <el-option
                      v-for="item in options"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="所属地区:" :label-width="formLabelWidth">
            <el-select
                    v-model="form1.daName"
                    :placeholder="form1.daName"
            >
              <el-option
                      v-for="item in this.AreaList"
                      :key="item.daName"
                      :label="item.daName"
                      :value="item.daName"
              >
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="editdetail()">提交</el-button>
          <el-button @click="dialogFormVisible1 = false">取消</el-button>
        </div>
      </el-dialog>

<!--      用户信息表格-->
      <el-table
        :data="tableData"
        border
        :row-style="{ height: '15px' }"
        :cell-style="{ padding: '0px' }"
        max-height="1000"
        style="width: 92%"
        @selection-change="handleSelectionChange">
      >
        <el-table-column
                type="selection"
                width="50">
        </el-table-column>
<!--        <el-table-column fixed v-if="false" prop="id" label="用户id" width="100"></el-table-column>-->
        <el-table-column fixed label="用户头像" width="100">
          <template slot-scope="scope">
            <el-image v-if="scope.row.avatar !== ''"
              style="width: 80px;"
              :src="scope.row.avatar"
              fit="contain"
            ></el-image>
            <span v-else>无图片</span>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="用户名" width="150">
        </el-table-column>
        <el-table-column prop="email" label="邮箱" width="150">
        </el-table-column>
        <el-table-column prop="roleName" label="身份" width="130">
        </el-table-column>
        <el-table-column prop="daName" label="所属地区" width="130">
        </el-table-column>
        <el-table-column prop="gmtCreate" label="注册时间" width="160">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="180">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="success" size="small">编辑 <i class="el-icon-edit"></i></el-button>
            <el-button @click="deteleUser(scope.row)" type="danger" size="small">删除 <i class="el-icon-remove-outline"></i></el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页 -->
      <div class="block" style="margin-top: 20px;">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-size="pagesize"
          layout="prev, pager, next, jumper,->,total"
          :total="total"
        >
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {

  mounted() {
    // this.$http.get(
    //         `/role/getRole?uid=${JSON.parse(localStorage.getItem('userdata')).id}`,{
    //           headers: {
    //             Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
    //           }
    //         }
    // ).then(res=>{
    //   let RoleName=res.data.obj;
    //   if(RoleName.includes(this.pageName)){
    //     this.hasRole=true;
    //   }else{
    //     this.hasRole=false;
    //   }
    //   if(this.hasRole==false){
    //     this.$message.error("无权访问");
    //     this.jump("/404");
    //     return;
    //   }
    //   this.userdata();
    // })
    this.userdata();
    this.$http.get(
            `/dataArea/getArea`,{
              headers: {
                Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
              }
            }
    ).then(res=>{
      for (var i=0;i<res.data.obj.length;i++) {
        // console.log(res.data.obj[i])
        this.AreaMap[res.data.obj[i].daId]=res.data.obj[i].daName
        this.AreaRMap[res.data.obj[i].daName]=res.data.obj[i].daId
      }
      this.AreaList=res.data.obj
      console.log(this.AreaList)
      console.log(this.AreaMap)
      console.log(this.AreaRMap)
    })

  },


  data() {
    return {

      AreaMap:{},
      AreaRMap:{},
      AreaList:[],


      options: [
        {
          value: "系统管理员",
          label: "系统管理员",
        },
        {
          value: "销售主管",
          label: "销售主管",
        },
        {
          value: "客户经理",
          label: "客户经理",
        },
        {
          value: "高管",
          label: "高管",
        },
      ],


      username_select:"",
      email_select:"",

      multipleSelection:[],
      total: 1000,
      // 分页
      //currentPage: 1, //初始页
      pagesize: 5, //每页多少数据
      currentPage: 1, //默认当前页为第一页
      //添加用户对话框
      dialogFormVisible: false,
      form: {
        avatar:"https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg",
        userName: "",
        userPassword: "",
        userRoleId: "1",
        roleName:"",
        email: "",
        daId:"1",
        daName:"",
      },
      //修改用户的对话框
      dialogFormVisible1: false,
      form1: {
        userName: "",
        userPassword: "",
        userRoleId: "",
        roleName:"",
        email: "",
        avatar: "",
        daId:"",
        daName:"",
      },
      formLabelWidth: "100px",
      formInline: {
        user: "",
      },
      tableData: [],
      loginFormRules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          // { message: '长度最多不超过 12 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          // { max: 10, message: '长度最多不超过 10 个字符', trigger: 'blur' }
        ],
        email: [
          { required: true, message: "请重新输入邮箱", trigger: "blur" },
          {
            pattern:
                    /^\w+((.\w+))@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+).[A-Za-z0-9]+$/,
            message: "请输入有效的邮箱",
          },
          // { max: 10, message: '长度最多不超过 10 个字符', trigger: 'blur' }
        ],
      },
    };
  },

  methods: {
    //this.jump("/404");
    jump(path) {
      this.$router.push(path);
    },
    inputLimit(val) {
      console.log(val);
      this.form.userName = this.form.userName.replace(/[^\a-\z\A-\Z0-9]/g, "");
      let n = val.search(/[^\a-\z\A-\Z0-9]/g);
      console.log(n)
      if(n==0){
        this.$message.error("账号由英文和数字组成")
      }
    },
    // 获取第一页表格数据
    async userdata() {

      const result = await this.$http.get(
        `/user/list?currentPage=${1}&size=${5}`,{
                headers: {
                  Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
                }
              }
      );
      console.log(result)
      if (result.status === 200) {
        this.tableData = result.data.data;
        this.total = Number(result.data.total);
        this.$forceUpdate();
      }
    },
    handleSelectionChange(val){
      this.multipleSelection=val;
      console.log(val);
    },
    handleClick(row) {
      // 点击编辑获取信息
      this.dialogFormVisible1 = true;
      var tmp=Object.assign({},row);
      this.form1 = tmp;
      console.log(this.form1);
    },
    handleSizeChange(val) {
        console.log(`每页 ${val} 条`);
      },

      async handleCurrentChange(val) {
        console.log(`当前页: ${val}`);
        if(this.username_select==""&&this.email_select==""){
            const result = await this.$http.get(
                    `/user/list?currentPage=${val}&size=${5}`,{
                      headers: {
                        Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
                      }
                    }
            );
            if (result.status === 200) {
              this.tableData = result.data.data;
              this.total = Number(result.data.total);
              this.$forceUpdate();
            }
        }else{
            const result = await this.$http.get(
                    `/user/conditionSelect?currentPage=${val}&size=${5}&userName=${this.username_select}&email=${this.email_select}`,{
                      headers: {
                        Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
                      }
                    }
            );
            if (result.status === 200) {
              this.tableData = result.data.data;
              this.total = Number(result.data.total);
              this.$forceUpdate();
            } else {
              this.$message.error("查询失败");
            }
      }

    },

    //条件查询
    async conditionSelect(){
      this.currentPage=1;
      const result = await this.$http.get(
            `/user/conditionSelect?currentPage=${1}&size=${5}&userName=${this.username_select}&email=${this.email_select}`,{
              headers: {
                Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
              }
            }
      );
      if (result.status === 200) {
        this.tableData = result.data.data;
        this.total = Number(result.data.total);
        this.$forceUpdate();
        this.$message.success("查询成功");
      } else {
        this.$message.error("查询失败");
      }
    },


    // 添加用户信息
    submitadd() {
      this.$refs.loginFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error("表单验证失败！");
        if (this.form.roleName == "系统管理员") {
          this.form.userRoleId = 1;
        } else if (this.form.roleName == "销售主管") {
          this.form.userRoleId = 2;
        } else if (this.form.roleName == "客户经理") {
          this.form.userRoleId = 3;
        } else if (this.form.roleName == "高管") {
          this.form.userRoleId = 4;
        }
        this.form.daId=this.AreaRMap[this.form.daName]
        const result = await this.$http.post("/user/adminregister", this.form,{
          headers: {
            Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
          }
        });
        console.log("adduser", result);
        if (result.data.code === 200) {
          this.$message.success("添加成功!");
          await this.userdata();
          this.$forceUpdate();
          this.dialogFormVisible = false;
          //清除数据
          this.form = {
            avatar:"https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg",
            userName: "",
            userPassword: "",
            userRoleId: "1",
            roleName:"",
            email: "",
            daId:"1",
            daName:"",
          }
        } else {
          this.$message.error(result.data.message);
        }
      });
    },

    // 修改用户信息
    async editdetail() {
      console.log("修改用户信息", this.form1);
      if (this.form1.roleName == "系统管理员") {
        this.form1.userRoleId = 1;
      } else if (this.form1.roleName == "销售主管") {
        this.form1.userRoleId = 2;
      } else if (this.form1.roleName == "客户经理") {
        this.form1.userRoleId = 3;
      } else if (this.form1.roleName == "高管") {
        this.form1.userRoleId = 4;
      }
      this.form1.daId=this.AreaRMap[this.form1.daName]
      const result = await this.$http.put("/user/infoModify", this.form1,{
        headers: {
          Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
        }
      });
      if (result.data.code === 200) {
        this.$message.success("修改成功！");
        await this.userdata();
        this.$forceUpdate();
        this.dialogFormVisible1 = false;
      } else if (result.data.code === 500) {
        this.$message.error(result.data.message);
        this.userdata();
      } else {
        this.$message.error("修改失败!");
      }
    },

    // 删除用户信息
    deteleUser(user) {
      this.$confirm("此操作将永久删除, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(async () => {
          const result = await this.$http.delete("/user/delete?userId=" + user.userId,{
            headers: {
              Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
            }
          });
          if (result.data.code == 200) {
            this.$message.success(result.data.message);
            this.userdata();
            this.$forceUpdate();
          } else {
            this.$message.error(result.data.message);
          }
        })
    },

    deleteBatch(){
        let ids = this.multipleSelection.map(v=>v.userId);
        this.$confirm("此操作将永久删除, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        })
        .then(async () => {
          const result = await this.$http.post("/user/deletebatch" , ids ,{
            headers: {
              Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
            }
          });
          if (result.data.code == 200) {
            this.$message.success(result.data.message);
            this.userdata();
            this.$forceUpdate();
          } else {
            this.$message.error(result.data.message);
          }
        })
    },
    // 封装上传文件请求
    doupload() {
      return axios.defaults.baseURL + "/file/upload";
    },
    // 成功上传之后的回调函数
    handleAvatarSuccess(res) {
      this.form.avatar = res.obj
      console.log(res);
    },
    beforeAvatarUpload(file) {
      // const isJPG = file.type == "image/png";
      const isLt2M = file.size / 1024 / 1024 < 5;
      console.log(file);
      // 实例化一个阅读器对象
      var reader = new FileReader();
      // 读取文件的路径，没有返回值,结果在reader.result里
      reader.readAsDataURL(file);
      // 读取需要时间，读完后再修改图片路径
      var that = this;
      reader.onload = function () {
        //回显给上方图片中
        that.form.avatar = this.result;
      };
      if (
              file.type == "image/png" ||
              file.type == "image/jpg" ||
              file.type == "image/jpeg" ||
              file.type == "image/JPG"
      ) {
        // this.$message.error("上传头像图片格式不正确");
      } else {
        this.$message.error("上传头像图片格式不正确");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 5MB!");
      }
      return isLt2M;
    },
    // 成功上传之后的回调函数
    handleAvatarSuccess1(res) {
      this.form1.avatar = res.obj
      console.log(res);
    },
    beforeAvatarUpload1(file) {
      // const isJPG = file.type == "image/png";
      const isLt2M = file.size / 1024 / 1024 < 5;
      console.log(file);
      // 实例化一个阅读器对象
      var reader = new FileReader();
      // 读取文件的路径，没有返回值,结果在reader.result里
      reader.readAsDataURL(file);
      // 读取需要时间，读完后再修改图片路径
      var that = this;
      reader.onload = function () {
        //回显给上方图片中
        that.form1.avatar = this.result;
      };
      if (
              file.type == "image/png" ||
              file.type == "image/jpg" ||
              file.type == "image/jpeg" ||
              file.type == "image/JPG"
      ) {
        // this.$message.error("上传头像图片格式不正确");
      } else {
        this.$message.error("上传头像图片格式不正确");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 5MB!");
      }
      return isLt2M;
    },
  },
};
</script>

<style lang="less" scoped>
.carid {
  display: none;
}
.demo-form-inline {
  display: flex;
  flex: left;
}
.el-form-item {
  margin-bottom: 20px;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  /*border-radius: 100px;*/
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
// .avatar-uploader .el-upload:hover {
// //   border-color: #409eff;
// }
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
  border-radius: 100px;
}
.upload .el-upload__input {
  display: none;
}

input[type="file"] {
  display: none !important;
}

</style>
