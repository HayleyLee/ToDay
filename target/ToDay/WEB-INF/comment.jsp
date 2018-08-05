<%--
  Created by IntelliJ IDEA.
  User: lqh90
  Date: 2018/7/19
  Time: 20:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <link rel="icon" type="image/x-icon" href="${ctx}/static/images/nh.ico"  />
    <link href="${ctx}/static/css/base.css" rel="stylesheet">
    <link href="${ctx}/static/css/index.css" rel="stylesheet">
    <link href="${ctx}/static/layui/css/layui.css" rel="stylesheet">
    <link href="${ctx}/static/layui/css/layui.mobile.css" rel="stylesheet">
</head>
<body>
<div id="mid">
    <c:if test="${empty user}">
        <h3 style="margin: 15px">登陆后即可留下评论</h3>
    </c:if>
    <c:if test="${not empty user}">
        <button id="comment" class="layui-btn"><i class="layui-icon"></i>发表评论</button>
    </c:if>
</div>
</body>
<script src="${ctx}/static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script>
    var pn=0;
    var ps=10;
    var aid = ${param.article_id};
    $(document).ready(function () {
        $.ajax({
            type:"post",
            data:{"article_id":aid,"pageNumber":pn,"pageSize":ps},
            url:"${ctx}/comment/find",
            success:function (json) {
                for(var i=0;i<json.length;i++){
                    for(var key in json[i]) {
                        if(key=="username"&&json[i][key]!=null&&json[i][key]!=""){
                            var tempName = json[i][key];
                        }
                        if(key=="comment"&&json[i][key]!=null&&json[i][key]!=""){
                            $("#mid").append("<div style='margin: 20px'><ul><span>#"+(i+1)+"</span><h4>"+json[i][key]+"</h4></ul>");
                        }
                        if(key=="create_time"&&json[i][key]!=null&&json[i][key]!=""){
                            $("#mid").append("<p style='width: 300px' class=\"dateview\"><span>"+json[i][key]+"</span><span>"+tempName+"</span></p></div>");
                        }
                    }
                }
            },
            error:function () {
                layer.msg("数据获取异常，请稍后再试");
            }
        });
    })
</script>
<script>
    $("#comment").click(function () {
        layer.prompt({title: '写下您的评论', formType: 2}, function(pass, index){
            $.ajax({
                type:"post",
                data:{"comment":pass,"article_id":aid},
                url:"${ctx}/comment/create_comment",
                success:function (data) {
                    if(data==1){
                        layer.msg("发送成功");
                        setTimeout("parent.layer.closeAll();",2000);
                    }
                    if(data==0){
                        layer.msg("发送失败");
                        setTimeout("parent.layer.closeAll();",2000);
                    }
                    if(data==2){
                        layer.msg("评论字数应大于5或短于50,请重新编辑后发送");
                    }
                },
                error:function () {
                    layer.msg("数据获取异常，请稍后再试");
                }
            });
        });
    })
</script>
</html>
