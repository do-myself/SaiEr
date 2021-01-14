package com.demo.web;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.entity.AclInfo;
import com.demo.entity.Switch;
import com.demo.service.AclInfoService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class AclController {
	
	@Autowired
	private AclInfoService aclinfoservice;
	
	@RequestMapping(value="listacl")
	public String queryaclist(Model model,
			@RequestParam(defaultValue="1",required=true,value="pageNo")int pageNo)
	{
		/*
		 * 带分页的查询功能
		 */
		int pageSize=4;//每页显示记录数
		PageHelper.startPage(pageNo, pageSize);
		List<AclInfo> aclist=aclinfoservice.queryall();
		PageInfo<AclInfo> pageInfo=new PageInfo<AclInfo>(aclist);
	    model.addAttribute("pageInfo",pageInfo);
	    return "aclPage";
	}
	
	/*
	 * 防御模块-添加acl
	 */
	@RequestMapping(value="add")
	public String getaddurl() {
		return "Addacl";
	}
	
	/*
	 * 与floodlight控制器进行交互，将防御策略发送至控制器
	 */
	@RequestMapping(value="addaccess",method=RequestMethod.POST)
	public String addAcl(HttpServletRequest request, HttpServletResponse response) {
	    //boolean number=aclinfoservice.add(a);
	    
	    StringBuffer sb=new StringBuffer();	
		String s=null;
		String strategory = request.getParameter("category1");
		String sport = request.getParameter("sport");
		String ipsrc = request.getParameter("ipsrc");
		String ipdst = request.getParameter("ipdst");
		String action = request.getParameter("action");
		System.out.println("策略类别 :"+strategory+";"+"名称 :"+sport+";"+"源IP网段 :"+ipsrc+";"+
		"目的IP"+ipdst+";"+"指令"+action);
		sb.append(strategory);
		sb.append(" ");
		sb.append(sport);
		sb.append(" ");
		sb.append(ipsrc);
		sb.append(" ");
		sb.append(ipdst);
		sb.append(" ");
		sb.append(action);
		s=sb.toString();
		
		//通过Socket与floodlight建立通信
//		 try {
//			Socket ss=new Socket("192.168.60.132",6060);
//	        BufferedReader br=new BufferedReader(new InputStreamReader(ss.getInputStream()));
//	        BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(ss.getOutputStream()));
//	        bw.write(s);
//
//	        bw.close();
//	        br.close();
//	        ss.close();
//            System.out.println(s);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
    return "success";
		 
	   // if(number) {
	   // 	return  "success";
	  //  }else {
	    //	return "error";
	  //  }
	}

	/*
	 * 删除acl
	 */
	@RequestMapping(value="delete")
	public String getdelurl() {
		return "Delacl";
	}
	
	@RequestMapping(value="deleteaccess",method=RequestMethod.POST)
	public String delAcl(int id) {
		boolean c=aclinfoservice.del(id);
		if(c) {
			return "success";
		}else {
			return "error";
		}
	}
}
