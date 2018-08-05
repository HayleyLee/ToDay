package com.ToDay.Service.Impl;

import com.ToDay.Service.CommentService;
import com.ToDay.dao.CommentMapper;
import com.ToDay.entity.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
@Service
@Transactional
public class CommentServiceImpl implements CommentService{
    @Autowired
    private CommentMapper commentMapper;
    @Override
    public List<Comment> SelectByUser(Integer article_id, Integer pn, Integer ps) {
        return commentMapper.selectByArticle(article_id,pn,ps);
    }

    @Override
    public Integer create_comment(Integer article_id, Integer user_id, String comment, Timestamp create_time) {
        return commentMapper.create(article_id,user_id,comment,create_time);
    }
}
