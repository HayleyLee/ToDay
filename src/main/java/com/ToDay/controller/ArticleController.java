package com.ToDay.controller;

import com.ToDay.Service.ArticleService;
import com.ToDay.Service.UserService;
import com.ToDay.entity.Article;
import com.ToDay.entity.User;
import com.ToDay.utils.FileUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private UserService userService;

    ArrayList<String> Photo = new ArrayList<String>();
    ArrayList<String> Video = new ArrayList<String>();
    @RequestMapping("/saveArticle")
    @ResponseBody
    public JSONObject saveArticle(MultipartFile file) throws Exception {
        FileUtil fileUtil = new FileUtil();
        if (file!=null){
            String filename = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            if(filename.equals(".jpg")||filename.equals(".jpeg")||filename.equals(".png")){
                String photoName = fileUtil.SavePhotoFile(file);
                if(photoName.equals("error")){
                    Integer rs = 0;
                    JSONObject res = new JSONObject();
                    res.put("rs",rs);
                    return res;
                }
                Photo.add(photoName);
            }
            if(filename.equals(".mp4")){
                String videoName = fileUtil.SaveVideoFile(file);
                if(videoName.equals("error")){
                    Integer rs = 0;
                    JSONObject res = new JSONObject();
                    res.put("rs",rs);
                    return res;
                }
                Video.add(videoName);
            }
            Integer rs = 1;
            JSONObject res = new JSONObject();
            res.put("rs",rs);
            return res;
        }else {
            Integer rs = 0;
            JSONObject res = new JSONObject();
            res.put("rs",rs);
            return res;
        }
    }
    @RequestMapping("/sendArticle")
    @ResponseBody
    public Object send(HttpServletRequest request,String title,String article)throws Exception{
        //开始取值
        if(Photo.size()>0 && Video.size()>0 && title.length()<=30 && article.length()<1000) {
            for (int i = 0; i < Photo.size(); i++) {
                for (int j = i; j < Video.size(); j++) {
                    User user = (User)request.getSession().getAttribute("user");
                    Timestamp time = new Timestamp(System.currentTimeMillis());
                    Integer ir = articleService.create(title, article, Photo.get(i), Video.get(j), user.getId(), time);
                    if(ir>0){
                        Integer rs = 1;
                        JSONObject result = new JSONObject();
                        result.put("rs",rs);
                        Photo.clear();
                        Video.clear();
                        return result;
                    }
                }
            }
        }
        if(Photo.size()>0 && Video.size()==0 && title.length()<=30 && article.length()<1000){
            for(int i=0;i<Photo.size();i++){
                User user = (User)request.getSession().getAttribute("user");
                Timestamp time = new Timestamp(System.currentTimeMillis());
                Integer ir = articleService.create(title, article, Photo.get(i), null, user.getId(), time);
                if(ir>0){
                    Integer rs = 1;
                    JSONObject result = new JSONObject();
                    result.put("rs",rs);
                    Photo.clear();
                    return result;
                }
            }
        }
        if(Video.size()>0 && Photo.size()==0 && title.length()<=30 && article.length()<1000){
            for(int i=0;i<Video.size();i++){
                User user = (User)request.getSession().getAttribute("user");
                Timestamp time = new Timestamp(System.currentTimeMillis());
                Integer ir = articleService.create(title, article, null, Video.get(i), user.getId(), time);
                if(ir>0){
                    Integer rs = 1;
                    JSONObject result = new JSONObject();
                    result.put("rs",rs);
                    Video.clear();
                    return result;
                }
            }
        }
        Integer rs = 0;
        JSONObject result = new JSONObject();
        result.put("rs",rs);
        return result;
    }

    @RequestMapping("/aboutMe")
    @ResponseBody
    public JSONArray getAboutMe(HttpServletRequest request, Integer pageNumber, Integer pageSize){
        User user = (User)request.getSession().getAttribute("user");
        if(user.getName()!=null||user.getId()!=null){
            if(pageNumber!=null&&pageSize!=null){
                List<Article> list = articleService.aboutMe(user.getId(),pageNumber, pageSize);
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                if(list.size()>0){
                    JSONArray jarr = new JSONArray();
                    JSONObject jo = new JSONObject();
                    jo.put("username",user.getName());
                    jarr.add(jo);
                    for(Article a:list){
                        jo.put("name",a.getName());
                        jo.put("photo",a.getPhoto());
                        jo.put("video",a.getVideo());
                        if(a.getArticle().length()>150){
                            jo.put("article",a.getArticle().substring(0,150)+"...");
                        }
                        else {
                            jo.put("article",a.getArticle()+"...");
                        }
                        jo.put("like_count",a.getLike_count());
                        jo.put("article_id",a.getId());
                        jo.put("create_time",df.format(a.getCreate_time()));
                        jarr.add(jo);
                    }
                    return jarr;
                }
            }
        }
        return null;
    }

    @RequestMapping("/indexshow")
    @ResponseBody
    public JSONArray indexShow(Integer pageNumber,Integer pageSize){
        List<Article> list = articleService.indexShow(pageNumber, pageSize);
        if(pageNumber!=null&&pageSize!=null){
            if(list.size()>0){
                JSONArray jarr = new JSONArray();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                for(Article a:list){
                    JSONObject jo = new JSONObject();
                    jo.put("name",a.getName());
                    jo.put("photo",a.getPhoto());
                    jo.put("video",a.getVideo());
                    if(a.getArticle().length()>150){
                        jo.put("article",a.getArticle().substring(0,150)+"...");
                    }
                    else {
                        jo.put("article",a.getArticle()+"...");
                    }
                    List<User> userList = userService.findByConditions(a.getUser_id(), null, null, null);
                    jo.put("username",userList.get(0).getName());
                    jo.put("user_id",a.getUser_id());
                    jo.put("like_count",a.getLike_count());
                    jo.put("create_time",df.format(a.getCreate_time()));
                    jo.put("article_id",a.getId());
                    jarr.add(jo);
                }
                return jarr;
            }
        }
        return null;
    }

    @RequestMapping("/like")
    @ResponseBody
    public JSONObject likeIt(Integer article_id){
        if(article_id!=null){
            List<Article> list = articleService.findByConditions(article_id, null, null, null);
            if(list.size()>0){
                Integer like_count = list.get(0).getLike_count();
                Integer i = articleService.update(like_count+1, article_id);
                if(i>0){
                    Integer rs = 1;
                    JSONObject result = new JSONObject();
                    result.put("rs",rs);
                    return result;
                }
            }
        }
        return null;
    }

    @RequestMapping("/dislike")
    @ResponseBody
    public JSONObject dislikeIt(Integer article_id){
        if(article_id!=null){
            List<Article> list = articleService.findByConditions(article_id, null, null, null);
            if(list.size()>0){
                Integer like_count = list.get(0).getLike_count();
                Integer i = articleService.update(like_count-1, article_id);
                if(i>0){
                    Integer rs = 1;
                    JSONObject result = new JSONObject();
                    result.put("rs",rs);
                    return result;
                }
            }
        }
        return null;
    }


    @RequestMapping("/aboutTagUser")
    @ResponseBody
    public JSONArray getAboutTag(HttpServletRequest request, Integer pageNumber, Integer pageSize){
        User user = (User)request.getSession().getAttribute("tagUser");
        if(user.getName()!=null||user.getId()!=null){
            if(pageNumber!=null&&pageSize!=null){
                List<Article> list = articleService.aboutMe(user.getId(),pageNumber, pageSize);
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                if(list.size()>0){
                    JSONArray jarr = new JSONArray();
                    JSONObject jo = new JSONObject();
                    jo.put("username",user.getName());
                    jarr.add(jo);
                    for(Article a:list){
                        jo.put("name",a.getName());
                        jo.put("photo",a.getPhoto());
                        jo.put("video",a.getVideo());
                        jo.put("article",a.getArticle());
                        jo.put("like_count",a.getLike_count());
                        jo.put("create_time",df.format(a.getCreate_time()));
                        jo.put("article_id",a.getId());
                        jarr.add(jo);
                    }
                    return jarr;
                }
            }
        }
        return null;
    }

    @RequestMapping("/normal")
    public ModelAndView normal(){
        return new ModelAndView("redirect:/createArticle.jsp");
    }

    @RequestMapping("/big")
    public ModelAndView big(){
        return new ModelAndView("redirect:/createBigArticle.jsp");
    }

    @RequestMapping("/newShow")
    @ResponseBody
    public JSONArray newShow(Integer article_id){
        if(article_id>0){
            List<Article> list = articleService.findByConditions(article_id, null, null, null);
            if(list.size()>0){
                JSONArray jarr = new JSONArray();
                JSONObject jo = new JSONObject();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                for(Article a:list){
                    jo.put("name",a.getName());
                    jo.put("create_time",df.format(a.getCreate_time()));
                    jo.put("user_name",userService.findByConditions(a.getUser_id(),null,null,null).get(0).getName());
                    jo.put("like",a.getLike_count());
                    jo.put("user_id",a.getUser_id());
                    jo.put("id",a.getId());
                    jo.put("video",a.getVideo());
                    jo.put("article",a.getArticle());
                    jo.put("photo",a.getPhoto());
                    jarr.add(jo);
                }
                return jarr;
            }
        }
        return null;
    }

    @RequestMapping("/descIt")
    @ResponseBody
    public JSONArray descIt(Integer pn,Integer ps){
        if(pn!=null&&ps!=null){
            List<Article> list = articleService.descIt(pn, ps);
            if(list.size()>0){
                JSONObject jo = new JSONObject();
                JSONArray jarr = new JSONArray();
                for(Article a:list){
                    jo.put("id",a.getId());
                    jo.put("name",a.getName());
                    jarr.add(jo);
                }
                return jarr;
            }
        }
        return null;
    }

    @RequestMapping("/Top")
    @ResponseBody
    public JSONArray top(Integer pn,Integer ps){
        if(pn!=null&&ps!=null){
            List<Article> list = articleService.top(pn, ps);
            if(list.size()>0){
                JSONObject jo = new JSONObject();
                JSONArray jarr = new JSONArray();
                for(Article a:list){
                    jo.put("id",a.getId());
                    jo.put("name",a.getName());
                    jarr.add(jo);
                }
                return jarr;
            }
        }
        return null;
    }

    @RequestMapping("/serachArticle")
    @ResponseBody
    public JSONArray serach(Integer aid){
        if(aid>0){
            List<Article> articleList = articleService.findByConditions(aid, null, null, null);
            if(articleList.size()>0){
                Article article = articleList.get(0);
                String seed = article.getName();
                if(seed.length()>5){
                    String tempSeed = " "+seed+" ";
                    Integer len = tempSeed.length()/2;
                    String newSeed = tempSeed.substring(len-2,len+2);
                    List<Article> list = articleService.serach(newSeed, 0, 5);
                    if (list.size()>0){
                        JSONObject jo = new JSONObject();
                        JSONArray jarr = new JSONArray();
                        for(Article a:list){
                            jo.put("id",a.getId());
                            jo.put("name",a.getName());
                            jarr.add(jo);
                        }
                        return jarr;
                    }
                }
                List<Article> list = articleService.serach(article.getName(), 0, 5);
                if (list.size()>0){
                    JSONObject jo = new JSONObject();
                    JSONArray jarr = new JSONArray();
                    for(Article a:list){
                        jo.put("id",a.getId());
                        jo.put("name",a.getName());
                        jarr.add(jo);
                    }
                    return jarr;
                }
            }
        }
        return null;
    }

    @RequestMapping("/del")
    @ResponseBody
    public Integer deleteIt(Integer article_id){
        if(article_id>0){
            Article article = articleService.findByConditions(article_id, null, null, null).get(0);
            if(article!=null){
                if(article.getPhoto()==null && article.getVideo()==null){
                    Integer delete = articleService.delete(article_id);
                    if(delete>0){
                        return 1;
                    }
                }
                if(article.getPhoto()!=null && article.getVideo()!=null){
                    File f1 = new File("C:\\userPhoto"+File.separator+article.getPhoto());
                    FileUtil fileUtil = new FileUtil();
                    Integer res1 = fileUtil.Delete(f1);
                    if(res1==1){
                        File f2 = new File("C:\\userPhoto"+File.separator+article.getVideo());
                        Integer res2 = fileUtil.Delete(f2);
                        if(res2==1){
                            Integer delete = articleService.delete(article_id);
                            if(delete>0){
                                return 1;
                            }
                        }
                    }
                }
                if(article.getPhoto()!=null && article.getVideo()==null){
                    File f = new File("C:\\userPhoto"+File.separator+article.getPhoto());
                    FileUtil fileUtil = new FileUtil();
                    Integer res = fileUtil.Delete(f);
                    if(res==1){
                        Integer delete = articleService.delete(article_id);
                        if(delete>0){
                            return 1;
                        }
                    }
                }
                if(article.getVideo()!=null && article.getPhoto()==null){
                    File f = new File("C:\\userPhoto"+File.separator+article.getVideo());
                    FileUtil fileUtil = new FileUtil();
                    Integer res = fileUtil.Delete(f);
                    if(res==1){
                        Integer delete = articleService.delete(article_id);
                        if(delete>0){
                            return 1;
                        }
                    }
                }
            }
        }
        return null;
    }
}
