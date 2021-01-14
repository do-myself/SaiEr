package com.demo.entity;

import java.lang.Integer;

//流表的实体类，添加转发的流表
public class StaticFlow {

	private String switchid;
	private String name;
	private int priority;
	private int inport;
	private int outport;

	public String getSwitchid() {
		return switchid;
	}
	public void setSwitchid(String switchid) {
		this.switchid = switchid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public int getInport() {
		return inport;
	}
	public void setInport(int inport) {
		this.inport = inport;
	}
	public int getOutport() {
		return outport;
	}
	public void setOutport(int outport) {
		this.outport = outport;
	}

	public StaticFlow() {};

	public StaticFlow(String switchid, String name, Integer priority, Integer inport, Integer outport) {
		this.switchid = switchid;
		this.name = name;
		this.priority = priority;
		this.inport = inport;
		this.outport = outport;
	}

	@Override
	public String toString() {
		return "StaticFlow [switchid=" + switchid + ", name=" + name + ", priority=" + priority + ", inport=" + inport
				+ ", outport=" + outport + "]";
	}

}
