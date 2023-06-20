package cn.myfourm.mapper;

import cn.myfourm.entity.dataArea;
import cn.myfourm.entity.sysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface dataAreaMapper extends BaseMapper<dataArea> {
    String getDaName(@Param("daId") int daId);
    IPage<dataArea> getAreaList(@Param("page")Page<dataArea> userPage);
}
