<!--首页-->
<template>
    <el-card class="box-card">
        <el-breadcrumb style="margin-bottom:15px;" separator="/">
            <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>系统访问量统计</el-breadcrumb-item>
        </el-breadcrumb>
        <el-divider></el-divider>
        <div class="about" style="display: flex">
            <div id="main" style="width: 1000px; height: 500px"></div>
            <div class = "data">
                <div style="font-size:50px;color:#53a3e5;line-height:50px;border-right:solid 1px #fff;"><i class="el-icon-s-management"></i></div>
                <div style="color:#c3cfe2;padding:10px;">总访问量:
                    <div style="color:#53a3e5;font-size:30px;">{{ view }}</div></div>
            </div>
        </div>
    </el-card>
</template>
<script>
    import * as echarts from "echarts";
    export default {
        name: "PageCount",
        data() {
            return {
                hasRole:null,
                pageName:"首页",

                charts: "",
                opinionData: [],
                xData: [],
                view: 0, //访问量
            };
        },

        mounted() {
            // this.$http.get(
            //     `/role/getRole?uid=${JSON.parse(localStorage.getItem('userdata')).id}`,{
            //         headers: {
            //             Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
            //         }
            //     }
            // ).then(res=>{
            //     let RoleName=res.data.obj;
            //     if(RoleName.includes(this.pageName)){
            //         this.hasRole=true;
            //     }else{
            //         this.hasRole=false;
            //     }
            //     if(this.hasRole==false){
            //         this.$message.error("无权访问");
            //         this.jump("/404");
            //         return;
            //     }
            //     this.$nextTick(function () {
            //         this.initEcharts();
            //     });
            // })
        },
        methods: {
            //this.jump("/404");
            jump(path) {
                this.$router.push(path);
            },
            async initEcharts() {
                console.log(JSON.parse(localStorage.getItem('userdata')).token);
                const result = await this.$http.get("/count/list",{
                    headers: {
                        Authorization: "Bearer " + JSON.parse(localStorage.getItem('userdata')).token
                    }
                });
                console.log(result)
                if (result.data.code == 200) {
                    console.log(result.data);
                    let res = result.data.obj;
                    this.opinionData = res.counts;
                    var sum = 0;
                    for (var i = 0; i < res.counts.length; i++) {
                        sum += Number(res.counts[i]);
                    }
                    this.view = sum;
                    this.xData = res.dates;
                    console.log(this.xData);
                    this.charts = echarts.init(document.getElementById("main"));
                    var option = {
                        tooltip: {
                            trigger: 'axis'
                        },
                        grid: {
                            left: '10%',
                            right: '15%',
                            bottom: '15%'
                        },
                        xAxis: {
                            data: this.xData
                        },
                        yAxis: {},
                        dataZoom: [
                            {
                                startValue: '2014-06-01'
                            },
                            {
                                type: 'inside'
                            }
                        ],
                        visualMap: {
                            top: 20,
                            right: 10,
                            pieces: [
                                {
                                    gt: 0,
                                    lte: 50,
                                    color: '#93CE07'
                                },
                                {
                                    gt: 50,
                                    lte: 100,
                                    color: '#FBDB0F'
                                },
                                {
                                    gt: 100,
                                    lte: 150,
                                    color: '#FC7D02'
                                },
                                {
                                    gt: 100,
                                    lte: 150,
                                    color: '#FD0100'
                                }
                            ],
                            outOfRange: {
                                color: '#FD0100'
                            }
                        },
                        series: {
                            name: '访问量',
                            type: 'line',
                            data: this.opinionData,
                            markLine: {
                                silent: true,
                                lineStyle: {
                                    color: '#333'
                                },
                                data: [
                                    {
                                        yAxis: 50
                                    },
                                    {
                                        yAxis: 100
                                    },
                                    {
                                        yAxis: 150
                                    },
                                    {
                                        yAxis: 200
                                    },
                                    {
                                        yAxis: 300
                                    }
                                ]
                            }
                        }
                    }
                    this.charts.setOption(option);
                } else {
                    // this.$message.error(resp.data.message);
                }
            },
        },
    };
</script>

<style lang="less" scoped>
    image {
        width: 100%;
        height: 100%;
    }
    .box-card {
        width: 100%;
        height: 100%;
        // background: url('../static/back.png') no-repeat;
        // background-size: cover;
    }
    .el-table .warning-row {
        background: oldlace;
    }

    .el-table .success-row {
        background: #f0f9eb;
    }
    .input {
        width: 500px;
        // margin-top:50%;
        // display: block;
    }
    .in {
        margin-top: 20%;
    }
    .about {
        height: 100%;
        background-size: cover;
    }
    .data {
        text-align: left;
        margin-left: 20px;
        // background-color: #baccd9;
        background-color: #e9f8ff;
        color: #fff;
        height: 100px;
        width:200px;
        display: flex;
    }
</style>
