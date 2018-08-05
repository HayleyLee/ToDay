package com.ToDay.dao;

import com.ToDay.entity.Article;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Repository
public interface ArticleMapper {
    List<Article> findByConditions(Map<String,Object> map);

    Integer update(@Param(value = "like_count") Integer like_count,
                   @Param(value = "id") Integer id);

    Integer create(@Param(value = "name") String name,
                   @Param(value = "article") String article,
                   @Param(value = "photo") String photo,
                   @Param(value = "video") String video,
                   @Param(value = "user_id") Integer user_id,
                   @Param(value = "like_count") Integer like_count,
                   @Param(value = "create_time") Timestamp create_time);

    Integer delete(@Param(value = "id") Integer id);

    List<Article> aboutMe(
            @Param(value = "uid") Integer uid,
            @Param(value = "pn") Integer pn,
            @Param(value = "ps") Integer ps);

    List<Article> indexShow(@Param(value = "pn") Integer pn, @Param(value = "ps") Integer ps);

    List<Article> descIt(@Param(value = "pn") Integer pn,@Param(value = "ps") Integer ps);

    List<Article> top(@Param(value = "pn") Integer pn,@Param(value = "ps") Integer ps);

    List<Article> serach(@Param(value = "seed") String seed,
                         @Param(value = "pn") Integer pn,
                         @Param(value = "ps") Integer ps);
}
