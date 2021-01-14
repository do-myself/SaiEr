package com.demo.dao;

import com.demo.entity.AttackInfo;

import java.util.List;

public interface AttackInfoDao {
    //查询所有的攻击记录
    public List<AttackInfo> queryAll();

    //添加攻击记录
    public int addAttackInfo(AttackInfo attackInfo);

    //删除攻击记录
    public int deleteAttackInfo(int id);
}
