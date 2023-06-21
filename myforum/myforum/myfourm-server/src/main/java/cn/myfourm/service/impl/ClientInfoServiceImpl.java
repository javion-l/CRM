package cn.myfourm.service.impl;

import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.clientInfo;
import cn.myfourm.mapper.ClientInfoMapper;
import cn.myfourm.service.ClientInfoService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;


@Service
public class ClientInfoServiceImpl extends ServiceImpl<ClientInfoMapper, clientInfo> implements ClientInfoService {
    @Autowired
    private ClientInfoMapper clientInfoMapper;

    //分页查询用户列表
    @Override
    public RespPageBean getClientList(int currentPage, int size) {
        Page<clientInfo> userPage = new Page<>(currentPage,size);
        IPage<clientInfo> userIPage = clientInfoMapper.getClientList(userPage);

//        userIPage.getRecords().forEach(user -> {
//            String areaName=dataareaMapper.getDaName(user.getDaId());
//            user.setDaName(areaName);
//        });
        return new RespPageBean(userIPage.getTotal(), userIPage.getRecords());
    }
}
