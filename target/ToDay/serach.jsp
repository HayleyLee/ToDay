<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
<title>搜索结果</title>
  <link href="static/css/base.css" rel="stylesheet">
  <link href="static/css/index.css" rel="stylesheet">
  <link href="${ctx}/static/css/mood.css" rel="stylesheet">
  <link rel="stylesheet" href="static/layui/css/layui.css">
  <link rel="icon" type="image/x-icon" href="${ctx}/static/images/nh.ico"  />

  <!--[if lt IE 9]>
<script src="./static/js/modernizr.js"></script>

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
<article>
  <h2 class="title_tj">
    <p>文章<span>推荐</span></p>
  </h2>
  <div style="width: 700px" class="bloglist left" id="content">
    <div id="article" style="height:auto;">

    </div>
    <div id="user" style="height:auto;">

    </div>
  </div>
  <aside class="right">
    <div class="weather"><iframe width="250" scrolling="no" height="60" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=12&icon=1&num=1"></iframe></div>
    <div class="news">
      <input id="serach" type="text" placeholder="输入关键字搜索" class="layui-input"/>
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

<script src="static/js/silder.js"></script>
<script src="static/layui/layui.all.js"></script>
<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/static/js/TopButton.js"></script>
<script src="${ctx}/static/js/admin.js"></script>
<script src="${ctx}/static/js/user.js"></script>
<script src="${ctx}/static/js/rank.js"></script>
<script src="${ctx}/static/js/serach.js"></script>

<script>
</script>
<script>
    $(document).ready(function () {
        window.seed = "<%=session.getAttribute("seed") %>";
        getSerach(seed);
        getRank();
        getTop();
    });
</script>
<script>
    $("#goSerach").click(function () {
        var tempSeed = $("#serach").val();
        window.location.replace("${ctx}/serach/send?seed="+tempSeed);
    });
</script>
</body>
</html>