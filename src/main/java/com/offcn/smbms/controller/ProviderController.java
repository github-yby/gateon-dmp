package com.offcn.smbms.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.smbms.pojo.Provider;
import com.offcn.smbms.pojo.User;
import com.offcn.smbms.service.ProviderService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jws.WebParam;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.time.temporal.Temporal;
import java.util.Date;
import java.util.List;
@Controller
@RequestMapping("/provider")
public class ProviderController {
    @Autowired
    private ProviderService providerService;
    @RequestMapping("/listJson")
    @ResponseBody
    public String listJson(){
        List<Provider> list = providerService.list("");
        return JSON.toJSONString(list);
    }
    @RequestMapping("/list")
    public String list(Model model,
                       @RequestParam(value = "proName",defaultValue = "",required = false) String proName,
                       @RequestParam(value = "pageNum",defaultValue = "1",required = false) int pageNum,
                       @RequestParam(value = "size",defaultValue = "5",required = false) int size){
        PageHelper.startPage(pageNum,size);
        List<Provider> list = providerService.list(proName);
        PageInfo<Provider> page = new PageInfo<>(list);
        model.addAttribute("page",page);
        model.addAttribute("list",list);
        return "providerList";
    }
    @RequestMapping("/tosave")
    public String tosave(){
        return "providerAdd";
    }
    @RequestMapping("/save")
    @ResponseBody
    public String save(Provider provider, HttpSession session){
        try{
            User user = (User)session.getAttribute("user");
            provider.setCreatedBy(user.getId());
            provider.setCreationDate(new Date());
            int row = providerService.save(provider);
            if(row > 0){
                return "true";
            }else{
                return "false";
            }
        }catch (Exception e){
            return "false";
        }
    }
    //修改
    @RequestMapping("/toupdate")
    public String toupdate(Model model,int id){
        Provider provider = providerService.getById(id);
        model.addAttribute("provider",provider);
        return "providerUpdate";
    }
    @RequestMapping("/update")
    @ResponseBody
    public String update(Provider provider, HttpSession session){
        System.out.println("访问到了");
        try {
            User user = (User)session.getAttribute("user");
            provider.setModifyBy(user.getId());
            provider.setModifyDate(new Date());
            System.out.println(provider);
            int row = providerService.update(provider);
            if(row > 0){
                return "true";
            }else{
                return "false";
            }
        }catch (Exception e){
            return "false";
        }
    }
    @RequestMapping("/remove")
    @ResponseBody
    public String remove(int id){
        try {
            int row = providerService.remove(id);
            if(row > 0){
                return "true";
            }else{
                return "false";
            }
        }catch (Exception e){
            return "false";
        }
    }
    @RequestMapping("/toshow")
    public String toshow(Model model,int id){
        Provider provider = providerService.getById(id);
        model.addAttribute("provider",provider);
        return "providerView";
    }
}
