package com.ToDay.dao;

import com.ToDay.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Repository
public interface UserMapper {
    User login(@Param(value = "name") String name,
               @Param(value = "phone") Long phone,
               @Param(value = "password") String password);

    Integer create(@Param(value = "name") String name,
                   @Param(value = "password") String password,
                   @Param(value = "email") String email,
                   @Param(value = "phone") Long phone,
                   @Param(value = "create_time")Timestamp create_time);

    List<User> findByConditions(Map<String,Object> map);

    Integer update(@Param(value = "name") String name,
                   @Param(value = "password") String password,
                   @Param(value = "email") String email,
                   @Param(value = "phone") Long phone,
                   @Param(value = "banner") String banner,
                   @Param(value = "photo") String photo,
                   @Param(value = "autograph1") String autograph1,
                   @Param(value = "autograph2") String autograph2,
                   @Param(value = "autograph3") String autograph3,
                   @Param(value = "id") Integer id);

    List<User> serach(@Param(value = "seed") String seed,
                      @Param(value = "pn") Integer pn,
                      @Param(value = "ps") Integer ps);
}
