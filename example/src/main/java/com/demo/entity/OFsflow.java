package com.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OFsflow {

	//流表的实体类
	private int id;
	private int priority;
	private String srcMac;
	private String dstMac;
	private String srcIp;
	private String dstIp;
	private int inPort;
	private int outPort;
	private String switchID;
	private String action;
	
}
