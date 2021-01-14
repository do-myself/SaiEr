package com.demo.dao;

import java.util.List;

import com.demo.entity.OFsflow;

public interface OFsflowDao {
	
	//获取交换机的流表信息
	public List<OFsflow> getFlow();

	//添加流表信息
	public int addFlow(OFsflow oFsflow);

	//删除流表信息
	public int deleteFlowById(int id);

}
