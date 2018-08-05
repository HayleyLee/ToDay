package com.ToDay.controller;

import com.ToDay.Service.ArticleService;
import com.ToDay.Service.FollowService;
import com.ToDay.Service.UserService;
import com.ToDay.entity.Article;
import com.ToDay.entity.Follow;
import com.ToDay.entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/follow")
public class FollowController {
    @Autowired
    private FollowService followService;
    @Autowired
    private UserService userService;
    @Autowired
    private ArticleService articleService;

    @RequestMapping("/selectMe")
    @ResponseBody
    public JSONArray selectMe(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        List<Follow> list = followService.selectMe(-1, user.getId());
        JSONArray followJarr = getFollowList(list);
        return followJarr;
    }

    @RequestMapping("/whoFollowMe")
    @ResponseBody
    public JSONArray whofollowme(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        List<Follow> list = followService.selectMe( user.getId(),-1);
        JSONArray followJarr = getWhoFollowMeList(list);
        return followJarr;
    }

    private JSONArray getFollowList(List<Follow> list) {
        if(list.size()>0){
            JSONArray jarr = new JSONArray();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            for(Follow follow:list){
                JSONObject jo = new JSONObject();
                List<User> userList = userService.findByConditions(follow.getMe_id(), null, null, null);
                jo.put("userimg",userList.get(0).getPhoto());
                jo.put("username",userList.get(0).getName());
                jo.put("autograph1",userList.get(0).getAutograph1());
                jo.put("autograph2",userList.get(0).getAutograph2());
                jo.put("autograph3",userList.get(0).getAutograph3());

                List<Follow> HowManyFollow = followService.selectMe(userList.get(0).getId(), -1);
                List<Follow> TheGuyFollow = followService.selectMe(-1, userList.get(0).getId());
                jo.put("HowManyFollow",HowManyFollow.size());
                jo.put("TheGuyFollow",TheGuyFollow.size());

                List<Article> TheGuyUpload = articleService.findByConditions(null, null, userList.get(0).getId(), null);
                jo.put("TheGuyUpload",TheGuyUpload.size());

                jo.put("FollowTime",df.format(follow.getCreate_time()));
                jarr.add(jo);
            }
            return jarr;
        }
        return null;
    }

    private JSONArray getWhoFollowMeList(List<Follow> list) {
        if(list.size()>0){
            JSONArray jarr = new JSONArray();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            for(Follow follow:list){
                JSONObject jo = new JSONObject();
                List<User> userList = userService.findByConditions(follow.getFollow_id(), null, null, null);
                jo.put("userimg",userList.get(0).getPhoto());
                jo.put("username",userList.get(0).getName());
                jo.put("autograph1",userList.get(0).getAutograph1());
                jo.put("autograph2",userList.get(0).getAutograph2());
                jo.put("autograph3",userList.get(0).getAutograph3());

                List<Follow> HowManyFollow = followService.selectMe(userList.get(0).getId(), -1);
                List<Follow> TheGuyFollow = followService.selectMe(-1, userList.get(0).getId());
                jo.put("HowManyFollow",HowManyFollow.size());
                jo.put("TheGuyFollow",TheGuyFollow.size());

                List<Article> TheGuyUpload = articleService.findByConditions(null, null, userList.get(0).getId(), null);
                jo.put("TheGuyUpload",TheGuyUpload.size());

                jo.put("FollowTime",df.format(follow.getCreate_time()));
                jarr.add(jo);
            }
            return jarr;
        }
        return null;
    }
}
