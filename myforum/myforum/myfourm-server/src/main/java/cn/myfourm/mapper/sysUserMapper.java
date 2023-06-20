package cn.myfourm.mapper;
import cn.myfourm.entity.sysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface sysUserMapper extends BaseMapper<sysUser> {
    IPage<sysUser> getUserList(@Param("page")Page<sysUser> userPage);
    IPage<sysUser> conditionSelect(@Param("page")Page<sysUser> userPage,@Param("username")String username,@Param("email")String email);

}
