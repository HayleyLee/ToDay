package com.ToDay.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;

public class FileUtil {
    public String SavePhotoFile(MultipartFile file) throws Exception{
            //上传文件路径
            String path = "C:\\userPhoto";
            //上传文件名
            String filename = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            File filepath = new File(path,filename);
            //判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            //将上传文件保存到一个目标文件当中
            file.transferTo(new File(path + File.separator + filename));
            return filename;
    }
    public String SaveVideoFile(MultipartFile file) throws Exception{
            String path = "C:\\userPhoto";
            String filename = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            File filepath = new File(path,filename);
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            file.transferTo(new File(path + File.separator + filename));
            return filename;
    }
    public Integer Delete(File f){
        try{
            boolean res = f.delete();
            if(res){
                return 1;
            }
            else {
                return 0;
            }
        }
        catch(NullPointerException n){
            return 0;
        }
    }
}
