<!--用户列表-->
<template>
    <div>
        <el-card class="box-card" style="width: 100%">
            <el-breadcrumb style="margin-bottom:15px;" separator="/">
                <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item :to="{ path: '/' }">基础数据</el-breadcrumb-item>
                <el-breadcrumb-item>数据字典-企业客户等级</el-breadcrumb-item>
            </el-breadcrumb>
            <el-divider></el-divider>

            <!-- 添加信息 -->
            <el-form :inline="true" :model="formInline" class="demo-form-inline">
                <el-form-item>
                    <div>
                        <el-button type="primary" @click="dialogFormVisible = true">添加 <i class="el-icon-circle-plus-outline"></i></el-button>
                        <el-button type="danger" @click="deleteBatch">批量删除 <i class="el-icon-remove-outline"></i></el-button>
                    </div>
                    <!--          添加用户弹出框-->
                    <el-dialog
                            title="添加等级"
                            :visible.sync="dialogFormVisible"
                            width="40%"
                            append-to-body
                            center
                    >

                        <el-form
                                :model="form"
                                style=":form"
                        >
                            <el-form-item
                                    label="等级名称:"
                                    :label-width="formLabelWidth"
                                    prop="dclName"
                            >
                                <el-input v-model.trim="form.dclName" autocomplete="off"></el-input>
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
                    title="修改等级名称"
                    :visible.sync="dialogFormVisible1"
                    width="40%"
                    append-to-body
                    center
            >

                <el-form
                        :model="form1"
                        style=":form1"
                >
                    <el-form-item
                            label="等级编号:"
                            :label-width="formLabelWidth"
                            prop="dclId"
                    >
                        <el-input
                                v-model="form1.dclId"
                                autocomplete="off"
                                disabled
                        ></el-input>
                    </el-form-item>
                    <el-form-item
                            label="等级名称:"
                            :label-width="formLabelWidth"
                            prop="dclName"
                    >
                        <el-input
                                v-model="form1.dclName"
                                autocomplete="off"
                        ></el-input>
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
                    style="width: 45%"
                    @selection-change="handleSelectionChange">
                >
                <el-table-column
                        type="selection"
                        width="50">
                </el-table-column>
                <el-table-column prop="dclId" label="等级编号" width="150">
                </el-table-column>
                <el-table-column prop="dclName" label="等级名称" width="150">
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


        },


        data() {
            return {


                multipleSelection:[],
                total: 1000,
                // 分页
                //currentPage: 1, //初始页
                pagesize: 5, //每页多少数据
                currentPage: 1, //默认当前页为第一页
                //添加用户对话框
                dialogFormVisible: false,
                form: {
                    dclId:"1",
                    dclName:"",
                },
                //修改用户的对话框
                dialogFormVisible1: false,
                form1: {
                    dclId:"",
                    dclName:"",
                },
                formLabelWidth: "100px",
                formInline: {
                    user: "",
                },
                tableData: [],

            };
        },

        methods: {
            //this.jump("/404");
            jump(path) {
                this.$router.push(path);
            },
            // 获取第一页表格数据
            async userdata() {

                const result = await this.$http.get(
                    `/dataClientLevel/list?currentPage=${1}&size=${5}`,{
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
                const result = await this.$http.get(
                    `/dataClientLevel/list?currentPage=${val}&size=${5}`,{
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

            },


            // 添加用户信息
            async submitadd() {
                const result = await this.$http.post("/dataClientLevel/add", this.form,{
                    headers: {
                        Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
                    }
                });
                if (result.data.code === 200) {
                    this.$message.success("添加成功!");
                    this.userdata();
                    this.$forceUpdate();
                    this.dialogFormVisible = false;
                    //清除数据
                    this.form = {
                        dclId:"1",
                        dclName:"",
                    }
                } else {
                    this.$message.error(result.data.message);
                }
            },

            // 修改用户信息
            async editdetail() {
                const result = await this.$http.put("/dataClientLevel/infoModify", this.form1,{
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
            deteleUser(clientlevel) {
                this.$confirm("此操作将永久删除, 是否继续?", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning",
                })
                    .then(async () => {
                        const result = await this.$http.delete("/dataClientLevel/delete?dclId=" + clientlevel.dclId,{
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
                let ids = this.multipleSelection.map(v=>v.dclId);
                this.$confirm("此操作将永久删除, 是否继续?", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning",
                })
                    .then(async () => {
                        const result = await this.$http.post("/dataClientLevel/deletebatch" , ids ,{
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
