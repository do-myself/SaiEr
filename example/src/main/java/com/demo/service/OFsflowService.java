package com.demo.service;

import java.util.List;

import com.demo.entity.OFsflow;

public interface OFsflowService {

	//查询所有流表信息
	public List<OFsflow> getFlowInfo();

	//添加流表信息
	public int addFlow(OFsflow oFsflow);

	//删除流表项
	public int deleteFlowById(int id);
}
