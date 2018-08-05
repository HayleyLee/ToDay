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
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/serach")
public class SerachController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private UserService userService;
    @Autowired
    private FollowService followService;

    @RequestMapping("/serachAll")
    @ResponseBody
    public JSONArray SerachAll(String seed){
        if(seed!=null){
            JSONArray jarr = new JSONArray();
            List<Article> articleList = articleService.serach(seed, 0, 10);
            if(articleList.size()>0){
                JSONObject jo = new JSONObject();
                for(Article a:articleList){
                    jo.put("aid",a.getId());
                    jo.put("aName",a.getName());
                    jo.put("img",a.getPhoto());
                    if(a.getArticle().length()>150){
                        jo.put("article",a.getArticle().substring(0,150)+"...");
                    }
                    else {
                        jo.put("article",a.getArticle()+"...");
                    }
                    jarr.add(jo);
                }
            }
            List<User> userList = userService.serach(seed, 0, 10);
            if(userList.size()>0){
                JSONObject jo = new JSONObject();
                for(User u:userList){
                    jo.put("uid",u.getId());
                    jo.put("uName",u.getName());
                    jo.put("ua1",u.getAutograph1());
                    jo.put("ua2",u.getAutograph2());
                    jo.put("ua3",u.getAutograph3());
                    jo.put("uPhoto",u.getPhoto());
                    List<Follow> followList = followService.selectMe(u.getId(), -1);
                    jo.put("uFollow",followList.size());
                    List<Follow> whoFollowList = followService.selectMe(-1, u.getId());
                    jo.put("wFollow",whoFollowList.size());
                    List<Article> aList = articleService.findByConditions(null, null, u.getId(), null);
                    jo.put("uUpload",aList.size());
                    jarr.add(jo);
                }
            }
            return jarr;
        }
        return null;
    }

    @RequestMapping("/send")
    public ModelAndView jump(HttpServletRequest request,String seed){
        if(seed!=null){
            request.getSession().setAttribute("seed",seed);
            return new ModelAndView("redirect:/serach.jsp");
        }
        return null;
    }
}
