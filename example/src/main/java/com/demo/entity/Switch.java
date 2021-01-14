package com.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Switch {
	//OpenFlow交换机的属性

	//交换机id
	private int id;
	//MAC地址
	private String mac;
	//OF_Switch版本
	private String version;
	//IPv4地址
	private String ipv4;
	//IPv6地址
	private String ipv6;
	//OF_Switch所属的端口总数
	private int ports;
	//OF_Switch所包含的流表项数目
	private int flows;
	//OF_Switch的角色
	private String role;
}
