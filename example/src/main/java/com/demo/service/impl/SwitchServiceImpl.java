package com.demo.service.impl;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.SwitchDao;
import com.demo.entity.Switch;
import com.demo.service.SwitchService;

@Service
public class SwitchServiceImpl implements SwitchService {
	
	//Sl4j+logback日志输出DEBUG信息
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SwitchDao switchDao;

	//查询全部交换机
	public List<Switch> getinfo(){
		// TODO Auto-generated method stub
		return switchDao.query();
	}

	//增加交换机
	public int addSwitch(Switch sw){
		return switchDao.addSwitch(sw);
	}

	//修改交换机信息
	public int modifySwitch(Switch sw){
		return switchDao.modifySwitch(sw);
	}

	//通过ID查找交换机
	public Switch querySwitchById(int id){
		return switchDao.querySwitchById(id);
	}

	//删除交换机
	public int deleteSwitch(int id){
		return switchDao.deleteSwitch(id);
	}

}
