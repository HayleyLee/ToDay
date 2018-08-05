package com.ToDay.Service.Impl;

import com.ToDay.Service.UserService;
import com.ToDay.dao.UserMapper;
import com.ToDay.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public User login(String name, String password) {
        return userMapper.login(name,Long.valueOf(name),password);
    }

    @Override
    public Integer create(String name, String password, String email, Long phone, Timestamp create_time) {
        return userMapper.create(name,password,email,phone,create_time);
    }

    @Override
    public List<User> findByConditions(Integer id, String name, String email, Long phone) {
        HashMap<String, Object> map = new HashMap<String,Object>();
        if(id!=null){
            map.put("id",id);
        }
        if(name!=null){
            map.put("name",name);
        }
        if(email!=null){
            map.put("email",email);
        }
        if(phone!=null){
            map.put("phone",phone);
        }
        return userMapper.findByConditions(map);
    }

    @Override
    public Integer update(String name, String password, String email, Long phone, String banner, String photo, String autograph1, String autograph2, String autograph3,Integer id) {
        return userMapper.update(name,password,email,phone,banner,photo,autograph1,autograph2,autograph3,id);
    }

    @Override
    public List<User> serach(String seed, Integer pn, Integer ps) {
        if (seed!=null) {
            return userMapper.serach(seed, pn, ps);
        }
        return null;
    }
}
