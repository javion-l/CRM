<!--用户列表-->
<template>
    <div>
      <el-card class="box-card" style="width: 100%">
        <el-breadcrumb style="margin-bottom:15px;" separator="/">
          <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item :to="{ path: '/' }">客户管理</el-breadcrumb-item>
          <el-breadcrumb-item>客户信息管理</el-breadcrumb-item>
        </el-breadcrumb>
        <el-divider></el-divider>
        <div style="display: flex">
        <div style="padding: 10px 0;">
            <!-- TODO  注意这里的搜索条件并不好，有待修改 -->
          <el-input class="ml-5" suffix-icon="el-icon-search" placeholder="请输入客户名" style="width: 200px;margin:5px;" v-model="clientName_select"></el-input>
          <el-input class="ml-5" suffix-icon="el-icon-search" placeholder="请输入客户所在地区" style="width: 200px;margin:5px;" v-model="clientAddress_select"></el-input>
          <el-input class="ml-5" suffix-icon="el-icon-search" placeholder="请输入客户等级" style="width: 200px;margin:5px;" v-model="clientLevel_select"></el-input>
          <el-button class="ml-5" type="primary" @click="conditionSelect">搜索</el-button>
          <el-button class="ml-5" type="danger"  @click="clearCondition">清空</el-button>
          <!-- TODO: 导出功能尚未实现 -->
          <el-button class="ml-5" type="success"  @click="exportTable">导出</el-button>
        </div>
        <div></div>
    </div>
    <!--      用户信息表格-->
    <el-table
        :data="tableData"
        border
        :row-style="{ height: '15px' }"
        :cell-style="{ padding: '0px' }"
        max-height="1000"
        style="width: 97%"
        @selection-change="handleSelectionChange">
    >
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

        <el-table-column prop="clientCode" label="客户编号" width="150">
        </el-table-column>

        <el-table-column prop="clientName" label="客户名称" width="150">
        </el-table-column>

        <el-table-column prop="clientAddress" label="所在地区" width="150">
        </el-table-column>

        <el-table-column prop="clientLevel" label="客户等级" width="130">
        </el-table-column>

        <el-table-column prop="clientCredit" label="客户信用度" width="130">
        </el-table-column>

        <!-- TODO: 这里的客户经理名称需要联表查 -->
        <el-table-column prop="clientCustName" label="客户经理名称" width="160">
        </el-table-column>

        <el-table-column fixed="right" label="操作" width="180" header-align="center">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="primary" size="small">编辑 <i class="el-icon-edit"></i></el-button>
            <!-- TODO: 这里的历史订单需要联表查询 并且需要历史订单界面 -->
            <el-button @click="" type="danger" size="small">历史订单 <i class="el-icon-remove-outline"></i></el-button>
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

      clientName_select:"",
      clientAddress_select:"",
      clientLevel_select:"",


      total: 1000,
      // 分页
      //currentPage: 1, //初始页
      pagesize: 5, //每页多少数据
      currentPage: 1, //默认当前页为第一页
    };
  },

  methods: {
    //this.jump("/404");
    jump(path) {
      this.$router.push(path);
    },
    //清空搜索输入框
    clearCondition() {
        this.currentPage = 1;
        this.clientName_select='';
        this.clientAddress_select='';
        this.clientLevel_select='';
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
