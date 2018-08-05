package com.ToDay.entity;

import java.sql.Timestamp;

public class Follow {
    private Integer id;
    private Integer me_id;
    private Integer follow_id;
    private Timestamp create_time;

    public Follow(Integer id, Integer me_id, Integer follow_id, Timestamp create_time) {
        this.id = id;
        this.me_id = me_id;
        this.follow_id = follow_id;
        this.create_time = create_time;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMe_id() {
        return me_id;
    }

    public void setMe_id(Integer me_id) {
        this.me_id = me_id;
    }

    public Integer getFollow_id() {
        return follow_id;
    }

    public void setFollow_id(Integer follow_id) {
        this.follow_id = follow_id;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }
}
