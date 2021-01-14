package com.demo.service;

import java.util.List;

import com.demo.entity.AclInfo;

public interface AclInfoService {
	
	public List<AclInfo> queryall();
	
	public boolean add(AclInfo acl);
	
	public boolean del(int id);
	

}
