package com.ToDay.controller;

import com.ToDay.Service.CommentService;
import com.ToDay.Service.UserService;
import com.ToDay.entity.Comment;
import com.ToDay.entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;
    @RequestMapping("/find")
    @ResponseBody
    public JSONArray findComment(Integer article_id,Integer pageNumber,Integer pageSize){
        if(article_id!=null&&pageNumber!=null&&pageSize!=null){
            List<Comment> list = commentService.SelectByUser(article_id, pageNumber, pageSize);
            if(list.size()>0){
                JSONArray jarr = new JSONArray();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                for(Comment com:list){
                    JSONObject jo = new JSONObject();
                    List<User> userlist = userService.findByConditions(com.getUser_id(), null, null, null);
                    jo.put("username",userlist.get(0).getName());
                    jo.put("comment",com.getComment());
                    jo.put("create_time",df.format(com.getCreate_time()));
                    jarr.add(jo);
                }
                return jarr;
            }
        }
        return null;
    }

    @RequestMapping("/update")
    public ModelAndView update(HttpServletRequest request,Integer article_id){
        request.getSession().setAttribute("article_id",article_id);
        return new ModelAndView("comment");
    }

    @RequestMapping("/create_comment")
    @ResponseBody
    public Integer create_comment(HttpServletRequest request,String comment,Integer article_id){
        User user = (User)request.getSession().getAttribute("user");
        if(comment!=null && article_id!=null){
            if(comment.length()>5 && comment.length()<50){
                Timestamp time = new Timestamp(System.currentTimeMillis());
                Integer rsl = commentService.create_comment(article_id, user.getId(), comment, time);
                if(rsl>0){
                    Integer rs = 1;
                    return rs;
                }
            }
            else {
                Integer rs = 2;
                return rs;
            }
        }
        Integer rs = 0;
        return rs;
    }
}
