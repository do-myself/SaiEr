package com.demo.dao;

import java.util.List;
import java.lang.Integer;

import com.demo.entity.AclInfo;

public interface AclInfoDao {

	/*
	 * 查询acl列表
	 */
	public List<AclInfo> queryacl();
	
	/*
	 *添加acl列表 
	 */
	public int acladd(AclInfo a);
	
	/*
	 * 删除acl列表
	 */
	public int acldel(int id);

}
