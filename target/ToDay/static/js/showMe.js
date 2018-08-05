var pageNumber=0;
var pageSize=10;
function AppendLastName(val) {
    $("#content").append("<h3 style='display: none' name='last' class=\"bloglist left\">"+val+"</h3>");
}
function Appendname(val) {
    $("#content").append("<h3 class=\"bloglist left\">"+val+"</h3>");
}
function Appendphoto(val) {
    $("#content").append("<figure><img src=\"/userphoto/"+val+"\"></figure>");
}
function Appendvideo(val) {
    $("#content").append("<div class=\"bloglist left\"><video width='400px' height='250px' class=\"bloglist left\" controls src=\"/userphoto/"+val+"\"></video></div>");
}
function Appendarticle(val) {
    $("#content").append("<ul><p>"+val+"</ul>");
}
function Appendcreate_time(val,userName,like,id) {
    $("#content").append("<p class=\"dateview\"><span>"+val+"</span><span>作者："+userName+"</span><button onclick=\"comment(this)\" class=\"layui-btn layui-btn-xs\">点我看评论</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick='likeIt(this)' class=\"layui-btn layui-btn-xs\" style='background:#f6f6f6;cursor: pointer;background-image:url(static/images/like.ico);'>&nbsp;&nbsp;&nbsp;&nbsp;</button><span name='like'>"+like+"</span>&nbsp;&nbsp;&nbsp;&nbsp;<button name='del' class='layui-btn layui-btn-xs layui-btn-danger' onclick='del(this)'>删除</button><span name='id' style='display: none'>"+id+"</span></p>");
}
function getIndex() {
    $.ajax({
        type:"get",
        data:{"pageNumber":pageNumber,"pageSize":pageSize},
        url:"/article/aboutMe",
        success:function (json) {
            for(var i=0;i<json.length;i++){
                var like=0;
                var id;
                var un;
                for(var key in json[i]){
                    if(key=="username"&&json[i][key]!=null&&json[i][key]!=""){
                        un=json[i][key];
                    }
                    if(key=="name"&&json[i][key]!=null&&json[i][key]!=""){
                        if(json.length==i+2){
                            AppendLastName(json[i][key]);
                        }
                        Appendname(json[i][key]);
                    }
                    if(key=="photo"&&json[i][key]!=null&&json[i][key]!=""){
                        Appendphoto(json[i][key]);
                    }
                    if(key=="video"&&json[i][key]!=null&&json[i][key]!=""){
                        Appendvideo(json[i][key]);
                    }
                    if(key=="article"&&json[i][key]!=null&&json[i][key]!=""){
                        Appendarticle(json[i][key]);
                    }
                    if(key=="like_count"&&json[i][key]!=null&&json[i][key]!=""){
                        like = json[i][key]
                    }
                    if(key=="article_id"&&json[i][key]!=null&&json[i][key]!=""){
                        id=json[i][key];
                    }
                    if(key=="create_time"&&json[i][key]!=null&&json[i][key]!="") {
                        Appendcreate_time(json[i][key], un, like,id);
                    }
                }
            }
            pageNumber+=pageSize;
        },
        error:function () {
            layer.msg("数据获取异常，请稍后再试");
        }
    });
}