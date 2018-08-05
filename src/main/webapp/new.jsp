<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
<title></title>
  <link href="${ctx}/static/css/base.css" rel="stylesheet">
  <link href="${ctx}/static/css/new.css" rel="stylesheet">
  <link href="${ctx}/static/layui/css/layui.css" rel="stylesheet">
  <link href="${ctx}/static/layui/css/layui.mobile.css" rel="stylesheet">
  <link rel="icon" type="image/x-icon" href="${ctx}/static/images/nh.ico"  />

  <!--[if lt IE 9]>
<script src="static/js/modernizr.js"></script>
<![endif]-->
</head>
<body>
<header>
  <div id="logo"><a href="/"></a></div>
  <nav class="topnav" id="topnav">
    <a href="index.jsp"><span>首页</span><span class="en">Index</span></a>
    <c:if test="${not empty user}">
      <a href="./about.jsp"><span>关于我</span><span class="en">About me</span></a>
      <a href="" onclick="createArticle();return false"><span>发布段子</span><span class="en">Do it！</span></a>
    </c:if>
    <a href="" onclick="msg();return false"><span>周边段友</span><span class="en">Thug Life</span></a>
    <a href="" onclick="msg();return false"><span>保留功能1</span><span class="en">？？？</span></a>
    <a href="" onclick="msg();return false"><span>保留功能2</span><span class="en">？？？</span></a>
    <c:if test="${empty user}">
      <a href="" onclick="login();return false"> <span>戳我登录</span><span class="en">来啊！快活啊！</span></a>
      <a href="" onclick="create();return false"> <span>戳我注册</span><span class="en">从此一起嗨！</span></a>
    </c:if>
    <c:if test="${not empty user}">
      <a href="${ctx}/user/logout"><span>退出登录</span><span class="en">别走嘛~</span></a>
    </c:if>
    <a href="" onclick="aboutToDay();return false"><span>关于ToDay</span><span class="en">喵喵喵</span></a>
  </nav>
</header>
<article class="blogs">
  <div class="index_about" id="show">
  </div>
  <aside class="right">
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
    <div class="blank"></div>
    <div class="news">
      <input id="serachIt" type="text" placeholder="输入关键字搜索" class="layui-input"/>
      <button id="goSerach" type="button" class="layui-btn layui-btn-fluid">戳我搜索</button>
      <h3>
        <p>最新<span>推送</span></p>
      </h3>
      <ul class="rank" id="rank">
      </ul>
      <h3 class="ph">
        <p>今日<span>最Top</span></p>
      </h3>
      <ul class="paih" id="top">
      </ul>
      <h3 class="links">
        <p>相关<span>推荐</span></p>
      </h3>
      <ul class="website" id="serach">
      </ul>
      <h3 class="returnIt">
        <p>意见<span>反馈</span></p>
      </h3>
      <a href="" onclick="admin();return false">网站管理员：QuinnLee</a>
    </div>
  </aside>
</article>
<footer>
  <p>Design by DanceSmile More Templates <a href="" onclick="admin();return false" target="_blank" title="商务合作">商务合作</a> - Collect from <a href="" onclick="admin();return false" title="QuinnLee" target="_blank">QuinnLee</a> <a href="/">网站统计</a></p>
</footer>
<script src="static/js/silder.js"></script>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/TopButton.js"></script>
<script src="${ctx}/static/js/admin.js"></script>
<script src="${ctx}/static/js/user.js"></script>
<script src="${ctx}/static/js/rank.js"></script>
<script>
    function comment(obj) {
        var id = $(obj).next("button[name='likeb']").next("span[name='like']").next("span[name='id']").html();
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
        var id = $(obj).next("span[name='like']").next("span[name='id']").html();
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
        var id = $(obj).next("span[name='like']").next("span[name='id']").html();
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
    function createArticle() {
        layer.msg('请选择一种模式', {
            time: 0 //不自动关闭
            ,btn: ['普通模式', '超大文件模式']
            ,yes: function(index){
                layer.open({
                    type: 2,
                    skin: 'layui-layer-demo',
                    closeBtn: 0,
                    anim: 2,
                    shadeClose: true,
                    area: ['470px','570px'],
                    content: '/article/normal',
                    end: function () {
                        location.reload();
                    }
                });
            }
            ,btn2: function () {
                layer.open({
                    type: 2,
                    skin: 'layui-layer-demo',
                    closeBtn: 0,
                    anim: 2,
                    shadeClose: true,
                    area: ['470px','570px'],
                    content: '/article/big',
                    end: function () {
                        location.reload();
                    }
                });
            }
        });
    }
    function AppendName(obj) {
        $("#show").append("<h2 class=\"c_titile\">"+obj+"</h2>");
        $("title").html(obj);
    }
    function AppendMsg(create_time,un,like,user_id,id) {
        $("#show").append("<p class=\"box_c\"><span class=\"d_time\">发布时间："+create_time+"</span><span>up：<a href='/user/userShow?user_id="+user_id+"'>"+un+"</a></span><button onclick=\"comment(this)\" class=\"layui-btn layui-btn-xs\">点我看评论</button><button name='likeb' onclick='likeIt(this)' class=\"layui-btn layui-btn-xs\" style='background:#f6f6f6;cursor: pointer;background-image:url(static/images/like.ico);'>&nbsp;&nbsp;&nbsp;&nbsp;</button><span name='like'>"+like+"</span><span name='id' style='display: none'>"+id+"</span></p>");
    }
    function AppendVideo(obj) {
        $("#show").append("<video width='710px' height='450px' src=\"/userphoto/"+obj+"\" controls controlsList='nodownload' autoplay='autoplay'></video>");
    }
    function AppendArticle(article,photo) {
        $("#show").append("<ul class=\"infos\"><p>"+article+"</p><div style=\"width='700px';height='400px'\"><img width='700px' height='400px' src=\"/userphoto/"+photo+"\"></div></ul>");
    }
    function getIndex(aid) {
        $.ajax({
            type:"post",
            data:{article_id:aid},
            url:"/article/newShow",
            success:function (json) {
                for(var i=0;i<json.length;i++){
                    for(var key in json[i]){
                        if(key=="name"&&key!=null&&key!=""){
                            AppendName(json[i][key]);
                        }
                        if(key=="create_time"&&key!=null&&key!=""){
                            var create_time=json[i][key];
                        }
                        if(key=="user_name"&&key!=null&&key!=""){
                            var un=json[i][key];
                        }
                        if(key=="like"&&key!=null&&key!=""){
                            var like=json[i][key];
                        }
                        if(key=="user_id"&&key!=null&&key!=""){
                            var user_id=json[i][key];
                        }
                        if(key=="id"&&key!=null&&key!=""){
                            AppendMsg(create_time,un,like,user_id,json[i][key]);
                        }
                        if(key=="video"&&key!=null&&key!=""){
                            AppendVideo(json[i][key]);
                        }
                        if(key=="article"&&key!=null&&key!=""){
                            var article=json[i][key];
                        }
                        if(key=="photo"&&key!=null&&key!=""){
                            AppendArticle(article,json[i][key]);
                        }
                    }
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
        return true;
    }
    function getSerachLike(aid) {
        $.ajax({
            type:"get",
            data:{"aid":aid},
            url:"/article/serachArticle",
            success:function (json) {
                for(var i=0;i<json.length;i++){
                    for(var key in json[i]){
                        if(key=="id"&&key!=null&&key!=""){
                            var aid=json[i][key];
                        }
                        if(key=="name"&&key!=null&&key!=""){
                            $("#serach").append("<li><a href='/new.jsp?id="+aid+"' title='"+json[i][key]+"' target='_self'>"+json[i][key]+"</a></li>");
                        }
                    }
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    }

    $(document).ready(function () {
      if(getIndex(${param.id})==true){
          getRank();
          getTop();
          getSerachLike(${param.id});
      }
  });
  $("#goSerach").click(function () {
      var tempSeed = $("#serachIt").val();
      window.location.replace("${ctx}/serach/send?seed="+tempSeed);
  });
</script>
</body>
</html>