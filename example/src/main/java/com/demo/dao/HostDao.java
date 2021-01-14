package com.demo.dao;

import com.demo.entity.Host;

import java.util.List;

public interface HostDao {
    //查询全部主机
    public List<Host> queryAllHost1();

    //添加主机
    public int addHost(Host host);

    //删除主机
    public int deleteHost(int id);

    //通过ID查询主机
    public Host queryHostById(int id);

    //修改主机信息
    public int modifyHost(Host host);

    //删除主机之后对主键id重新排序
//    public int sortKey();
}
