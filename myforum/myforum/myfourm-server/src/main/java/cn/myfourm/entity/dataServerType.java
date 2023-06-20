package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//数据字典-服务类别表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dataservertype")
public class dataServerType implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "dstId", type = IdType.AUTO)
    private Integer dstId;//服务类别编号

    @NotNull(message = "服务类别名称不能为空")
    private String dstName;//服务类别名称

    @NotNull(message = "不能为空")
    private Integer delMark;//删除标记


    @TableField(exist = false)
    private String code;


}
