package com.ToDay.Service.Impl;

import com.ToDay.Service.FollowService;
import com.ToDay.dao.FollowMapper;
import com.ToDay.entity.Follow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
@Service
@Transactional
public class FollowServiceImpl implements FollowService{
    @Autowired
    private FollowMapper followMapper;
    @Override
    public List<Follow> selectMe(Integer me_id, Integer follow_id) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        if(me_id>0){
            map.put("me_id",me_id);
        }
        if(follow_id>0){
            map.put("follow_id",follow_id);
        }
        return followMapper.selectMe(map);
    }

    @Override
    public Integer create(Integer me_id, Integer follow_id, Timestamp create_time) {
        return followMapper.create(me_id,follow_id,create_time);
    }

    @Override
    public Integer delete(Integer id) {
        return followMapper.delete(id);
    }
}
