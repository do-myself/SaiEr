package com.demo.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.StaticFlowDao;
import com.demo.entity.StaticFlow;
import com.demo.service.StaticFlowService;

@Service
public class StaticFlowServiceImpl implements StaticFlowService {
	
	//Sl4j+logback日志输出DEBUG信息
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private StaticFlowDao staticflowDao;

	public boolean insert(StaticFlow staticflow) {
		// TODO Auto-generated method stub
		int a=staticflowDao.insertflow(staticflow);
		if(a==1) {
			return true;
		}else {
			return false;
		}
	}

}
