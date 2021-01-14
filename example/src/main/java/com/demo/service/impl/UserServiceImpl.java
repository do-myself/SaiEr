package com.demo.service.impl;

import com.demo.dao.UserDao;
import com.demo.entity.User;
import com.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    //查询全部的用户
    public List<User> queryAllUser() {
        return userDao.queryAllUser();
    }

    //通过用户编码查询用户
    public User queryUserByCode(String userCode) {
        return userDao.queryUserByCode(userCode);
    }

    //修改用户信息
    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    //通过id删除用户信息
    public int deleteUser(int id) {
        return userDao.deleteUser(id);
    }

    //增加用户信息
    public int addUser(User user) {
        return userDao.addUser(user);
    }
}
