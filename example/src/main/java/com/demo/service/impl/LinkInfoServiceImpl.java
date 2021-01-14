package com.demo.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.LinkInfoDao;
import com.demo.entity.LinkInfo;
import com.demo.service.LinkInfoService;

@Service
public class LinkInfoServiceImpl implements LinkInfoService {

	//Sl4j+logback日志输出DEBUG信息
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private LinkInfoDao linkinfoDao;
	public List<LinkInfo> getallink() {
		// TODO Auto-generated method stub
		List<LinkInfo> information=linkinfoDao.querylink();
		return information;
	}

}
