package com.offcn.smbms.service;

import com.offcn.smbms.pojo.User;

import java.util.List;

public interface UserService {
    User login(String userCode,String userPassword);
    List<User> list(String userName);
    int save(User user);
    User getById(int id);
    int remove(int id);
    int update(User user);
}
