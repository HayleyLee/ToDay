<%--
  Created by IntelliJ IDEA.
  User: lqh90
  Date: 2018/7/6
  Time: 22:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <link rel="stylesheet" href="./static/layui/css/layui.css">
    <link rel="stylesheet" href="./static/layui/css/layui.mobile.css">
    <link rel="stylesheet" href="./static/css/style.css">
</head>
<body>
<div class="main">
    <h3>上传的图片不可大于20M,建议上传1360*270图片</h3>
    <button type="button" class="layui-btn" id="photo">
        <i class="layui-icon">&#xe67c;</i>上传新背景
    </button>
    <button id="updateIt" class="layui-btn">上传</button>
</div>
</body>
<script src="./static/layui/layui.all.js"></script>
<script src="./static/js/jquery-3.3.1.min.js"></script>
<script>
    layui.use('upload', function(){
        var upload = layui.upload;
        //执行实例
        upload.render({
            elem: '#photo', //绑定元素
            url: '${ctx}/user/uploadBanner', //上传接口
            auto: false,
            size:"20480",
            bindAction:'#updateIt',
            done: function(res){
                if(res.rs == 1){
                    layer.msg("更换成功");
                    setTimeout("parent.layer.closeAll();",2000);
                }
                if(res.rs == 0){
                    layer.msg("更换失败");
                    setTimeout("parent.layer.closeAll();",2000);
                }
            },
            error: function(){
                layer.msg("更换失败，请稍后再试");
                setTimeout("parent.layer.closeAll();",2000);
            }
        });
    });
</script>
</html>
