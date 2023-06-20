
package cn.myfourm.mapper;

import cn.myfourm.entity.dataClientLevel;
import cn.myfourm.entity.dataServerType;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface dataClientLevelMapper extends BaseMapper<dataClientLevel> {
    IPage<dataClientLevel> getLevelList(@Param("page") Page<dataClientLevel> userPage);
}
