package com.demo.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.AclInfoDao;
import com.demo.entity.AclInfo;
import com.demo.service.AclInfoService;

@Service
public class AclInfoServiceImpl implements AclInfoService {
	
	//Sl4j+logback日志输出DEBUG信息
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AclInfoDao  aclinfoDao;

	public List<AclInfo> queryall() {
		// TODO Auto-generated method stub
		List<AclInfo> l=aclinfoDao.queryacl();
		return l;
	}

	public boolean add(AclInfo acl) {
		// TODO Auto-generated method stub
		int  res=aclinfoDao.acladd(acl);
		if(res==1) {
			return true;
		}else {
			return false;			
		}
	}

	public boolean del(int id) {
		// TODO Auto-generated method stub
		int b=aclinfoDao.acldel(id);
		if(b==1) {
			return true;
		}else {
			return false;			
		}
	}

}
