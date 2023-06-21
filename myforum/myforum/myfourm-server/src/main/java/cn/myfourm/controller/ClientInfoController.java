package cn.myfourm.controller;


import cn.myfourm.entity.RespBean;
import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.dataArea;

import cn.myfourm.service.ClientInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@ResponseBody
@RequestMapping("/clientInfo")
public class ClientInfoController {
    @Autowired
    private ClientInfoService clientInfoService;

    //    分页查询用户列表
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public RespPageBean getAreaList(@RequestParam(value = "currentPage",defaultValue = "1")int currentPage, @RequestParam(value = "size",defaultValue = "10")int size){
        return clientInfoService.getClientList(currentPage,size);
    }


}
