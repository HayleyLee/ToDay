package com.ToDay.entity;

import java.sql.Timestamp;

public class User {
    private Integer id;
    private String name;
    private String password;
    private String email;
    private Long phone;
    private String banner;
    private String photo;
    private String autograph1;
    private String autograph2;
    private String autograph3;
    private Timestamp create_time;

    public User(Integer id, String name, String password, String email, Long phone, String banner, String photo, String autograph1, String autograph2, String autograph3, Timestamp create_time) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.banner = banner;
        this.photo = photo;
        this.autograph1 = autograph1;
        this.autograph2 = autograph2;
        this.autograph3 = autograph3;
        this.create_time = create_time;
    }

    public String getBanner() {
        return banner;
    }

    public void setBanner(String banner) {
        this.banner = banner;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAutograph1() {
        return autograph1;
    }

    public void setAutograph1(String autograph1) {
        this.autograph1 = autograph1;
    }

    public String getAutograph2() {
        return autograph2;
    }

    public void setAutograph2(String autograph2) {
        this.autograph2 = autograph2;
    }

    public String getAutograph3() {
        return autograph3;
    }

    public void setAutograph3(String autograph3) {
        this.autograph3 = autograph3;
    }

    public Long getPhone() {
        return phone;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }
}
