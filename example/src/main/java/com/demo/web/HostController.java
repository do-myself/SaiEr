package com.demo.web;

import com.demo.entity.Host;
import com.demo.service.HostService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class HostController {

    @Autowired
    private HostService hostService;

    //所有主机查询
    @RequestMapping(value="/hostList",method= RequestMethod.GET)
    public String pageHostList(ModelMap map, @RequestParam(defaultValue="1",required=true,value="pageNo")int pageNo){
        int pageSize=5;//每页显示记录数
        //交换机信息的分页查询
        PageHelper.startPage(pageNo, pageSize);
        List<Host> hostList = hostService.queryAllHost2();//获取所有主机的信息
        PageInfo<Host> pageHostList=new PageInfo<Host>(hostList);
        map.addAttribute("pageInfo",pageHostList);
        return "hostPage";
    }

    //跳转到主机添加页面
    @RequestMapping("toHostAdd")
    public String toAddHost(){
        System.out.println("===========进入了toAddHost()方法");
        return "hostAdd";
    }

    //主机添加
    @RequestMapping("/addHost")
    public String addHost(Host host){
        int b=hostService.addHost(host);
        if(b>0) {
            return "success";
        }else {
            return "error";
        }
    }

    //删除主机
    @RequestMapping("/deleteHost")
    @ResponseBody
    public String deleteFlowById(int hostId){
        if(hostId<0) return "notexist";
        int i = hostService.deleteHost(hostId);
        String msg;
        if(i>0){
//            hostService.sortKey();
            msg = "true";
        }else{
            msg = "false";
        }
        return msg;
    }

    //跳转到主机修改页面
    @RequestMapping("/toHostModify")
    public String toHostModify(int hostId, Model model){
        Host host = hostService.queryHostById(hostId);
        model.addAttribute("host",host); //传递原主机信息，提示作用
        return "hostModify";
    }

    //修改主机信息
    @RequestMapping("/modifyHost")
    public String hostModify(Host host){
        int i = hostService.modifyHost(host);
        if(i>0) {
            return "success";
        }else {
            return "error";
        }
    }
}
