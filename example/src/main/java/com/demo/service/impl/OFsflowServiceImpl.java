package com.demo.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.OFsflowDao;
import com.demo.dao.SwitchDao;
import com.demo.entity.OFsflow;
import com.demo.entity.Switch;
import com.demo.service.OFsflowService;

@Service
public class OFsflowServiceImpl implements OFsflowService {
	
	//Sl4j+logback日志输出DEBUG信息
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private OFsflowDao ofsflowDao;

	//添加流表信息
	public int addFlow(OFsflow oFsflow) {
		return ofsflowDao.addFlow(oFsflow);
	}
	
	//override 获取流表信息
	public List<OFsflow> getFlowInfo(){
		List<OFsflow> sflow=ofsflowDao.getFlow();
		return  sflow;
	}

	//删除流表项
	public int deleteFlowById(int id){
		return ofsflowDao.deleteFlowById(id);
	}

}
