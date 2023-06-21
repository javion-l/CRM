package cn.myfourm.service;

import cn.myfourm.entity.RespPageBean;
import cn.myfourm.entity.clientInfo;
import com.baomidou.mybatisplus.extension.service.IService;

public interface ClientInfoService extends IService<clientInfo> {
    RespPageBean getClientList(int currentPage, int size);
}
