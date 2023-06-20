package cn.myfourm.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
//客户联系人表
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("clientlinkman")
public class clientLinkman implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "clientLinkmanId", type = IdType.AUTO)
    private Integer clientLinkmanId;//客户联系人编号

    @NotNull(message = "客户联系人姓名不能为空")
    private String clientLinkmanName;//客户联系人姓名

    @NotNull(message = "客户联系人性别不能为空")
    private Integer clientLinkmanSex;//客户联系人性别

    @NotNull(message = "客户联系人职位不能为空")
    private String clientLinkmanJob;//客户联系人职位

    @NotNull(message = "客户联系人办公电话不能为空")
    private String clientLinkmanTel;//客户联系人办公电话

    private String clientLinkmanMobile;//客户联系人手机
    private String remark;//备注

    @NotNull(message = "客户编号不能为空")
    private String clientCode;//客户编号


    @TableField(exist = false)
    private String code;


}
