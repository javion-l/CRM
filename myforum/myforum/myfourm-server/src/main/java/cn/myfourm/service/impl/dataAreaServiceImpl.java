package cn.myfourm.service.impl;

import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.dataArea;
import cn.myfourm.entity.sysUser;
import cn.myfourm.mapper.dataAreaMapper;
import cn.myfourm.mapper.sysUserMapper;
import cn.myfourm.service.dataAreaService;
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
public class dataAreaServiceImpl extends ServiceImpl<dataAreaMapper, dataArea> implements dataAreaService {
    @Autowired
    private dataAreaMapper dataareaMapper;

    @Override
    public String getDaName(int daId) {
        return dataareaMapper.getDaName(daId);
    }

    @Override
    public List<dataArea> getArea() {
        QueryWrapper<dataArea> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("delMark", 1);
        List<dataArea> areas=dataareaMapper.selectList(queryWrapper);
        return areas;
    }

    @Override
    public RespPageBean getAreaList(int currentPage, int size) {
        Page<dataArea> userPage = new Page<>(currentPage,size);
        IPage<dataArea> userIPage = dataareaMapper.getAreaList(userPage);
        return new RespPageBean(userIPage.getTotal(), userIPage.getRecords());
    }
}
