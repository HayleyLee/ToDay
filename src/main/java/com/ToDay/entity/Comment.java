package com.ToDay.entity;

import java.sql.Timestamp;

public class Comment {
    private Integer id;
    private Integer article_id;
    private Integer user_id;
    private String comment;
    private Timestamp create_time;

    public Comment(Integer id, Integer article_id, Integer user_id, String comment, Timestamp create_time) {
        this.id = id;
        this.article_id = article_id;
        this.user_id = user_id;
        this.comment = comment;
        this.create_time = create_time;
    }
    public Comment(){

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getArticle_id() {
        return article_id;
    }

    public void setArticle_id(Integer article_id) {
        this.article_id = article_id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }
}
