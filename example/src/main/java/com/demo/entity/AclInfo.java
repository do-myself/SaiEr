package com.demo.entity;

public class AclInfo {

	int id;
	String ipsrc;
	String ipdst;
	String action;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getIpsrc() {
		return ipsrc;
	}
	public void setIpsrc(String ipsrc) {
		this.ipsrc = ipsrc;
	}
	public String getIpdst() {
		return ipdst;
	}
	public void setIpdst(String ipdst) {
		this.ipdst = ipdst;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	
	/*
	 * 默认的构造器
	 */
	public AclInfo() {}
	
	/*
	 * 带参数的构造器
	 */
	public AclInfo(Integer id, String ipsrc, String ipdst, String action) {
		this.id = id;
		this.ipsrc = ipsrc;
		this.ipdst = ipdst;
		this.action = action;
	}
	
	@Override
	public String toString() {
		return "AclInfo [id=" + id + ", ipsrc=" + ipsrc + ", ipdst=" + ipdst + ", action=" + action + "]";
	}
		
}
