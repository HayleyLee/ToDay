package com.ToDay.dao;

import com.ToDay.entity.Comment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface CommentMapper {
    List<Comment> selectByArticle(
            @Param(value = "aid") Integer article_id,
            @Param(value = "pn") Integer pn,
            @Param(value = "ps") Integer ps);
    Integer create(
            @Param(value = "article_id") Integer article_id,
            @Param(value = "user_id") Integer user_id,
            @Param(value = "comment") String comment,
            @Param(value = "create_time")Timestamp create_time);
}
