<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>个人中心</title>
    <link href="${ctx}/static/css/about.css" rel="stylesheet">
    <link href="${ctx}/static/css/index.css" rel="stylesheet">
    <link href="${ctx}/static/css/base.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
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
            <a href="#"><span>关于我</span><span class="en">About me</span></a>
            <a href="" onclick="createArticle();return false"><span>发布段子</span><span class="en">Do it！</span></a>
        </c:if>
        <a href="#"><span>周边段友</span><span class="en">Thug Life</span></a>
        <a href="./followlist.jsp"><span>我的关注</span><span class="en">i like this guy</span></a>
        <a href="./whofollow.jsp"><span>谁关注我</span><span class="en">who like me</span></a>
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
<article class="aboutcon">
<div class="about left">
    <h2 class="title_tj">
        <p>我的<span>投稿</span></p>
    </h2>
    <div class="bloglist left" id="content">
    </div>
</div>
    <aside class="right">
        <div class="weather"><iframe width="250" scrolling="no" height="60" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=12&icon=1&num=1"></iframe></div>
        <div class="news">
            <input id="serach" type="text" placeholder="输入关键字搜索" class="layui-input"/>
            <button id="goSerach" type="button" class="layui-btn layui-btn-fluid">戳我搜索</button>
            <h3 class="links">
                <p>友情<span>链接</span></p>
            </h3>
            <ul class="website">
                <li><a href="" onclick="admin();return false">广告位招租吖~亲</a></li>
            </ul>
            <h3 class="returnIt">
                <p>意见<span>反馈</span></p>
            </h3>
            <a href="" onclick="admin();return false">网站管理员：QuinnLee</a>
        </div><br>
        <!-- Baidu Button BEGIN -->
        <div class="bdsharebuttonbox">
            <a href="#" class="bds_more" data-cmd="more"></a>
            <a href="#" class="bds_qzone" data-cmd="qzone"></a>
            <a href="#" class="bds_tsina" data-cmd="tsina"></a>
            <a href="#" class="bds_tqq" data-cmd="tqq"></a>
            <a href="#" class="bds_renren" data-cmd="renren"></a>
            <a href="#" class="bds_weixin" data-cmd="weixin"></a>
        </div>
        <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
        <!-- Baidu Button END -->
    </aside>
</article>
<footer>
  <p>Design by DanceSmile More Templates <a href="" onclick="admin();return false" target="_blank" title="商务合作">商务合作</a> - Collect from <a href="" onclick="admin();return false" title="QuinnLee" target="_blank">QuinnLee</a> <a href="/">网站统计</a></p>
</footer>

<script src="${ctx}/static/js/silder.js"></script>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/TopButton.js"></script>
<script src="${ctx}/static/js/admin.js"></script>
<script src="${ctx}/static/js/article.js"></script>
<script src="${ctx}/static/js/showMe.js"></script>
<script src="${ctx}/static/js/scroll.js"></script>
<script src="${ctx}/static/js/change.js"></script>

<script>
    function del(btn) {
    layer.msg('是否确定删除，此操作不可逆', {
        time: 0 //不自动关闭
        ,btn: ['删除', '算了']
        ,yes: function(index){
            var id = $(btn).next("span[name='id']").html();
            $.ajax({
                type:"post",
                data:{"article_id":id},
                url:"${ctx}/article/del",
                success:function (res) {
                    if(res==1){
                        layer.msg("删除成功");
                        setTimeout("location.reload();",3000);
                    }
                },
                error:function () {
                    layer.msg("删除失败，请稍后再试");
                    setTimeout("location.reload();",3000);
                }
            });
        }
        ,btn2: function () {
            parent.layer.closeAll();
        }
    });
}
    function comment(obj) {
        var id = $(obj).parent('.dateview').find("span[name='id']").html();
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
        var id = $(obj).parent('.dateview').find("span[name='id']").html();
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
        var id = $(obj).parent('.dateview').find("span[name='id']").html();
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
    $(document).ready(function () {
        getIndex();
    });
</script>
</body>
</html>