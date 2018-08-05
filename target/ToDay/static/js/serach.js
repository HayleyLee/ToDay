function AppendUser(uid,userimg,username,autograph1,autograph2,autograph3,HowManyFollow,TheGuyFollow,TheGuyUpload){
    $("#user").append("<a href='/user/userShow?user_id="+uid+"'><ul class=\"arrow_box\" style=\"height: 150px\"><div class=\"sy\" style='width: 650px'><img src=\"/userphoto/"+userimg+"\"><span>"+username+"</span><p><span>"+autograph1+"</span><span>"+autograph2+"</span><span>"+autograph3+"</span></p><p><span>听众："+HowManyFollow+"</span><span> / 关注："+TheGuyFollow+"</span><span> / 投稿："+TheGuyUpload+"</span></p></div></ul></a>");
}
function ShowSerachArticle(json) {
    for(var i=0;i<json.length;i++){
        for(var key in json[i]){
            if(key=="aid"&&key!=null&&key!=""){
                var aid = json[i][key];
            }
            if(key=="aName"&&key!=null&&key!=""){
                var aname = json[i][key];
            }
            if(key=="img"&&key!=null&&key!=""){
                var img = json[i][key];
            }
            if(key=="article"&&key!=null&&key!=""){
                $("#article").append("<a href='/new.jsp?id="+aid+"'><ul class=\"arrow_box\" style=\"height: 150px\"><div class=\"sy\" style='width: 650px'><img src='/userphoto/"+img+"'><h3>"+aname+"</h3><p><span>"+json[i][key]+"</span></p></div></ul></a>");
            }
        }
    }
}
function ShowSerachUser(json) {
    for(var i=0;i<json.length;i++){
        var uid=null;
        var userimg=null;
        var username=null;
        var autograph1=null;
        var autograph2=null;
        var autograph3=null;
        var HowManyFollow=0;
        var TheGuyFollow=0;
        var TheGuyUpload=0;
        for(var key in json[i]){
            if(key=="uid"&&key!=null&&key!=""){
                uid = json[i][key];
            }
            if(key=="uName"&&key!=null&&key!=""){
                username = json[i][key];
            }
            if(key=="ua1"&&key!=null&&key!=""){
                autograph1=json[i][key];
            }
            if(key=="ua2"&&key!=null&&key!=""){
                autograph2=json[i][key];
            }
            if(key=="ua3"&&key!=null&&key!=""){
                autograph3=json[i][key];
            }
            if(key=="uPhoto"&&key!=null&&key!=""){
                userimg=json[i][key];
            }
            if(key=="uFollow"&&key!=null&&key!=""){
                HowManyFollow=json[i][key];
            }
            if(key=="wFollow"&&key!=null&&key!=""){
                TheGuyFollow=json[i][key];
            }
            if(key=="uUpload"&&key!=null&&key!=""){
                TheGuyUpload=json[i][key];
            }
        }
        if(uid!=null&&uid!=""){
            AppendUser(uid,userimg,username,autograph1,autograph2,autograph3,HowManyFollow,TheGuyFollow,TheGuyUpload);
        }
    }
}
function getSerach(seed) {
    $.ajax({
        type:"get",
        data:{"seed":seed},
        url:"/serach/serachAll",
        success:function (json) {
            ShowSerachUser(json);
            ShowSerachArticle(json);
        },
        error:function () {
            $("#content").append("<h3>找不到任何相关内容，请尝试减少或更换关键字</h3>");
        }
    });
}