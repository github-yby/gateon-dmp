package com.offcn.smbms.utils;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FileUploadAndDownloadUtils {
    public static List<File> uploadFile(MultipartFile[] myfiles, String path){
        if(path == null){
            path = "E:\\upload\\";
        }
        List<File> list = new ArrayList<File>();
        if(myfiles.length > 0){
            for(MultipartFile myfile :myfiles){
                if(myfile.getSize() > 0){
                    String filename = myfile.getOriginalFilename();
                    //取到文件后缀名
                    String suffixName = filename.substring(filename.lastIndexOf("."));
                    //定义一个日期开头的名字（年月日时分秒毫秒）
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
                    String format = dateFormat.format(new Date());
                    //获取一个随机数转换成String以后的第4位-第8位之间的四位数
                    String substring = String.valueOf(Math.random()).substring(4, 8);
                    //拼接新文件名字，日期名+随机数4个数字+后缀名
                    filename = format + substring + suffixName;
                    String realPath = path + filename;
                    File file = new File(realPath);
                    try {
                        myfile.transferTo(file);
                        list.add(file);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }else{
            System.out.println("没有要上传的文件");
        }
        return list;
    }
    public static ResponseEntity<byte[]> download(String fileName, String path) throws IOException {
        if(path == null){
            path = "E:\\upload\\";
        }
        //编写文件要下载的具体地址
        String newPath = path + fileName;
        //把path传进去变成一个文件
        File file = new File(newPath);
        //通过文件工具类，读取这个文件到字节数组中
        byte[] bytes = FileUtils.readFileToByteArray(file);
        //设置保存框的编码格式为utf-8格式，中文也不会乱码
        String newName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
        //创建响应头对象
        HttpHeaders headers = new HttpHeaders();
        //设置响应头下载的类型
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        //设置响应头对浏览器的下载界面弹框
        headers.setContentDispositionFormData("attachment",newName);
        //创建一个响应头对象，把文件字节数组，响应头对象放入，并设置响应状态码为OK状态
        ResponseEntity entity = new ResponseEntity(bytes, headers, HttpStatus.OK);
        return entity;
    }
}
