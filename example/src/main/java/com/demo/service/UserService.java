package com.demo.service;

import com.demo.entity.User;

import java.util.List;

public interface UserService {
    //查询全部的用户
    public List<User> queryAllUser();

    //通过用户编码查询用户
    public User queryUserByCode(String userCode);

    //修改用户信息
    public int updateUser(User user);

    //通过id删除用户信息
    public int deleteUser(int id);

    //增加用户信息
    public int addUser(User user);
}
