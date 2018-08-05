package com.ToDay.Service;

import com.ToDay.entity.Article;

import java.sql.Timestamp;
import java.util.List;

public interface ArticleService {
    List<Article> findByConditions(Integer id, String name, Integer user_id, Timestamp create_time);
    Integer create(String name,String article,String photo,String video,Integer user_id,Timestamp create_time);
    Integer update(Integer like_count,Integer id);
    Integer delete(Integer id);
    List<Article> aboutMe(Integer uid,Integer pageNumber,Integer pageSize);
    List<Article> indexShow(Integer pageNumber,Integer pageSize);
    List<Article> descIt(Integer pageNumber,Integer pageSize);
    List<Article> top(Integer pageNumber,Integer pageSize);
    List<Article> serach(String seed,Integer pageNumber,Integer pageSize);
}
