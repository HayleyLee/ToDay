package com.ToDay.Service;

import com.ToDay.entity.Comment;

import java.sql.Timestamp;
import java.util.List;

public interface CommentService {
    List<Comment> SelectByUser(Integer article_id, Integer pn, Integer ps);
    Integer create_comment(Integer article_id, Integer user_id, String comment, Timestamp create_time);
}
