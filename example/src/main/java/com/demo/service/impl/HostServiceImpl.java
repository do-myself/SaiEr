package com.demo.service.impl;

import com.demo.dao.HostDao;
import com.demo.entity.Host;
import com.demo.service.HostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HostServiceImpl implements HostService {

    @Autowired
    private HostDao hostDao;

    //查询全部主机
    public List<Host> queryAllHost2() {
        return hostDao.queryAllHost1();
    }

    //删除主机
    public int deleteHost(int id) {
        return hostDao.deleteHost(id);
    }

    //添加主机
    public int addHost(Host host) {
        return hostDao.addHost(host);
    }

    //通过ID查询主机
    public Host queryHostById(int id) {
        return hostDao.queryHostById(id);
    }

    //修改主机信息
    public int modifyHost(Host host) {
        return hostDao.modifyHost(host);
    }

    //删除主机之后对主键id重新排序
//    public int sortKey(){
//        return hostDao.sortKey();
//    }
}
