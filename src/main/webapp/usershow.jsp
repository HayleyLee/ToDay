<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>${tagUser.name}</title>
    <link href="${ctx}/static/css/about.css" rel="stylesheet">
    <link href="${ctx}/static/css/index.css" rel="stylesheet">
    <link href="${ctx}/static/css/base.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">

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
        <c:if test="${not empty user}">
            <a href="./followlist.jsp"><span>我的关注</span><span class="en">i like this guy</span></a>
            <a href="./whofollow.jsp"><span>谁关注我</span><span class="en">who like me</span></a>
        </c:if>
        <c:if test="${empty user}">
            <a href="" onclick="login();return false"> <span>戳我登录</span><span class="en">来啊！快活啊！</span></a>
            <a href="" onclick="create();return false"> <span>戳我注册</span><span class="en">从此一起嗨！</span></a>
        </c:if>
        <c:if test="${not empty user}">
            <a href="${ctx}/user/logout"><span>退出登录</span><span class="en">别走嘛~</span></a>
        </c:if>
    </nav>
</header>
<div style=" background: url(/userphoto/${tagUser.banner}) top center; height: 265px; overflow: hidden ">
    <section class="box">
        <ul class="texts" id="autograph">
            <p>${tagUser.autograph1}</p>
            <p>${tagUser.autograph2}</p>
            <p>${tagUser.autograph3}</p>
        </ul>
        <div class="avatar" id="photo">
            <a href="#" STYLE="background: url(/userphoto/${tagUser.photo}) no-repeat; background-size: 130px 130px">
                <span id="un">${tagUser.name}</span>
            </a>
        </div>
    </section>
</div>
<article class="aboutcon">
<div class="about left">
    <h2 class="title_tj">
        <p>他的<span>投稿</span></p>
    </h2>
    <div class="bloglist left" id="content">
    </div>
</div>
<aside class="right">  
    <div class="about_c">
        <c:if test="${not empty user}">
            <c:if test="${not empty check}">
                <button onclick="NoFollowIt(this)" style="width: 200px" class="layui-btn layui-btn-radius layui-btn-warm">取消关注</button>
            </c:if>
            <c:if test="${empty check}">
                <button onclick="FollowIt(this)" style="width: 200px" class="layui-btn layui-btn-radius layui-btn-warm">关注</button>
            </c:if>
        </c:if>
        <c:if test="${empty user}">
            <button style="width: 200px" class="layui-btn layui-btn-radius layui-btn-disabled">登陆后即可关注</button>
        </c:if>
    </div>
</aside>
</article>
<footer>
    <p>Design by DanceSmile More Templates <a href="" onclick="admin();return false" target="_blank" title="商务合作">商务合作</a> - Collect from <a href="" onclick="admin();return false" title="QuinnLee" target="_blank">QuinnLee</a> <a href="/">网站统计</a></p>
</footer>

<script src="${ctx}/static/js/silder.js"></script>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/user.js"></script>
<script src="${ctx}/static/js/article.js"></script>
<script src="${ctx}/static/js/TopButton.js"></script>
<script src="${ctx}/static/js/scroll.js"></script>
<script src="${ctx}/static/js/userShow.js"></script>
<script src="${ctx}/static/js/admin.js"></script>

<script>
    function comment(obj) {
        var id = $(obj).parent('.dateview').next("span[name='id']").html();
        layer.open({
            type: 2,
            skin: 'layui-layer-demo',
            closeBtn: 0,
            anim: 2,
            shadeClose: true,
            area: ['350px','550px'],
            content: '/comment/update?article_id='+id
        });
    }
    function DisLike(obj) {
        var id = $(obj).parent('.dateview').next("span[name='id']").html();
        console.log(id);
        $.ajax({
            type:"post",
            data:{"article_id":id},
            url:"/article/dislike",
            success:function (data) {
                if(data.rs==1){
                    $(obj).removeAttr("onclick");
                    $(obj).attr("onclick","likeIt(this);");
                    $(obj).css("background-image","url(static/images/like.ico)");
                    var lc = parseInt($(obj).next("span[name='like']").html());
                    $(obj).next("span[name='like']").html(lc-1);
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    }
    function likeIt(obj) {
        var id = $(obj).parent('.dateview').next("span[name='id']").html();
        console.log(id);
        $.ajax({
            type:"post",
            data:{"article_id":id},
            url:"/article/like",
            success:function (data) {
                if(data.rs==1){
                    $(obj).removeAttr("onclick");
                    $(obj).attr("onclick","DisLike(this);");
                    $(obj).css("background-image","url(static/images/dislike.ico)");
                    var lc = parseInt($(obj).next("span[name='like']").html());
                    $(obj).next("span[name='like']").html(lc+1);
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    }
</script>
<script>
    function NoFollowIt(obj) {
        $.ajax({
            type:"post",
            url:"${ctx}/user/NoFollowIt",
            success:function (data) {
                if(data.rs==1){
                    $(obj).attr("class","layui-btn layui-btn-radius layui-btn-warm");
                    $(obj).html("关注");
                    $(obj).removeAttr("onclick");
                    $(obj).attr("onclick","FollowIt(this);");
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    }
    function FollowIt(obj) {
        $.ajax({
            type:"post",
            url:"${ctx}/user/followIt",
            success:function (data) {
                if(data.rs==1){
                    $(obj).attr("class","layui-btn layui-btn-radius layui-btn-normal");
                    $(obj).html("取消关注");
                    $(obj).removeAttr("onclick");
                    $(obj).attr("onclick","NoFollowIt(this);");
                }
                if(data.rs==0){
                    layer.msg("并不能自己关注自己喔~");
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    }
</script>
<script>
    $(document).ready(function () {
        getTagMsg();
    });
</script>
</body>
</html>