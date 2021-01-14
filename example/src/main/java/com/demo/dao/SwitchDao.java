package com.demo.dao;

import java.util.HashMap;
import java.util.List;
import java.lang.Integer;

import org.apache.ibatis.annotations.Param;

import com.demo.entity.Switch;

public interface SwitchDao {
	
	/**
	 * 查询交换信息
	 */
	public List<Switch> query();

	//增加交换机
	public int addSwitch(Switch sw);

	//修改交换机信息
	public int modifySwitch(Switch sw);

	//通过ID查找交换机
	public Switch querySwitchById(int id);

	//删除交换机
	public int deleteSwitch(int id);

}
