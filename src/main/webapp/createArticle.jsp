<%--
  Created by IntelliJ IDEA.
  User: lqh90
  Date: 2018/7/21
  Time: 22:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
    <title>普通模式</title>
</head>
<body>
<div id="edit">
    <div style="margin-bottom: 20px; padding: 10px">
        <form>
            <div class="layui-form-item" style="margin: 20px">
                <label class="layui-form-label">标题栏：</label>
                <input style="width:270px;" id="title" required lay-verify="required" placeholder="请不要做标题党" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-item"style="margin: 20px">
                <label class="layui-form-label">正文</label>
                <textarea id="article" class="layui-textarea" style="display: none"></textarea>
            </div>
            <div class="layui-form-item"style="margin: 20px">
                <button type="button" class="layui-btn" id="uploadfile">
                    <i class="layui-icon">&#xe67c;</i>上传图片或视频
                </button>
                <button class="layui-btn" type="button" id="uploadall">发送</button>
                <p>*最多允许同时上传一个图片和一个视频</p>
                <p>*文件大小不能超过5MB</p>
            </div>
        </form>
    </div>
    <blockquote class="layui-elem-quote layui-quote-nm" style="margin: 20px;">
        预览图：
        <div class="layui-upload-list" id="demo2"></div>
    </blockquote>
</div>
</body>
<script src="${ctx}/static/layui/layui.js"></script>
<script src="${ctx}/static/layui/layui.all.js"></script>
<script src="${ctx}/static/js/jquery-3.3.1.min.js"></script>
<script>
    var indexs;
    layui.use('layedit', function(){
        layedit = layui.layedit,
            $ = layui.jquery;
        //自定义工具栏
        indexs = layedit.build('article', {
            tool: ['face', 'link', 'unlink', '|', 'left', 'center', 'right']
            ,height: 100
        })
    });
    layui.use('upload', function(){
        var upload = layui.upload;
        //执行实例
        upload.render({
            elem: '#uploadfile', //绑定元素
            accept: 'file',
            exts: 'jpg|png|jpeg|mp4',
            url: '${ctx}/article/saveArticle', //上传接口
            auto: false,
            size:5500,
            multiple: true,
            number: 2,
            bindAction:'#uploadall',
            choose: function(obj) {
                var files = this.files = obj.pushFile();
                obj.preview(function(index, file, result) {
                    $('#demo2').append('<img src="' + result
                        + '" alt="' + file.name
                        +'"height="92px" width="92px" class="layui-upload-img uploadImgPreView">')
                });
            },
            before: function(obj) {
                layer.msg('图片上传中...', {
                    icon: 16,
                    shade: 0.01,
                    time: 0
                })
            },
            allDone: function(result){
                if(result!=null){
                    layedit.sync(indexs);
                    $.ajax({
                        type:'post',
                        data:{"title":$("#title").val(),"article":$("#article").val()},
                        url:"${ctx}/article/sendArticle",
                        success:function (r) {
                            if(r.rs==1){
                                layer.msg("上传成功");
                                setTimeout("parent.layer.closeAll();",2000);
                            }
                            if(r.rs==0){
                                layer.msg("上传失败,请检查标题和正文内容是否过长(标题:30 - 正文:1000)");
                                setTimeout("parent.layer.closeAll();",5000);
                            }
                        }
                    });
                }
            },
            error: function () {
                layer.msg("上传失败,稍后再试");
                setTimeout("location.reload();",2000);
            }
        });
    });
</script>
</html>
