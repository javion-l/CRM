import Vue from 'vue'
import VueRouter from 'vue-router'
// import store from '@/store'
// import router from '@/router'
Vue.use(VueRouter)
const routes = [
    {
        path:'/',
        // component:()=>import('@/views/login')
        redirect:'/login'
    },
    {
        path:'/login',
        component:()=>import('@/views/login')
    },
    {
        path:'/loginEmail',
        component:()=>import('@/views/login/loginEmail.vue')
    },
    {
        path: "/register",
        component: () => import("@/views/register"),
    },
    {
        path:'/page',
        component:()=>import('@/views/page'),
        children:[
            {
                path:'/',
                component:()=>import('@/views/home')
            },
            {
                path:'/home',
                component:()=>import('@/views/home')
            },
            {
                path:'/userdetail',
                component:()=>import('@/views/BaseData/user')
            },
            {
                path:'/area',
                component:()=>import('@/views/BaseData/area')
            },
            {
                path:'/serve',
                component:()=>import('@/views/BaseData/serve')
            },
            {
                path:'/level',
                component:()=>import('@/views/BaseData/level')
            },
            {
                path:'/UnDueRequest',
                component:()=>import('@/views/Request/UnDue')
            },
            {
                path:'/PendingRequest',
                component:()=>import('@/views/Request/Pending')
            },
            {
                path:'/FeedbackRequest',
                component:()=>import('@/views/Request/Feedback')
            },
            {
                path:'/ArchivedRequest',
                component:()=>import('@/views/Request/Archived')
            },
            {
                path:'/edituser',
                // 编辑个人资料
                component:()=>import('@/components/editdetail.vue')
            },
            {
                path:'/changepwd',
                // 修改密码
                component:()=>import('@/components/changepassword.vue')
            },
            {
                path:'/404',
                component:()=>import('@/views/404.vue')
            },

        ]
    }
]
const routers = new VueRouter({routes})
routers.beforeEach(async (to, from, next) => {
    var userinfo = JSON.parse(localStorage.getItem('userdata'))
    console.log(userinfo)

    if(userinfo){
        if (to.path === '/login' || to.path === '/loginEmail' || to.path === '/register') {
            next('/home')
        } else {
            next()
        }
    }else{//未登录只能去登陆注册
        if (to.path === '/login' || to.path === '/loginEmail' || to.path === '/register') {
            next()
        } else {
            next('/login')
        }
    }
})
export default routers