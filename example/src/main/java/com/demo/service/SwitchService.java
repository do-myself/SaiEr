package com.demo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.demo.entity.Switch;


public interface SwitchService {

	//查询全部交换机
	public List<Switch> getinfo();

	//增加交换机
	public int addSwitch(Switch sw);

	//修改交换机信息
	public int modifySwitch(Switch sw);

	//通过ID查找交换机
	public Switch querySwitchById(int id);

	//删除交换机
	public int deleteSwitch(int id);
	
}
