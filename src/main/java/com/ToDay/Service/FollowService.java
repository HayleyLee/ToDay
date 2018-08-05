package com.ToDay.Service;

import com.ToDay.entity.Follow;

import java.sql.Timestamp;
import java.util.List;

public interface FollowService {
    List<Follow> selectMe(Integer me_id, Integer follow_id);
    Integer create(Integer me_id, Integer follow_id, Timestamp create_time);
    Integer delete(Integer id);
}
