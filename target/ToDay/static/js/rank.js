function getRank() {
    $.ajax({
        type:"get",
        data:{"pn":0,"ps":10},
        url:"/article/descIt",
        success:function (json) {
            for(var i=0;i<json.length;i++){
                for(var key in json[i]){
                    if(key=="id"&&key!=null&&key!=""){
                        var aid=json[i][key];
                    }
                    if(key=="name"&&key!=null&&key!=""){
                        $("#rank").append("<li><a href='/new.jsp?id="+aid+"' title='"+json[i][key]+"' target='_self'>"+json[i][key]+"</a></li>");
                    }
                }
            }
        },
        error:function () {
            layer.msg("数据获取异常，请稍后再试");
        }
    });
}
function getTop() {
    $.ajax({
        type:"get",
        data:{"pn":0,"ps":10},
        url:"/article/Top",
        success:function (json) {
            for(var i=0;i<json.length;i++){
                for(var key in json[i]){
                    if(key=="id"&&key!=null&&key!=""){
                        var aid=json[i][key];
                    }
                    if(key=="name"&&key!=null&&key!=""){
                        $("#top").append("<li><a href='/new.jsp?id="+aid+"' title='"+json[i][key]+"' target='_self'>"+json[i][key]+"</a></li>");
                    }
                }
            }
        },
        error:function () {
            layer.msg("数据获取异常，请稍后再试");
        }
    });
}