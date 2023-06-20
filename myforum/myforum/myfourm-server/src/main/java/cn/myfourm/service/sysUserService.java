package cn.myfourm.service;

import cn.myfourm.entity.RespBean;
import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.sysUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;


public interface sysUserService extends IService<sysUser> {

    RespPageBean getUserList(int currentPage, int size);

    RespBean sendEmailCode(String email);

    RespPageBean conditionSelect(int currentPage, int size,String username,String email);
}
