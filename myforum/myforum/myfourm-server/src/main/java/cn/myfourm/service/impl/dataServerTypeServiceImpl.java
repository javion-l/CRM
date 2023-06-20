
package cn.myfourm.service.impl;

import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.dataArea;
import cn.myfourm.entity.dataServerType;
import cn.myfourm.entity.sysUser;
import cn.myfourm.mapper.dataAreaMapper;
import cn.myfourm.mapper.dataServerTypeMapper;
import cn.myfourm.mapper.sysUserMapper;
import cn.myfourm.service.dataAreaService;
import cn.myfourm.service.dataServerTypeService;
import cn.myfourm.service.sysUserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class dataServerTypeServiceImpl extends ServiceImpl<dataServerTypeMapper, dataServerType> implements dataServerTypeService {
    @Autowired
    private dataServerTypeMapper dataservertypeMapper;

    @Override
    public RespPageBean getServerList(int currentPage, int size) {
        Page<dataServerType> userPage = new Page<>(currentPage,size);
        IPage<dataServerType> userIPage = dataservertypeMapper.getServerList(userPage);
        return new RespPageBean(userIPage.getTotal(), userIPage.getRecords());
    }
}
