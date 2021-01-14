package com.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AttackInfo {
    private int id;
    private String switchId;
    private int inPort;
    private String srcMac;
    private String dstMac;
    private String srcIp;
    private String dstIp;
    private String  attackTime;
}
