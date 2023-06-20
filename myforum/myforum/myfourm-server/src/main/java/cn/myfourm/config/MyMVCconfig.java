package cn.myfourm.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MyMVCconfig implements WebMvcConfigurer {
    //修改虚拟路径映射到本机,依次映射视频和图片路径
    @Value("${imgPath}")
    private String imgPath;
    @Value("${videoPath}")
    private String videoPath;

    //对静态资源的管理，将对img/video的访问都映射到imgPath和videoPath（在yml中声明过了）
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/img/**").addResourceLocations(
                "file:"+imgPath
        );
        registry.addResourceHandler("/video/**").addResourceLocations(
                "file:"+videoPath
        );
    }
}
