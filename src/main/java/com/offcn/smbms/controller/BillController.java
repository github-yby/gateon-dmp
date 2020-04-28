package com.offcn.smbms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.smbms.pojo.Bill;
import com.offcn.smbms.pojo.User;
import com.offcn.smbms.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/bill")
public class BillController {
    @Autowired
    private BillService billService;
    @RequestMapping("/list")
    public String list(Model model,
                       @RequestParam(value = "productName",required = false,defaultValue = "") String productName,
                       @RequestParam(value = "providerId",required = false,defaultValue = "0") int providerId,
                       @RequestParam(value = "ispayment",required = false,defaultValue = "0")int ispayment,
                       @RequestParam(value = "pageNum",required = false,defaultValue = "1")int pageNum,
                       @RequestParam(value = "size",required = false,defaultValue = "5")int size){
        //先设置分页参数
        PageHelper.startPage(pageNum,size);
        List<Bill> list = billService.list(productName,providerId,ispayment);
        //创建分页信息对象
        PageInfo page = new PageInfo(list);
        model.addAttribute("page",page);
        model.addAttribute("list",list);
        return "billList";
    }
    @RequestMapping("/tosave")
    public String toSave(){
        return "billAdd";
    }
    @RequestMapping("/save")
    @ResponseBody
    public String save(Bill bill, HttpSession session){
        try{
            User user = (User)session.getAttribute("user");
            bill.setCreatedBy(user.getId());
            bill.setCreationDate(new Date());
            int row = billService.save(bill);
            if(row > 0){
                return "true";
            }else{
                return "false";
            }
        }catch (Exception e){
            return "false";
        }
    }
    @RequestMapping("/toupdate")
    public String toUpdate(Model model,int id){
        Bill bill = billService.getById(id);
        model.addAttribute("bill",bill);
        return "billUpdate";
    }
    @RequestMapping("/update")
    @ResponseBody
    public String update(Bill bill, HttpSession session){
        User user = (User)session.getAttribute("user");
        bill.setModifyBy(user.getId());
        bill.setModifyDate(new Date());
        System.out.println(bill);
        int row = billService.update(bill);
        try{
            if(row > 0){
                return "true";
            }else{
                System.out.println("修改失败了");
                return "false";
            }
        }catch (Exception e){
            System.out.println("异常了");
            return "false";
        }
    }
    @RequestMapping("/remove")
    @ResponseBody
    public String remove(int id){
        int row = billService.remove(id);
        if(row > 0){
            return "true";
        }
        return "false";
    }
    @RequestMapping("/toshow")
    public String toshow(Model model,int id){
        Bill bill = billService.getById(id);
        model.addAttribute("bill",bill);
        return "billView";
    }
}
