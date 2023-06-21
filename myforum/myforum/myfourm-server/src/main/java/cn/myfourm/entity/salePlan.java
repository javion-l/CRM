package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
//销售机会执行计划项表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("saleplan")
public class salePlan implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "planId", type = IdType.AUTO)
    private Integer planId;//销售机会执行计划编号

    @NotNull(message = "所属销售机会编号不能为空")
    private Integer planChcId;//所属销售机会编号

    @NotNull(message = "执行内容不能为空")
    private String planTodo;//执行内容

    private String planResult;//执行结果

    @TableField(exist = false)
    private String code;


}
