package com.ToDay.controller;

import com.ToDay.Service.FollowService;
import com.ToDay.Service.UserService;
import com.ToDay.config.AppConfig;
import com.ToDay.entity.Follow;
import com.ToDay.entity.User;
import com.ToDay.lib.MESSAGEXsend;
import com.ToDay.utils.BuildCode;
import com.ToDay.utils.ConfigLoader;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.sql.Timestamp;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    private Integer nullid = null;
    private String nullname = null;
    private String nullpass= null;
    private String nullemail= null;
    private Long nullphone= null;
    private String nullcode = null;
    @Autowired
    private UserService userService;
    @Autowired
    private FollowService followService;

    @RequestMapping("/logout")
    public ModelAndView userlogout(HttpServletRequest request){
        request.getSession().invalidate();
        return new ModelAndView("redirect:/index.jsp");
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ModelAndView userlogin(HttpServletRequest request,String name,String password) throws Exception{
        if(name!=null&&password!=null){
            User user = userService.login(name,password);
            if(user!=null) {
                if (user.getName().equals(name) || Long.toString(user.getPhone()).equals(name)) {
                    if (user.getPassword().equals(password)) {
                        request.getSession().setAttribute("user", user);
                        return new ModelAndView("redirect:/index.jsp");
                    }
                }
            }
        }
        return new ModelAndView("redirect:/errorMsg.jsp");
    }

    @RequestMapping(value = "/create",method = RequestMethod.POST)
    public ModelAndView usercreate(HttpServletRequest request,String name,String pass1,String pass2,String phone,String code){
        if(name!=null&&pass1!=null&&pass2!=null&&phone!=null){
            Long phonenum = Long.valueOf(phone);
            if(pass1.equals(pass2)&&code.equals(nullcode)){
                Timestamp newtime = new Timestamp(System.currentTimeMillis());
                String email="";
                Integer integer = userService.create(name, pass2, email,phonenum , newtime);
                if(integer>0){
                    List<User> list = userService.findByConditions(nullid, name, nullemail, phonenum);
                    User user = list.get(0);
                    request.getSession().setAttribute("user",user);
                    return new ModelAndView("redirect:/index.jsp");
                }
            }
        }
        return new ModelAndView("redirect:/404.jsp");
    }

    @RequestMapping("sendCode")
    @ResponseBody
    public String sendCode(String phone){
        if(phone!=null&&phone.length()<12){
            BuildCode bc = new BuildCode();
            StringBuffer code = bc.buildCode();
            AppConfig config = ConfigLoader.load(ConfigLoader.ConfigType.Message);
            MESSAGEXsend submsg = new MESSAGEXsend(config);
            submsg.addTo(phone);
            submsg.setProject("ihR8O");
            submsg.addVar("code",code.toString());
            submsg.xsend();
            nullcode = code.toString();
            return code.toString();
        }
        return null;
    }

    @RequestMapping("/updateAutograph")
    @ResponseBody
    public Integer updateuser(HttpServletRequest request,String id,String autograph1,String autograph2,String autograph3) {
        Integer newid = Integer.valueOf(id);
        if (newid> 0) {
            List<User> list = userService.findByConditions(newid,nullname,nullemail,nullphone);
            User user = list.get(0);
            if (user.getName()!= null) {
                Integer i = userService.update(
                        user.getName(),
                        user.getPassword(),
                        user.getEmail(),
                        user.getPhone(),
                        user.getBanner(),
                        user.getPhoto(),
                        autograph1,
                        autograph2,
                        autograph3,
                        newid);
                if (i > 0) {
                    user.setAutograph1(autograph1);
                    user.setAutograph2(autograph2);
                    user.setAutograph3(autograph3);
                    request.getSession().setAttribute("user",user);
                    return 1;
                }
            }
        }
        return 0;
    }

    @RequestMapping("/uploadPhoto")
    @ResponseBody
    public JSONObject uploadPhoto(HttpServletRequest request, MultipartFile file) throws Exception{
        if(!file.isEmpty()) {
            //上传文件路径
            String path = "C:\\userPhoto";
            //上传文件名
            String filename = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            File filepath = new File(path,filename);
            //判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            //将上传文件保存到一个目标文件当中
            file.transferTo(new File(path + File.separator + filename));
            //执行数据库操作
            User user = (User)request.getSession().getAttribute("user");
            Integer update = userService.update(
                    user.getName(),
                    user.getPassword(),
                    user.getEmail(),
                    user.getPhone(),
                    user.getBanner(),
                    filename,
                    user.getAutograph1(),
                    user.getAutograph2(),
                    user.getAutograph3(),
                    user.getId());
            if(update>0){
                user.setPhoto(filename);
                request.getSession().setAttribute("user",user);
                Integer rs = 1;
                JSONObject res = new JSONObject();
                res.put("rs",rs);
                return res;
            }
        }
        Integer rs = 0;
        JSONObject res = new JSONObject();
        res.put("rs",rs);
        return res;
    }

    @RequestMapping("/uploadBanner")
    @ResponseBody
    public JSONObject uploadBanner(HttpServletRequest request,MultipartFile file)throws Exception{
        if(!file.isEmpty()) {
            //上传文件路径
            String path = "C:\\userPhoto";
            //上传文件名
            String filename = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            File filepath = new File(path,filename);
            //判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            //将上传文件保存到一个目标文件当中
            file.transferTo(new File(path + File.separator + filename));
            //执行数据库操作
            User user = (User)request.getSession().getAttribute("user");
            Integer update = userService.update(
                    user.getName(),
                    user.getPassword(),
                    user.getEmail(),
                    user.getPhone(),
                    filename,
                    user.getPhoto(),
                    user.getAutograph1(),
                    user.getAutograph2(),
                    user.getAutograph3(),
                    user.getId());
            if(update>0){
                user.setBanner(filename);
                request.getSession().setAttribute("user",user);
                Integer rs = 1;
                JSONObject res = new JSONObject();
                res.put("rs",rs);
                return res;
            }
        }
        Integer rs = 0;
        JSONObject res = new JSONObject();
        res.put("rs",rs);
        return res;
    }

    @RequestMapping(value = "/userShow")
    public ModelAndView usershow(HttpServletRequest request,Integer user_id) throws Exception{
        if(user_id!=null){
            List<User> userlist = userService.findByConditions(user_id, null, null, null);
            if(userlist.size()>0){
                User user = userlist.get(0);
                request.getSession().setAttribute("tagUser",user);
                User me = (User)request.getSession().getAttribute("user");
                if(me!=null){
                    List<Follow> follows = followService.selectMe(user.getId(), me.getId());
                    if(!follows.isEmpty()){
                        request.getSession().setAttribute("check",1);
                    }
                }
                return new ModelAndView("redirect:/usershow.jsp");
            }
        }
        return new ModelAndView("redirect:/404.jsp");
    }

    @RequestMapping("/followIt")
    @ResponseBody
    public JSONObject followIt(HttpServletRequest request){
        User tagUser = (User)request.getSession().getAttribute("tagUser");
        User user = (User)request.getSession().getAttribute("user");
        if(!tagUser.getId().equals(user.getId())){
            Timestamp create_time = new Timestamp(System.currentTimeMillis());
            Integer i = followService.create(tagUser.getId(), user.getId(), create_time);
            if(i>0){
                Integer rs = 1;
                JSONObject res = new JSONObject();
                res.put("rs",rs);
                return res;
            }
            else {
                return null;
            }
        }
        else {
            Integer rs = 0;
            JSONObject res = new JSONObject();
            res.put("rs",rs);
            return res;
        }
    }

    @RequestMapping("/NoFollowIt")
    @ResponseBody
    public JSONObject noFollowIt(HttpServletRequest request){
        User tagUser = (User)request.getSession().getAttribute("tagUser");
        User user = (User)request.getSession().getAttribute("user");
        List<Follow> followList = followService.selectMe(tagUser.getId(), user.getId());
        if(!followList.isEmpty()){
            Integer i = followService.delete(followList.get(0).getId());
            if(i>0){
                Integer rs = 1;
                JSONObject res = new JSONObject();
                res.put("rs",rs);
                return res;
            }
        }
        return null;
    }


}