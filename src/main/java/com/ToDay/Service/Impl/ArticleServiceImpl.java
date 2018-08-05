package com.ToDay.Service.Impl;

import com.ToDay.Service.ArticleService;
import com.ToDay.dao.ArticleMapper;
import com.ToDay.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

@Service
@Transactional
public class ArticleServiceImpl implements ArticleService{
    @Autowired
    private ArticleMapper articleMapper;
    @Override
    public List<Article> findByConditions(Integer id, String name, Integer user_id, Timestamp create_time) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        if(id!=null){
            map.put("id",id);
        }
        if(name!=null){
            map.put("name",name);
        }
        if(user_id!=null){
            map.put("user_id",user_id);
        }
        if(create_time!=null){
            map.put("create_time",create_time);
        }
        return articleMapper.findByConditions(map);
    }

    @Override
    public Integer create(String name, String article, String photo, String video, Integer user_id, Timestamp create_time) {
        return articleMapper.create(name,article,photo,video,user_id,0,create_time);
    }

    @Override
    public Integer update(Integer like_count, Integer id) {
        return articleMapper.update(like_count,id);
    }

    @Override
    public Integer delete(Integer id) {
        return articleMapper.delete(id);
    }

    @Override
    public List<Article> aboutMe(Integer uid,Integer pageNumber, Integer pageSize) {
        return articleMapper.aboutMe(uid,pageNumber,pageSize);
    }

    @Override
    public List<Article> indexShow(Integer pageNumber, Integer pageSize) {
        return articleMapper.indexShow(pageNumber,pageSize);
    }

    @Override
    public List<Article> descIt(Integer pageNumber, Integer pageSize) {
        return articleMapper.descIt(pageNumber,pageSize);
    }

    @Override
    public List<Article> top(Integer pageNumber, Integer pageSize) {
        return articleMapper.top(pageNumber,pageSize);
    }

    @Override
    public List<Article> serach(String seed, Integer pageNumber, Integer pageSize) {
        if (seed!=null) {
            return articleMapper.serach(seed, pageNumber, pageSize);
        }
        return null;
    }
}
