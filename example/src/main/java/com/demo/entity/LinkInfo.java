package com.demo.entity;

public class LinkInfo {
	
	int id;
	String direction;
	int srcport;
	String srcsw;
	int dstport;
	String dstsw;
	String type;
	
	public LinkInfo(Integer id, String direction, Integer srcport, String srcsw, Integer dstport, String dstsw, String type) {
		this.id = id;
		this.direction = direction;
		this.srcport = srcport;
		this.srcsw = srcsw;
		this.dstport = dstport;
		this.dstsw = dstsw;
		this.type = type;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public int getSrcport() {
		return srcport;
	}
	public void setSrcport(int srcport) {
		this.srcport = srcport;
	}
	public String getSrcsw() {
		return srcsw;
	}
	public void setSrcsw(String srcsw) {
		this.srcsw = srcsw;
	}
	public int getDstport() {
		return dstport;
	}
	public void setDstport(int dstport) {
		this.dstport = dstport;
	}
	public String getDstsw() {
		return dstsw;
	}
	public void setDstsw(String dstsw) {
		this.dstsw = dstsw;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "LinkInfo [id=" + id + ", direction=" + direction + ", srcport=" + srcport + ", srcsw=" + srcsw
				+ ", dstport=" + dstport + ", dstsw=" + dstsw + ", type=" + type + "]";
	}
	
}
