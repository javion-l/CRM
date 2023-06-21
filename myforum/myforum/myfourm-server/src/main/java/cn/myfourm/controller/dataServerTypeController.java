package cn.myfourm.controller;

import cn.myfourm.entity.RespBean;
import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.dataServerType;
import cn.myfourm.service.dataServerTypeService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Controller
@ResponseBody
@RequestMapping("/dataServerType")
public class dataServerTypeController {
    @Autowired
    private dataServerTypeService dataservertypeService;


    //    分页查询用户列表
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public RespPageBean getServerList(@RequestParam(value = "currentPage",defaultValue = "1")int currentPage, @RequestParam(value = "size",defaultValue = "10")int size){
        return dataservertypeService.getServerList(currentPage,size);
    }

    @RequestMapping(value ="/add",method = RequestMethod.POST)
    public RespBean add(@RequestBody dataServerType dataservertype){
        if(StringUtils.isEmpty(dataservertype.getDstName())){
            return RespBean.error("服务名称为空");
        }
        dataServerType dataservertype1 = dataservertypeService.getOne(new QueryWrapper<dataServerType>().eq("dstName", dataservertype.getDstName()));
        if (dataservertype1 != null) {
            return RespBean.error("服务名称已被使用");
        }
        dataservertype.setDelMark(1);
        boolean save = dataservertypeService.save(dataservertype);
        if (save) return RespBean.success("添加成功");
        return RespBean.error("添加失败");
    }

    //    修改信息
    @RequestMapping(value = "/infoModify",method = RequestMethod.PUT)
    public RespBean changeUser(@RequestBody dataServerType dataservertype) {
        dataServerType dataservertype1 = dataservertypeService.getOne(new QueryWrapper<dataServerType>().eq("dstId", dataservertype.getDstId()));
        if (dataservertype1 != null) {
            boolean update = dataservertypeService.updateById(dataservertype);
            if (update) {
                return RespBean.success("修改信息成功", dataservertype);
            }
        }
        return RespBean.error("该信息不存在");
    }

    @RequestMapping(value = "/delete",method = RequestMethod.DELETE)
    public RespBean deleteUser(@RequestParam("dstId") int id){
        boolean removeById = dataservertypeService.removeById(id);
        if(removeById){
            return RespBean.success("删除成功");
        }
        return RespBean.error("删除失败");
    }

    //    批量删除
    @RequestMapping(value = "/deletebatch",method = RequestMethod.POST)
    public RespBean deleteUser(@RequestBody List<Integer> ids){
        boolean remove = dataservertypeService.removeByIds(ids);
        if(remove){
            return RespBean.success("删除成功");
        }
        return RespBean.error("删除失败");
    }
}
