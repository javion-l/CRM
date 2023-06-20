package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//客户服务信息表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("clientserver")
public class clientServer implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "serverId", type = IdType.AUTO)
    private Integer serverId;//服务编号

    @NotNull(message = "服务类型编号不能为空")
    private Integer serverTypeId;//服务类型编号

    @NotNull(message = "概要不能为空")
    private String serverTitle;//概要

    @NotNull(message = "客户编号不能为空")
    private String clientCode;//客户编号

    @NotNull(message = "服务状态不能为空")
    private Integer serverStatus;//服务状态

    @NotNull(message = "服务请求的内容不能为空")
    private String serverContent;//服务请求的内容

    @NotNull(message = "创建人编号不能为空")
    private Integer serverCreateId;//创建人编号

    @NotNull(message = "创建日期不能为空")
    private String serverCreateDate;//创建日期

    @NotNull(message = "创建人编号不能为空")
    private Integer serverDueId;//指派人编号

    private String serverDueDate;//指派日期
    private String serverProcessing;//服务处理内容
    private String processingDate;//处理日期
    private String processingResult;//反馈结果

    @NotNull(message = "反馈结果满意度不能为空")
    private Integer clientContentment;//反馈结果满意度

    @TableField(exist = false)
    private String code;


}
