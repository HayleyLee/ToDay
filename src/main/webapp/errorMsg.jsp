<%--
  Created by IntelliJ IDEA.
  User: lqh90
  Date: 2018/7/11
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noindex,nofollow">
    <title>奇怪的错误</title>
    <link rel="icon" type="image/x-icon" href="${ctx}/static/images/nh.ico"  />
    <style>
        body{font-size: 14px;font-family: 'helvetica neue',tahoma,arial,'hiragino sans gb','microsoft yahei','Simsun',sans-serif; background-color:#fff; color:#808080;}
        .wrap{margin:200px auto;width:510px;}
        td{text-align:left; padding:2px 10px;}
        td.header{font-size:22px; padding-bottom:10px; color:#000;}
        td.check-info{padding-top:20px;}
        a{color:#328ce5; text-decoration:none;}
        a:hover{text-decoration:underline;}
    </style>
</head>
<body>
<div class="wrap">
    <table>
        <tr>
            <td rowspan="5" style=""><img src="https://ws1.sinaimg.cn/large/a15b4afegy1fhsfdznep4j2020020web.jpg" alt="又一个极简的错误页面"></td>
            <td class="header">很抱歉！登录失败了</td>
        </tr>
        <tr><td>原因一：你敲错了账号或密码</td></tr>
        <tr><td>原因二：这个页面已经被网站管理员(也就是我...)删了</td></tr>
        <tr><td>如果尝试重新登陆没能解决问题，你可以联系<a href="" onclick="admin(); return false">QuinnLee</a>反馈</td></tr>
        <tr><td class="check-info">或者，你也可以<a href="${ctx}/index.jsp">先去首页逛逛</a></td></tr>
    </table>
</div>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/admin.js"></script>
</body>
</html>
