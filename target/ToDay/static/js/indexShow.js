var pageNumber=0;
var pageSize=20;

function AppendID(val) {
    $("#content").append("<span name='id' style='display: none'>"+val+"</span>")
}
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
    $("#content").append("<video width='700px' height='250px' class=\"bloglist left\" src=\"/userphoto/"+val+"\" controls controlsList='nodownload'></video>");
}
function Appendarticle(val) {
    $("#content").append("<ul><p>"+val+"</ul>");
}
function Appendcreate_time(val,userName,like,user_id) {
    $("#content").append("<p class=\"dateview\"><span>"+val+"</span><a href='./user/userShow?user_id="+user_id+"'><span>up："+userName+"</span></a><button onclick=\"comment(this)\" class=\"layui-btn layui-btn-xs\">点我看评论</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick='likeIt(this)'class=\"layui-btn layui-btn-xs\" style='background:#f6f6f6;cursor: pointer;background-image:url(static/images/like.ico);'>&nbsp;&nbsp;&nbsp;&nbsp;</button><span name='like'>"+like+"</span></p>");
}
function getIndex() {
    $.ajax({
        type:"get",
        data:{"pageNumber":pageNumber,"pageSize":pageSize},
        url:"/article/indexshow",
        success:function (json) {
            for(var i=0;i<json.length;i++){
                var un=null;
                var uid=0;
                var like=0;
                for(var key in json[i]){
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
                    if(key=="username"&&json[i][key]!=null&&json[i][key]!=""){
                        un=json[i][key];
                    }
                    if(key=="user_id"&&json[i][key]!=null&&json[i][key]!=""){
                        uid=json[i][key];
                    }
                    if(key=="like_count"&&json[i][key]!=null&&json[i][key]!=""){
                        like = json[i][key]
                    }
                    if(key=="create_time"&&json[i][key]!=null&&json[i][key]!=""){
                        Appendcreate_time(json[i][key],un,like,uid);
                    }
                    if(key=="article_id"&&json[i][key]!=null&&json[i][key]!=""){
                        AppendID(json[i][key]);
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