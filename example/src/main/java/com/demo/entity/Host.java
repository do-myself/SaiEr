package com.demo.entity;

public class Host {
    private int id;
    private String name;
    private String ip;
    private String mac;
    private String linkSwitch;
    private int linkPort;

    public Host() {
    }

    public Host(int id, String name, String ip, String mac, String linkSwitch, int linkPort) {
        this.id = id;
        this.name = name;
        this.ip = ip;
        this.mac = mac;
        this.linkSwitch = linkSwitch;
        this.linkPort = linkPort;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }

    public String getLinkSwitch() {
        return linkSwitch;
    }

    public void setLinkSwitch(String linkSwitch) {
        this.linkSwitch = linkSwitch;
    }

    public int getLinkPort() {
        return linkPort;
    }

    public void setLinkPort(int linkPort) {
        this.linkPort = linkPort;
    }

    @Override
    public String toString() {
        return "Host{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", ip='" + ip + '\'' +
                ", mac='" + mac + '\'' +
                ", linkSwitch='" + linkSwitch + '\'' +
                ", linkPort=" + linkPort +
                '}';
    }
}
