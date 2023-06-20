

package cn.myfourm.service.impl;

import cn.hutool.core.util.RandomUtil;
import cn.myfourm.entity.RespBean;
import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.sysUser;
import cn.myfourm.mapper.dataAreaMapper;
import cn.myfourm.mapper.sysUserMapper;
import cn.myfourm.service.sysUserService;
import cn.myfourm.utils.JwtUtil;
import cn.myfourm.utils.RedisUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class sysUserServiceImpl extends ServiceImpl<sysUserMapper, sysUser> implements sysUserService {
    @Autowired
    private sysUserMapper sysuserMapper;
    @Autowired
    private dataAreaMapper dataareaMapper;
    @Autowired
    JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Autowired
    private RedisUtils redisUtils;


    //分页查询用户列表
    @Override
    public RespPageBean getUserList(int currentPage, int size) {
        Page<sysUser> userPage = new Page<>(currentPage,size);
        IPage<sysUser> userIPage = sysuserMapper.getUserList(userPage);
        //按用户的权限给用户的身份赋值
        userIPage.getRecords().forEach(user -> {
            if (user.getUserRoleId() == 1) {
                user.setRoleName("系统管理员");
            } else if (user.getUserRoleId() == 2) {
                user.setRoleName("销售主管");
            }else if (user.getUserRoleId() == 3) {
                user.setRoleName("客户经理");
            }else if (user.getUserRoleId() == 4) {
                user.setRoleName("高管");
            }
        });
        userIPage.getRecords().forEach(user -> {
            String areaName=dataareaMapper.getDaName(user.getDaId());
            user.setDaName(areaName);
        });
        return new RespPageBean(userIPage.getTotal(), userIPage.getRecords());
    }



    @Override
    public RespBean sendEmailCode(String email) {
        SimpleMailMessage message=new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(email);
        message.setSentDate(new Date());
        message.setSubject("【CRM客户管理系统】验证码");
        String code = RandomUtil.randomNumbers(4);
        message.setText("您的验证码是："+code+"，有效期5分钟，请勿泄漏给他人");
        System.out.println(email);
        try{
            javaMailSender.send(message);
        }catch (Exception e){
            return RespBean.error("发送失败");
        }
        //原先的验证码失效
        if(redisUtils.hasKey(email)){
            redisUtils.del(email);
        }
        //新验证码，五分钟失效
        redisUtils.set(email,code,3000);

        return RespBean.success("发送成功");
    }

    //条件查询
    @Override
    public RespPageBean conditionSelect(int currentPage, int size,String username,String email){
        Page<sysUser> userPage = new Page<>(currentPage,size);
        IPage<sysUser> userIPage = sysuserMapper.conditionSelect(userPage,username,email);
        //按用户的权限给用户的身份赋值
        userIPage.getRecords().forEach(user -> {
            if (user.getUserRoleId() == 1) {
                user.setRoleName("系统管理员");
            } else if (user.getUserRoleId() == 2) {
                user.setRoleName("销售主管");
            }else if (user.getUserRoleId() == 3) {
                user.setRoleName("客户经理");
            }else if (user.getUserRoleId() == 4) {
                user.setRoleName("高管");
            }
        });
        userIPage.getRecords().forEach(user -> {
            String areaName=dataareaMapper.getDaName(user.getDaId());
            user.setDaName(areaName);
        });
        return new RespPageBean(userIPage.getTotal(), userIPage.getRecords());
    }
}
