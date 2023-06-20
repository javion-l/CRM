package cn.myfourm.controller;

import cn.myfourm.entity.RespBean;
import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.sysUser;
import cn.myfourm.service.impl.UserDetailsImpl;
import cn.myfourm.service.sysUserService;
import cn.myfourm.utils.JwtUtil;
import cn.myfourm.utils.RedisUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ResponseBody
@RequestMapping("/user")
public class SysUserController {
    @Autowired
    private sysUserService userService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private RedisUtils redisUtils;

    //    登录
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public RespBean login(@RequestBody sysUser user, HttpServletRequest request){
        if(!StringUtils.isEmpty(user.getUserName())) {
            sysUser one = userService.getOne(new QueryWrapper<sysUser>().eq("userName", user.getUserName()));
            if (null != one) {
                String code = request.getSession().getAttribute("captcha").toString();
                if (StringUtils.isEmpty(code) || !code.equals(user.getCode())) {
                    return RespBean.error("验证码错误");
                }
                Boolean lg=passwordEncoder.matches(user.getUserPassword(),one.getUserPassword());
                if (lg) {
                    String jwt = JwtUtil.createJWT(one.getUserId().toString());
                    one.setToken(jwt);
                    if (one.getUserRoleId() == 0) {
                        one.setRoleName("系统管理员");
                    } else if (one.getUserRoleId() == 1) {
                        one.setRoleName("销售主管");
                    }else if (one.getUserRoleId() == 2) {
                        one.setRoleName("客户经理");
                    }else if (one.getUserRoleId() == 3) {
                        one.setRoleName("高管");
                    }
                    return RespBean.success("登录成功", one);
                } else {
                    return RespBean.error("密码错误");
                }
            }
        }
        return RespBean.error("用户名不存在");
    }


    //    登录
    @RequestMapping(value = "/loginEmail",method = RequestMethod.POST)
    public RespBean loginEmail(@RequestBody sysUser user, HttpServletRequest request){

            if(StringUtils.isEmpty(user.getEmail())){
                return RespBean.error("邮箱为空");
            }
            if(StringUtils.isEmpty(user.getCode())){
                return RespBean.error("验证码为空");
            }
            String email = user.getEmail();
            String code = user.getCode();
            String truecode = "";
            if(!redisUtils.hasKey(email)){
                return RespBean.error("验证码错误或已失效");
            }else{
                truecode = redisUtils.get(email).toString();
            }
            if(code.equals(truecode)){
                sysUser one = userService.getOne(new QueryWrapper<sysUser>().eq("email", email));
                if(one == null){
                    return RespBean.error("用户不存在");
                }
                String jwt = JwtUtil.createJWT(one.getUserId().toString());
                one.setToken(jwt);
                if (one.getUserRoleId() == 0) {
                    one.setRoleName("系统管理员");
                } else if (one.getUserRoleId() == 1) {
                    one.setRoleName("销售主管");
                }else if (one.getUserRoleId() == 2) {
                    one.setRoleName("客户经理");
                }else if (one.getUserRoleId() == 3) {
                    one.setRoleName("高管");
                }
                //验证码删掉
                redisUtils.del(email);
                return RespBean.success("登录成功", one);
            }else{
                return RespBean.error("验证码错误或已失效");
            }
    }

    //    注册
    @RequestMapping(value ="/register",method = RequestMethod.POST)
    public RespBean register(@RequestBody sysUser user){

        if(StringUtils.isEmpty(user.getEmail())){
            return RespBean.error("邮箱为空");
        }
        if(StringUtils.isEmpty(user.getCode())){
            return RespBean.error("验证码为空");
        }
        String email = user.getEmail();
        String code = user.getCode();
        String truecode = "";
        if(!redisUtils.hasKey(email)){
            return RespBean.error("验证码错误或已失效");
        }else{
            truecode = redisUtils.get(email).toString();
        }
        if(!code.equals(truecode)){
            return RespBean.error("验证码错误或已失效");
        }
        sysUser user1 = userService.getOne(new QueryWrapper<sysUser>().eq("userName", user.getUserName()));
        sysUser user2 = userService.getOne(new QueryWrapper<sysUser>().eq("email", email));
        if (user1 != null) {
            return RespBean.error("用户名已被使用");
        }
        if (user2 != null) {
            return RespBean.error("邮箱已被使用");
        }
        String password=passwordEncoder.encode(user.getUserPassword());
        user.setUserPassword(password);
        userService.save(user);
        String jwt = JwtUtil.createJWT(user.getUserId().toString());
        user.setToken(jwt);
        redisUtils.del(email);
        boolean save = userService.updateById(user);
        if (save) return RespBean.success("注册成功");
        return RespBean.error("注册信息失败");
    }

    //    发送验证码
    @RequestMapping(value = "/email/{email}",method = RequestMethod.POST)
    public RespBean sendEmailCode(@PathVariable String email){
        if (StringUtils.isEmpty(email)) {
            return RespBean.error("邮箱为空");
        }
        return userService.sendEmailCode(email);
    }

    @RequestMapping(value ="/info",method = RequestMethod.GET)
    public sysUser getinfo() {
        UsernamePasswordAuthenticationToken authentication =
                (UsernamePasswordAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();

        UserDetailsImpl loginUser = (UserDetailsImpl) authentication.getPrincipal();
        int uid = loginUser.getUser().getUserId();
        return userService.getById(uid);
    }

//    修改密码
    @RequestMapping(value = "/pwdModify",method = RequestMethod.POST)
    public RespBean changePassword(@RequestBody sysUser user){
        if(StringUtils.isEmpty(user.getCode())){
            return RespBean.error("验证码为空");
        }
        String email = user.getEmail();
        String code = user.getCode();
        String truecode = "";
        if(!redisUtils.hasKey(email)){
            return RespBean.error("验证码错误或已失效");
        }else{
            truecode = redisUtils.get(email).toString();
        }
        if(!code.equals(truecode)){
            return RespBean.error("验证码错误或已失效");
        }
        redisUtils.del(email);
        String password=passwordEncoder.encode(user.getUserPassword());
        user.setUserPassword(password);
        boolean update = userService.updateById(user);
        if(update){
            return RespBean.success("修改密码成功");
        }
        return RespBean.error("修改密码失败");
    }

    //    修改邮箱
    @RequestMapping(value = "/emailModify",method = RequestMethod.POST)
    public RespBean changeEmail(@RequestBody sysUser user){
        if(StringUtils.isEmpty(user.getCode())){
            return RespBean.error("验证码为空");
        }
        String email = user.getEmail();
        String code = user.getCode();
        String truecode = "";
        if(!redisUtils.hasKey(email)){
            return RespBean.error("验证码错误或已失效");
        }else{
            truecode = redisUtils.get(email).toString();
        }
        if(!code.equals(truecode)){
            return RespBean.error("验证码错误或已失效");
        }
        redisUtils.del(email);
        sysUser user1 = userService.getOne(new QueryWrapper<sysUser>().eq("email", user.getEmail()));
        if (user1 != null) {
            return RespBean.error("邮箱已被使用");
        }
        sysUser us = userService.getById(user.getUserId());
        us.setEmail(user.getEmail());
        boolean update = userService.updateById(us);
        if(update){
            return RespBean.success("修改邮箱成功");
        }
        return RespBean.error("修改邮箱失败");
    }

    //    根据id查询用户
    @RequestMapping(value = "/finduser",method = RequestMethod.GET)
    public RespBean find(@RequestParam("id") int id){
        sysUser user = userService.getById(id);
        if(user!=null){
            return RespBean.success("查询成功",user);
        }
        return RespBean.error("查询失败");
    }

//    修改信息
    @RequestMapping(value = "/infoModify",method = RequestMethod.PUT)
    public RespBean changeUser(@RequestBody sysUser user) {
        sysUser user1 = userService.getOne(new QueryWrapper<sysUser>().eq("userName", user.getUserName()));
        if (user1 != null) {
            boolean update = userService.updateById(user);
            if (update) {
                return RespBean.success("修改信息成功", user);
            }
        }
        return RespBean.error("账号不存在");
    }

//    删除用户
    @RequestMapping(value = "/delete",method = RequestMethod.DELETE)
    public RespBean deleteUser(@RequestParam("userId") int id){
        boolean removeById = userService.removeById(id);
        if(removeById){
            return RespBean.success("删除成功");
        }
        return RespBean.error("删除失败");
    }

    //    批量删除
    @RequestMapping(value = "/deletebatch",method = RequestMethod.POST)
    public RespBean deleteUser(@RequestBody List<Integer> ids){
        boolean remove = userService.removeByIds(ids);
        if(remove){
            return RespBean.success("删除成功");
        }
        return RespBean.error("删除失败");
    }


    //    分页查询用户列表
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public RespPageBean getUserList(@RequestParam(value = "currentPage",defaultValue = "1")int currentPage, @RequestParam(value = "size",defaultValue = "10")int size){
        return userService.getUserList(currentPage,size);
    }


    //    条件查询
    @RequestMapping(value = "/conditionSelect",method = RequestMethod.GET)
    public RespPageBean conditionSelect(@RequestParam(value = "currentPage")int currentPage, @RequestParam(value = "size")int size, @RequestParam(value = "userName")String username_select, @RequestParam(value = "email")String email_select){
        return userService.conditionSelect(currentPage,size,username_select,email_select);
    }

    //管理员添加用户
    @RequestMapping(value ="/adminregister",method = RequestMethod.POST)
    public RespBean adminregister(@RequestBody sysUser user){
        if(StringUtils.isEmpty(user.getEmail())){
            return RespBean.error("邮箱为空");
        }
        sysUser user1 = userService.getOne(new QueryWrapper<sysUser>().eq("username", user.getUserName()));
        sysUser user2 = userService.getOne(new QueryWrapper<sysUser>().eq("email", user.getEmail()));
        if (user1 != null) {
            return RespBean.error("用户名已被使用");
        }
        if (user2 != null) {
            return RespBean.error("邮箱已被使用");
        }
        String password=passwordEncoder.encode(user.getUserPassword());
        user.setUserPassword(password);
        userService.save(user);
        String jwt = JwtUtil.createJWT(user.getUserId().toString());
        user.setToken(jwt);
        boolean save = userService.updateById(user);
        if (save) return RespBean.success("注册成功");
        return RespBean.error("注册信息失败");
    }


}
