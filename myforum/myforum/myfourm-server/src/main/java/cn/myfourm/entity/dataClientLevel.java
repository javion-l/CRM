package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//数据字典-企业客户等级表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dataclientlevel")
public class dataClientLevel implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "dclId", type = IdType.AUTO)
    private Integer dclId;//企业客户等级编号

    @NotNull(message = "企业客户等级名称不能为空")
    private String dclName;//企业客户等级名称

    @NotNull(message = "不能为空")
    private Integer delMark;//删除标记


    @TableField(exist = false)
    private String code;


}
