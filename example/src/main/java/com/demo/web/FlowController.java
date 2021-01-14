package com.demo.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.entity.OFsflow;
import com.demo.entity.StaticFlow;
import com.demo.service.OFsflowService;
import com.demo.service.StaticFlowService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FlowController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OFsflowService ofsflowservice;
	
	@RequestMapping(value="sflowlist",method=RequestMethod.GET)
	 public String pageList2(ModelMap map,@RequestParam(defaultValue="1",required=true,value="pageNo")int pageNo){
		int pageSize=5;//每页显示记录数
      //流表的分页查询
      	PageHelper.startPage(pageNo, pageSize);
      //Service层的接口-查询
	  	List<OFsflow> flowList  = ofsflowservice.getFlowInfo();
	  	PageInfo<OFsflow> pageInfo=new PageInfo<OFsflow>(flowList);
      //封装到数据模型
      	map.addAttribute("pageInfo", pageInfo);
      //跳转页面
      	return "flowPage";
  	}

	@RequestMapping(value="flowAdd")
	public String redirect(){
		logger.info("insert delete methods is ....");
		return "flowAdd";
	}
	
	@RequestMapping(value="/addFlow",method=RequestMethod.POST)
	public String addflow(OFsflow oFsflow) {
		int b=ofsflowservice.addFlow(oFsflow);
		if(b>0) {
			return "success";
		}else {
			return "error";
		}
	}

	@RequestMapping("/deleteFlow")
	@ResponseBody
	public String deleteFlowById(int flowId){
		if(flowId<0) return "notexist";
		int i = ofsflowservice.deleteFlowById(flowId);
		String msg;
		if(i>0){
			msg = "true";
		}else{
			msg = "false";
		}
		return msg;
	}
}
