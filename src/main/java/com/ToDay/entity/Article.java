package com.ToDay.entity;

import java.sql.Timestamp;

public class Article {
    private Integer id;
    private String name;
    private String article;
    private String photo;
    private String video;
    private Integer user_id;
    private Integer like_count;
    private Timestamp create_time;

    public Article(Integer id, String name, String article, String photo, String video, Integer user_id, Integer like_count, Timestamp create_time) {
        this.id = id;
        this.name = name;
        this.article = article;
        this.photo = photo;
        this.video = video;
        this.user_id = user_id;
        this.like_count = like_count;
        this.create_time = create_time;
    }

    public Article(){
    }


    public Integer getLike_count() {
        return like_count;
    }

    public void setLike_count(Integer like_count) {
        this.like_count = like_count;
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

    public String getArticle() {
        return article;
    }

    public void setArticle(String article) {
        this.article = article;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }
}
