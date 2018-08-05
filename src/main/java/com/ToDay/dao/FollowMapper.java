package com.ToDay.dao;

import com.ToDay.entity.Follow;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Repository
public interface FollowMapper {
    List<Follow> selectMe(Map<String,Object> map);

    Integer create(@Param(value = "me_id") Integer me_id,
                   @Param(value = "follow_id") Integer follow_id,
                   @Param(value = "create_time")Timestamp create_time);

    Integer delete(@Param(value = "id") Integer id);
}
