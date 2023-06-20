
package cn.myfourm.mapper;

import cn.myfourm.entity.dataArea;
import cn.myfourm.entity.dataServerType;
import cn.myfourm.entity.sysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface dataServerTypeMapper extends BaseMapper<dataServerType> {
    IPage<dataServerType> getServerList(@Param("page") Page<dataServerType> userPage);
}
