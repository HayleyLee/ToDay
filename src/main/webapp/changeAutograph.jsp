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
    <script src="${ctx}/static/layui/layui.all.js"></script>
    <script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.mobile.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="main">
        <div class="layui-form-mid layui-word-aux"></div>
        <div class="layui-form-item">
            <label class="layui-form-label">个性一连</label>
            <div class="layui-input-inline">
                <input id="a1" style="width: 200px" type="text" placeholder="如不设置请按保存" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">个性二连</label>
            <div class="layui-input-inline">
                <input id="a2" style="width: 200px" type="text" placeholder="如不设置请按保存" autocomplete="off" class="layui-input">
            </div>
        </div>
    <div class="layui-form-item">
        <label class="layui-form-label">个性三连</label>
        <div class="layui-input-inline">
            <input id="a3" style="width: 200px" type="text" placeholder="如不设置请按保存" autocomplete="off" class="layui-input">
        </div>
    </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button id="changeIt" style="width: 180px" class="layui-btn layui-btn-radius layui-btn-danger">保存</button>
            </div>
        </div>
</div>
</body>
<script>
    $("#changeIt").click(function () {
        var autograph1 = $("#a1").val();
        var autograph2 = $("#a2").val();
        var autograph3 = $("#a3").val();
        idc = ${user.id};
        $.ajax({
            type:"post",
            url:"${ctx}/user/updateAutograph",
            data:{"id":idc,"autograph1":autograph1,"autograph2":autograph2,"autograph3":autograph3},
            success:function (data) {
                if(data===1){
                    layer.msg("修改成功");
                    setTimeout("parent.layer.closeAll();",2000);
                }
                if(data===0){
                    layer.msg("修改失败");
                    setTimeout("parent.layer.closeAll();",2000);
                }
            }
        });
    })
</script>
</html>
