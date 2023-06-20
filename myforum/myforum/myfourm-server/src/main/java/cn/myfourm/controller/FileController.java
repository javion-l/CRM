package cn.myfourm.controller;

import cn.myfourm.entity.RespBean;
import cn.myfourm.utils.FileUpload;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

@Controller
@ResponseBody
@RequestMapping("/file")
public class FileController{
    @Autowired
    private FileUpload fileUpload;

//    上传
    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    public RespBean uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        String url = fileUpload.uploadFile(file);
        if(url.contains("//")){
            return RespBean.success("上传成功",url);
        }
        return RespBean.error("上传失败");
    }

//    下载
    @GetMapping("download")
    public void download(HttpServletResponse response,@RequestParam("fileName")String fileName) throws IOException {
        System.out.println(fileName);
        // 获取文件输入流
        FileInputStream fileInputStream = new FileInputStream(new File("E:/video/"+fileName));
        // 附件下载
        response.setContentType("application/x-download;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8")); // 下载返回的是文件原始名称
        // 获取响应输出流
        ServletOutputStream outputStream = response.getOutputStream();
        // 文件拷贝
        IOUtils.copy(fileInputStream, outputStream);
        IOUtils.closeQuietly(fileInputStream);
        IOUtils.closeQuietly(outputStream);
    }

}
