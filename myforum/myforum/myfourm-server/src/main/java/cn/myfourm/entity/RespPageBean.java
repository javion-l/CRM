package cn.myfourm.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

/*
 * 分页返回对象
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RespPageBean {

    private Long  total;//总条数

    private List<?> data;//数据

}