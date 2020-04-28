package com.offcn.smbms.service.impl;

import com.offcn.smbms.mapper.UserMapper;
import com.offcn.smbms.pojo.User;
import com.offcn.smbms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public User login(String userCode, String userPassword) {
        return userMapper.getByUserCodeAndPassWord(userCode,userPassword);
    }

    @Override
    public List<User> list(String userName) {
        return userMapper.list(userName);
    }

    @Override
    public int save(User user) {
        return userMapper.save(user);
    }

    @Override
    public User getById(int id) {
        return userMapper.getById(id);
    }

    @Override
    public int remove(int id) {
        return userMapper.remove(id);
    }

    @Override
    public int update(User user) {
        return userMapper.update(user);
    }
}
