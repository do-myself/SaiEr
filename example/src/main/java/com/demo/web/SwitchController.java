package com.demo.web;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.entity.Switch;
import com.demo.service.SwitchService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SwitchController {
	// 日志记录
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SwitchService switchservice;
	
	@RequestMapping(value="/switchList")
	 public String pageList(ModelMap map,@RequestParam(defaultValue="1",required=true,value="pageNo")int pageNo){
        int pageSize=5;//每页显示记录数
        //交换机信息的分页查询
        PageHelper.startPage(pageNo, pageSize);
        List<Switch> switchList = switchservice.getinfo();//获取所有交换机信息
        PageInfo<Switch> pageInfo=new PageInfo<Switch>(switchList);
        map.addAttribute("pageInfo", pageInfo);
        return "switchPage";
    }

    //跳转到交换机添加页面
    @RequestMapping("/toSwitchAdd")
    public String toSwitchAdd(){
	    return "switchAdd";
    }

    //添加交换机
    @RequestMapping("/addSwitch")
    public String addSwitch(Switch sw){
        int i = switchservice.addSwitch(sw);
        if(i>0){
            return "success";
        }else {
            return "error";
        }
    }

    //跳转到修改交换机界面
    @RequestMapping("/toSwitchModify")
    public String querySwitchById(int switchId,Model model){
        Switch switch_ = switchservice.querySwitchById(switchId);
        model.addAttribute("switch_",switch_);
        return "switchModify";
    }

    //修改交换机信息
    @RequestMapping("/modifySwitch")
    public String modifySwitch(Switch sw){
        int i = switchservice.modifySwitch(sw);
        if(i>0) {
            return "success";
        }else {
            return "error";
        }
    }

    //删除主机
    @RequestMapping("/deleteSwitch")
    @ResponseBody
    public String deleteFlowById(int switchId){
        if(switchId<0) return "notexist";
        int i = switchservice.deleteSwitch(switchId);
        String msg;
        if(i>0){
            msg = "true";
        }else{
            msg = "false";
        }
        return msg;
    }

}
