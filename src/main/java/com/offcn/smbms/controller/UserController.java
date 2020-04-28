package com.offcn.smbms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.smbms.pojo.User;
import com.offcn.smbms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;
import java.nio.channels.SeekableByteChannel;
import java.time.temporal.Temporal;
import java.util.Date;
import java.util.List;

@RequestMapping("/user")
@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @RequestMapping("/login")
    @ResponseBody
    public String login(String userCode, String userPassword, HttpSession session){
        User user = userService.login(userCode, userPassword);
        if(user != null){
            session.setAttribute("user",user);
            return "true";
        }
        return "false";
    }
    @RequestMapping("/list")
    public String list(Model model,@RequestParam(value = "userName",required = false,defaultValue = "") String userName,
                       @RequestParam(value = "pageNum",required = false,defaultValue = "1") int pageNum,
                       @RequestParam(value = "size",required = false,defaultValue = "5") int size){

        PageHelper.startPage(pageNum,size);
        List<User> list = userService.list(userName);
        PageInfo<User> page = new PageInfo<>(list);
        model.addAttribute("page",page);
        model.addAttribute("list",list);
        return "userList";
    }
    @RequestMapping("/tosave")
    public String tosave(){
        return "userAdd";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String save(User user,HttpSession session){
        try {
            User user1 = (User)session.getAttribute("user");
            if(user1==null){
                return "noLogin";
            }
            user.setCreatedBy(user1.getId());
            user.setCreationDate(new Date());
            int row = userService.save(user);
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
        User user = userService.getById(id);
        model.addAttribute("user",user);
        return "userView";
    }
    @RequestMapping("/remove")
    @ResponseBody
    public String remove(int id){
        try {
            int row = userService.remove(id);
            if(row > 0){
                return "true";
            }else {
                return "false";
            }
        }catch (Exception e){
            return "false";
        }
    }

    @RequestMapping("/toupdate")
    public String toupdate(Model model,int id){
        User user = userService.getById(id);
        model.addAttribute("user",user);
        return "userUpdate";
    }

    @RequestMapping("/update")
    @ResponseBody
    public String update(User user,HttpSession session){
        try {
            User user1 = (User)session.getAttribute("user");
            user.setModifyDate(new Date());
            user.setModifyBy(user1.getId());
            System.out.println(user);
            int row = userService.update(user);
            if(row > 0){
                return "true";
            }else{
                return "false";
            }
        }catch (Exception e){
            return "false";
        }
    }
    @RequestMapping("/password")
    public String topassword(){
        return "password";
    }
    @RequestMapping("/updatePassword")
    @ResponseBody
    public String updatePassword(User user, HttpSession session){
        User sessionUser = (User)session.getAttribute("user");
        if(sessionUser != null || !sessionUser.equals("")){

        }
        return "";
    }
}
