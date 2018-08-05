package com.ToDay.Service;

import com.ToDay.entity.User;

import java.sql.Timestamp;
import java.util.List;

public interface UserService {
    User login(String name, String password);
    Integer create(String name, String password, String email, Long phone, Timestamp create_time);
    List<User> findByConditions(Integer id, String name, String email, Long phone);
    Integer update(String name,String password,String email,Long phone,String banner,String photo,String autograph1,String autograph2,String autograph3,Integer id);
    List<User> serach(String seed,Integer pn,Integer ps);
}
