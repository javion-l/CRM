package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//销售机会表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("salechance")
public class saleChance implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "chanceId", type = IdType.AUTO)
    private Integer chanceId;//销售机会编号

    private String chanceSource;//机会来源

    @NotNull(message = "客户名称不能为空")
    private String chanceCustName;//客户名称

    @NotNull(message = "概要不能为空")
    private String chanceTitle;//概要

    @NotNull(message = "成功机率不能为空")
    private Integer chanceRate;//成功机率(从0到100的数字)

    private String chanceLinkman;//联系人

    private String chanceTel;//联系人电话

    private String chanceDesc;//机会描述

    @NotNull(message = "创建人编号不能为空")
    private Integer chanceCreateId;//创建人编号

    @NotNull(message = "创建日期不能为空")
    private String chanceCreateDate;//创建日期

    private Integer chanceDueId;//指派人编号

    private String chanceDueDate;//指派日期

    @NotNull(message = "销售机会状态不能为空")
    private Integer chanceStatus;//销售机会状态

    @TableField(exist = false)
    private String code;


}
