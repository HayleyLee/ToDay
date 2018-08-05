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
    <title>注册</title>
    <script src="./static/layui/layui.all.js"></script>
    <script src="./static/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="./static/layui/css/layui.css">
    <link rel="stylesheet" href="./static/layui/css/layui.mobile.css">
    <link rel="stylesheet" href="./static/css/style.css">
</head>
<body>
<div class="main">
    <form class="layui-form" action="${ctx}/user/create" method="post">
        <div class="layui-form-mid layui-word-aux"></div>
        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input id="name" onblur="loseName()" style="width: 220px" type="text" name="name" required lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
                <input id="pass1" onblur="lose1()" style="width: 220px" type="password" name="pass1" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
                <input id="pass2" onblur="lose2()" style="width: 220px" type="password" name="pass2" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-inline">
                <input id="phone" style="width: 220px" type="text" name="phone" required lay-verify="required" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <br>
        <div class="layui-form-item">
            <label class="layui-form-label">手机验证码</label>
            <div class="layui-input-inline">
                <button id="sendCode" type="button" style="width: 100px" class="layui-btn layui-btn-fluid">获取</button>
                <input id="code" name="code" style="width: 100px" type="text" placeholder="请输入验证码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button formtarget="_top" id="create" style="width: 180px" class="layui-btn layui-btn-fluid">成为新人</button>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    var codecup="";
    var wait = 60;
    function time(btn) {
        if (wait == 0) {
            btn.attr("class","layui-btn layui-btn-fluid");
            btn.value = "获取";
            wait = 60;
        } else {
            btn.attr("class", "layui-btn layui-btn-disabled");
            btn.value = wait + "秒后重新获取验证码";
            wait--;
            setTimeout(function () {
                    time(btn);
                },
                1000)
        }
    }
    function loseName() {
        var name = document.getElementById('name').value;
        if(name.length<1||name===""){
            layer.msg('请输入账号');
        }
        if(name.length>10){
            layer.msg('账号不能长于10个字符');
        }
    }
    function lose1() {
        var pass1 = document.getElementById('pass1').value;
        if(name.length<1||name==""){layer.msg('请输入密码');}
        if (pass1>=48 && pass1 <=57){layer.msg('密码必须由数字和字母组成');} //数字
        if (pass1>=65 && pass1 <=90&&pass1>=97 && pass1 <=122){layer.msg('密码必须由数字和字母组成');} //字母
        if (pass1.length>20){layer.msg('密码长度不能超过20位');}
        if (pass1.length<6){layer.msg('密码长度不能短于6位');}
    }
    function lose2() {
        var pass1 = document.getElementById('pass1').value;
        var pass2 = document.getElementById('pass2').value;
        if(pass1!==pass2){layer.msg('两次输入的密码不一致');}
    }

    $("#sendCode").click(function () {
        var phone = $("#phone").val();
        $.ajax({
            type:"post",
            data:{"phone":phone},
            url:"${ctx}/user/sendCode",
            success:function (data) {
                if(data!==null||data!==""){
                    codecup = data;
                    layer.msg("验证码已发送至"+phone);
                    var btn = $("#sendCode");
                    time(btn);
                }
                else{
                    layer.msg("发送失败，请稍后再试");
                }
            }
        });
    });
    $("#create").click(function () {
        if(codecup!==$("#code").val()){
            layer.msg("验证码输入错误！");
            return false;
        }
    });
</script>
</html>
