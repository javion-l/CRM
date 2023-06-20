package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//数据字典-地区表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dataarea")
public class dataArea implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "daId", type = IdType.AUTO)
    private Integer daId;//地区编号

    @NotNull(message = "地区名称不能为空")
    private String daName;//地区名称

    @NotNull(message = "不能为空")
    private Integer delMark;//删除标记

    @TableField(exist = false)
    private String code;


}
