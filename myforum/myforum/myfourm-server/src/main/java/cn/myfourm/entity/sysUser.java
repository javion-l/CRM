package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//系统用户表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sysuser")
public class sysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "userId", type = IdType.AUTO)
    private Integer userId;//用户编号

    @NotNull(message = "用户名不能为空")
    private String userName;//用户名称

    @NotNull(message = "密码不能为空")
    private String userPassword;//密码

    private Integer userRoleId;//权限
    //0是系统管理员，1是销售主管，2是客户经理，3是高管

    @TableField(exist = false)
    private String roleName;//权限对应的角色名称

    private Integer daId;//用户所属地区

    @TableField(exist = false)
    private String daName;//所属地区名称

    private Integer delMark;//删除标记，1不删除，0删除

    private String email;

    private String avatar;//头像地址

    @TableField(exist = false)
    private String code;

    @TableField(exist = false)
    private String token;//token令牌

    @TableField(fill = FieldFill.INSERT)
    private Date gmtCreate;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;

}
