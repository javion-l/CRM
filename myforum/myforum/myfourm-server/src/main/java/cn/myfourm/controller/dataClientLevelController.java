
package cn.myfourm.controller;

import cn.myfourm.entity.RespBean;
import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.dataClientLevel;
import cn.myfourm.service.dataClientLevelService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Controller
@ResponseBody
@RequestMapping("/dataClientLevel")
public class dataClientLevelController {
    @Autowired
    private dataClientLevelService dataclientlevelService;


    //    分页查询用户列表
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public RespPageBean getLevelList(@RequestParam(value = "currentPage",defaultValue = "1")int currentPage, @RequestParam(value = "size",defaultValue = "10")int size){
        return dataclientlevelService.getLevelList(currentPage,size);
    }

    @RequestMapping(value ="/add",method = RequestMethod.POST)
    public RespBean add(@RequestBody dataClientLevel dataclientlevel){
        if(StringUtils.isEmpty(dataclientlevel.getDclName())){
            return RespBean.error("等级名称为空");
        }
        dataClientLevel dataclientlevel1 = dataclientlevelService.getOne(new QueryWrapper<dataClientLevel>().eq("dclName", dataclientlevel.getDclName()));
        if (dataclientlevel1 != null) {
            return RespBean.error("等级名称已被使用");
        }
        dataclientlevel.setDelMark(1);
        boolean save = dataclientlevelService.save(dataclientlevel);
        if (save) return RespBean.success("添加成功");
        return RespBean.error("添加失败");
    }

    //    修改信息
    @RequestMapping(value = "/infoModify",method = RequestMethod.PUT)
    public RespBean changeUser(@RequestBody dataClientLevel dataclientlevel) {
        dataClientLevel dataclientlevel1 = dataclientlevelService.getOne(new QueryWrapper<dataClientLevel>().eq("dclId", dataclientlevel.getDclId()));
        if (dataclientlevel1 != null) {
            boolean update = dataclientlevelService.updateById(dataclientlevel);
            if (update) {
                return RespBean.success("修改信息成功", dataclientlevel);
            }
        }
        return RespBean.error("该信息不存在");
    }

    @RequestMapping(value = "/delete",method = RequestMethod.DELETE)
    public RespBean deleteUser(@RequestParam("dclId") int id){
        boolean removeById = dataclientlevelService.removeById(id);
        if(removeById){
            return RespBean.success("删除成功");
        }
        return RespBean.error("删除失败");
    }

    //    批量删除
    @RequestMapping(value = "/deletebatch",method = RequestMethod.POST)
    public RespBean deleteUser(@RequestBody List<Integer> ids){
        boolean remove = dataclientlevelService.removeByIds(ids);
        if(remove){
            return RespBean.success("删除成功");
        }
        return RespBean.error("删除失败");
    }
}
