package com.demo.service.impl;

import com.demo.dao.AttackInfoDao;
import com.demo.entity.AttackInfo;
import com.demo.service.AttackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttackServiceImpl implements AttackService {

    @Autowired
    private AttackInfoDao attackInfoDao;

    //查询全部攻击记录
    public List<AttackInfo> queryAll() {
        return attackInfoDao.queryAll();
    }

    //添加攻击记录
    public int addAttackInfo(AttackInfo attackInfo) {
        return attackInfoDao.addAttackInfo(attackInfo);
    }

    //删除攻击记录
    public int deleteAttackInfo(int id){ return attackInfoDao.deleteAttackInfo(id);}
}
