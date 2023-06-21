<!--后台主页-->
<template>
  <el-container class="home_container">
    <el-header>
      <div style="display:flex;margin-right: 670px;">
        <img src='~@/assets/logo.jpg' style="height:40px;margin: 2px;"/>
        <span style="font-size: 25px;margin-top: 8px;margin-left: 10px;color: white;">CRM客户关系管理系统</span>
      </div>
      <div class="box2">
        <div>
          <el-dropdown @command="handleCommand">
            <span class="el-dropdown-link"
              >个人中心<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item :command="composeValue('cd1', 'edituser')"
                >修改资料</el-dropdown-item
              >
              <el-dropdown-item :command="composeValue('cd2', 'changepwd')"
                >修改密码</el-dropdown-item
              >
            </el-dropdown-menu>
          </el-dropdown>
        </div>
        <div class="box22" @click="logout">
          <span>退出登录</span>
          <i class="iconfont icon-guanbi"></i>
        </div>
      </div>
    </el-header>
    <el-container>
      <el-aside width="210px">
        <!-- 侧边栏菜单区域 -->
        <el-menu router unique-opened text-color="#fff" background-color="rgb(48,65,86)">
          <el-menu-item index="home" v-show="show3">
            <!-- 一级菜单 -->
            <i class="el-icon-s-home" style="margin-left: -30px"></i>
            <span>首页</span>
          </el-menu-item>
          <el-submenu index="1" v-show="show1">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>营销管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item style="margin-left:50px;" index="/salechancemanage"><i class="el-icon-tickets"></i>销售机会管理</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/salechancedevelop"><i class="el-icon-tickets"></i>客户开发计划</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <el-submenu index="2" v-show="show1">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>客户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item style="margin-left:50px;" index="/infomanage"><i class="el-icon-tickets"></i>客户信息管理</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/lostmanage"><i class="el-icon-tickets"></i>客户流失管理</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <el-submenu index="3" v-show="show1">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>服务管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item style="margin-left:50px;" index="/UnDueRequest"><i class="el-icon-tickets"></i>新建服务管理</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/PendingRequest"><i class="el-icon-tickets"></i>待处理服务管理</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/FeedbackRequest"><i class="el-icon-tickets"></i>待反馈服务管理</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/ArchivedRequest"><i class="el-icon-tickets"></i>已归档服务管理</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <el-submenu index="4" v-show="show2">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>统计报表</span>
            </template>
            <el-menu-item-group>
              <el-menu-item style="margin-left:50px;" index=""><i class="el-icon-tickets"></i>客户贡献分析</el-menu-item>
              <el-menu-item style="margin-left:50px;" index=""><i class="el-icon-tickets"></i>客户构成分析</el-menu-item>
              <el-menu-item style="margin-left:50px;" index=""><i class="el-icon-tickets"></i>客户服务分析</el-menu-item>
              <el-menu-item style="margin-left:50px;" index=""><i class="el-icon-tickets"></i>客户流失分析</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <el-submenu index="5" v-show="show2">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>基础数据</span>
            </template>
            <el-menu-item-group>
              <el-menu-item style="margin-left:50px;" index="/level"><i class="el-icon-tickets"></i>数据字典-企业客户等级</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/serve"><i class="el-icon-tickets"></i>数据字典-服务类别</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/area"><i class="el-icon-tickets"></i>数据字典-地区</el-menu-item>
              <el-menu-item style="margin-left:50px;" index="/userdetail"><i class="el-icon-tickets"></i> 用户及权限管理</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

        </el-menu>
      </el-aside>
      <!-- 内容区 -->
      <el-main>
        <!-- 路由占位符 -->
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  name: "page",
  data() {
    return {
      options: [
        {
          value: "person",
          label: "个人中心",
          children: [
            {
              value: "psw",
              label: "重置密码",
            },
          ],
        },
      ],
      cd1: "reset_psw",
      show1: true,
      show2: true,
      show3: true,
    };
  },
  created() {

  },
  mounted() {

  },
  methods: {
    handleCommand(command) {
      //   this.$router.push(this.cd1)
      console.log(command);
      this.$router.push(command.row);
    },
    logout() {
      this.$confirm("确定要退出登录?, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          localStorage.removeItem("userdata");
          window.sessionStorage.clear();
          this.$router.push("/login");
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消",
          });
        });
    },
    composeValue(item, row) {
      return {
        button: item,
        row: row,
      };
    },
  },
};
</script>

<style lang="less" scoped>
.home_container {
  height: 100%;
  background-image: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
}

.el-header {
  // background-color: #000000;
  box-shadow: 1px 0 4px rgb(0,21,41 / 35%);
  background-color: rgb(48,65,86);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-right: 0px !important;
  .box1 {
    color: #fff;
    span {
      font-size: 25px;
      margin-left: -15px;
    }
  }
  .box2 {
    color: #fff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    div {
      display: flex;
      align-items: center;
      padding: 0 0 0 20px;
    }
    .box22 {
      span {
        padding-right: 6px;
        font-size: 20px;
        // cursor: pointer;
      }
      i {
        font-size: 20px !important;
      }
    }
    /*.box22:hover {*/
    /*  color: #6eb7ff;*/
    /*  cursor: pointer;*/
    /*}*/
  }
}

.el-aside {
  box-shadow: 1px 0 4px rgb(0,21,41 / 35%);
  background-color: rgb(48,65,86);
  .el-menu {
    border-right: none;
    margin-left: -50px;
    .el-submenu__title {
      font-size: 30px;
    }
  }
}

.el-main {
  position: relative;
}

.el-main::after {
  content: "";
  // background: url(https://img1.baidu.com/it/u=2477871273,3251970349&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500) no-repeat;
  background-color: #6eb7ff;
  background-size: cover;
  // background-attachment: fixed;
  // background-size: contain;
  opacity: 0.7;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  position: absolute;
  z-index: -1;
}

.iconfont {
  margin-right: 10px;
}

.el-dropdown-link {
  cursor: pointer;
  color: #fff;
  font-size: 20px;
}
.el-icon-arrow-down {
  font-size: 12px;
}

.icon3 {
  margin-right: 0px;
}
.el-avatar {
  cursor: pointer;
}

.isLook {
  display: block;
  // display: none;
}

</style>
