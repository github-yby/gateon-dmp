package com.offcn.smbms.mapper;

import com.offcn.smbms.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    User getByUserCodeAndPassWord(@Param("userCode") String userCode, @Param("userPassword")String userPassword);
    List<User> list(@Param("userName") String userName);
    int save(User user);
    User getById(int id);
    int remove(int id);
    int update(User user);
}
