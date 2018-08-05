<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
<title>谁关注我</title>
    <link href="${ctx}/static/css/about.css" rel="stylesheet">
    <link href="${ctx}/static/css/index.css" rel="stylesheet">
    <link href="${ctx}/static/css/base.css" rel="stylesheet">
    <link href="${ctx}/static/css/mood.css" rel="stylesheet">
    <link href="${ctx}/static/layui/css/layui.css" rel="stylesheet" >
    <link rel="icon" type="image/x-icon" href="${ctx}/static/images/nh.ico"  />

    <!--[if lt IE 9]>
    <script src="./static/js/modernizr.js"></script>
<![endif]-->
    <style>
        i{
            display: none;
        }
    </style>
</head>
<body>
<header>
    <div id="logo"><a href="#"></a></div>
    <nav class="topnav" id="topnav">
        <a href="./index.jsp"><span>首页</span><span class="en">Index</span></a>
        <c:if test="${not empty user}">
            <a href="./about.jsp"><span>关于我</span><span class="en">About me</span></a>
            <a href="" onclick="createArticle();return false"><span>发布段子</span><span class="en">Do it！</span></a>
        </c:if>
        <a href="#"><span>周边段友</span><span class="en">Thug Life</span></a>
        <a href="./followlist.jsp"><span>我的关注</span><span class="en">i like this guy</span></a>
        <a href="#"><span>谁关注我</span><span class="en">who like me</span></a>
        <c:if test="${empty user}">
            <a href="" onclick="login();return false"> <span>戳我登录</span><span class="en">来啊！快活啊！</span></a>
            <a href="" onclick="create();return false"> <span>戳我注册</span><span class="en">从此一起嗨！</span></a>
        </c:if>
        <c:if test="${not empty user}">
            <a href="${ctx}/user/logout"><span>退出登录</span><span class="en">别走嘛~</span></a>
        </c:if>
    </nav>
</header>
<div style=" background: url(/userphoto/${user.banner}) top center; height: 265px; overflow: hidden ">
    <section class="box">
        <button id="banner" class="layui-btn layui-btn-sm" style="float: right">更换背景</button>
        <ul class="texts" id="autograph">
            <p>${user.autograph1}</p>
            <p>${user.autograph2}</p>
            <p>${user.autograph3}<a href="" onclick="function n(){} return false"><i id="change" class="layui-icon">&#xe642;</i></a></p>
        </ul>
        <div class="avatar" id="photo">
            <a href="#" STYLE="background: url(/userphoto/${user.photo}) no-repeat; background-size: 130px 130px">
                <span id="un">${user.name}</span>
            </a>
        </div>
    </section>
</div>
<div class="moodlist">
  <div class="bloglist" id="show">
  </div>
</div>
<footer>
    <p>Design by DanceSmile More Templates <a href="" onclick="admin();return false" target="_blank" title="商务合作">商务合作</a> - Collect from <a href="" onclick="admin();return false" title="QuinnLee" target="_blank">QuinnLee</a> <a href="/">网站统计</a></p>
</footer>
<script src="${ctx}/static/js/silder.js"></script>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script src="static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/TopButton.js"></script>
<script src="${ctx}/static/js/change.js"></script>
<script src="${ctx}/static/js/article.js"></script>
<script src="${ctx}/static/js/admin.js"></script>
<script>
    function AppendFollowList(userimg,username,autograph1,autograph2,autograph3,HowManyFollow,TheGuyFollow,TheGuyUpload,FollowTime){
        $("#show").append("<ul class=\"arrow_box\" style=\"height: 150px\"><div class=\"sy\" style='width: 650px'><img src=\"/userphoto/"+userimg+"\"><span>"+username+"</span><p><span>"+autograph1+"</span><span>"+autograph2+"</span><span>"+autograph3+"</span></p><p><span>听众："+HowManyFollow+"</span><span> / 关注："+TheGuyFollow+"</span><span> / 投稿："+TheGuyUpload+"</span></p></div><span class=\"dateview\">"+FollowTime+"</span></ul>");
    }
</script>
<script>
    function getWhoFollowList() {
        $.ajax({
            type:"post",
            url:"${ctx}/follow/whoFollowMe",
            success:function (json){
                for(var i=0;i<json.length;i++){
                    var userimg=null;
                    var username=null;
                    var autograph1=null;
                    var autograph2=null;
                    var autograph3=null;
                    var HowManyFollow=0;
                    var TheGuyFollow=0;
                    var TheGuyUpload=0;
                    var FollowTime=null;
                    for(var key in json[i]){
                        if(key=="userimg"&&json[i][key]!=null&&json[i][key]!=""){
                            userimg=json[i][key];
                        }
                        if(key=="username"&&json[i][key]!=null&&json[i][key]!=""){
                            username=json[i][key];
                        }
                        if(key=="autograph1"&&json[i][key]!=null&&json[i][key]!=""){
                            autograph1=json[i][key];
                        }
                        if(key=="autograph2"&&json[i][key]!=null&&json[i][key]!=""){
                            autograph2=json[i][key];
                        }
                        if(key=="autograph3"&&json[i][key]!=null&&json[i][key]!=""){
                            autograph3=json[i][key];
                        }
                        if(key=="HowManyFollow"&&json[i][key]!=null&&json[i][key]!=""){
                            HowManyFollow=json[i][key];
                        }
                        if(key=="TheGuyFollow"&&json[i][key]!=null&&json[i][key]!=""){
                            TheGuyFollow=json[i][key];
                        }
                        if(key=="TheGuyUpload"&&json[i][key]!=null&&json[i][key]!=""){
                            TheGuyUpload=json[i][key];
                        }
                        if(key=="FollowTime"&&json[i][key]!=null&&json[i][key]!=""){
                            FollowTime=json[i][key];
                        }
                    }
                    AppendFollowList(userimg,username,autograph1,autograph2,autograph3,HowManyFollow,TheGuyFollow,TheGuyUpload,FollowTime);
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    }
    $(document).ready(function () {
        getWhoFollowList();
    });
</script>
</body>
</html>