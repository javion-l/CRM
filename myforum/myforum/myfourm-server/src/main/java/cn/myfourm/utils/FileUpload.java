package cn.myfourm.utils;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;



@Slf4j
@Component
public class FileUpload {
    @Value("${imgPath}")
    private String imgPath;
    @Value("${videoPath}")
    private String videoPath;
    @Value("${virtualVideoUrl}")
    private String virtualVideoUrl;
    @Value("${virtualImgUrl}")
    private String virtualImgUrl;
    //图片格式
    private final static String[] IMG_TYPES = new String[]{
            "jpg", "bmp", "jpeg", "png", "gif",
            "JPG", "BMP", "JPEG", "PNG", "GIF"
    };
    //视频格式
    private final static String[] VIDEO_TYPES = new String[]{
           "flv", "mp5","mp4","mpg","mpeg","avi","rm","rmvb","mov","wmv","asf","dat"
    };

    public String uploadFile(MultipartFile file) throws IOException {

        boolean flag = false,flag1 = false;

        if (file != null) {
            if(file.getOriginalFilename()!=null && !file.getOriginalFilename().equals("")) {
                String suffix = file.getOriginalFilename().split("\\.")[1];
                for (String imgType : IMG_TYPES) {
                    if (suffix.equals(imgType)) {
                        flag = true;
                        break;
                    }
                }
                //如果为真证明是图片
                if (flag) {
                    return groupByFile(virtualImgUrl,file,imgPath);
                }
                for (String videoType : VIDEO_TYPES) {
                    if(suffix.equals(videoType)){
                        flag1 = true;
                        break;
                    }
                }
                if(flag1){
                    return groupByFile(virtualVideoUrl,file,videoPath);
                }
            }
        }
        throw new RuntimeException("没有匹配的文件路径");
    }
        public String groupByFile(String url_perfix,MultipartFile file, String path) throws IOException {
            String fileName = System.currentTimeMillis() + file.getOriginalFilename();
            String upload_file_dir = path;
            String destFileName = path + fileName;
            File upload_file_dir_file = new File(upload_file_dir);
            if (!upload_file_dir_file.exists()) {
                upload_file_dir_file.mkdirs();
            }
            File targetFile = new File(upload_file_dir_file, fileName);
            file.transferTo(targetFile);
            return url_perfix+fileName;
        }

}
