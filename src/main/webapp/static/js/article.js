function createArticle() {
    layer.msg('请选择一种模式', {
        time: 0 //不自动关闭
        ,btn: ['普通模式', '超大文件模式']
        ,yes: function(index){
            layer.open({
                type: 2,
                skin: 'layui-layer-demo',
                closeBtn: 0,
                anim: 2,
                shadeClose: true,
                area: ['470px','570px'],
                content: '/article/normal',
                end: function () {
                    location.reload();
                }
            });
        }
        ,btn2: function () {
            layer.open({
                type: 2,
                skin: 'layui-layer-demo',
                closeBtn: 0,
                anim: 2,
                shadeClose: true,
                area: ['470px','570px'],
                content: '/article/big',
                end: function () {
                    location.reload();
                }
            });
        }
    });
}
function comment(obj) {
    var id = $(obj).parent('.dateview').next("span[name='id']").html();
    layer.open({
        type: 2,
        skin: 'layui-layer-demo',
        closeBtn: 0,
        anim: 2,
        shadeClose: true,
        area: ['350px','550px'],
        content: '/comment/update?article_id='+id
    });
}
function DisLike(obj) {
    var id = $(obj).parent('.dateview').next("span[name='id']").html();
    console.log(id);
    $.ajax({
        type:"post",
        data:{"article_id":id},
        url:"/article/dislike",
        success:function (data) {
            if(data.rs==1){
                $(obj).removeAttr("onclick");
                $(obj).attr("onclick","likeIt(this);");
                $(obj).css("background-image","url(static/images/like.ico)");
                var lc = parseInt($(obj).next("span[name='like']").html());
                $(obj).next("span[name='like']").html(lc-1);
            }
        },
        error:function () {
            layer.msg("数据获取异常，请稍后再试");
        }
    });
}
function likeIt(obj) {
    var id = $(obj).parent('.dateview').next("span[name='id']").html();
    console.log(id);
    $.ajax({
        type:"post",
        data:{"article_id":id},
        url:"/article/like",
        success:function (data) {
            if(data.rs==1){
                $(obj).removeAttr("onclick");
                $(obj).attr("onclick","DisLike(this);");
                $(obj).css("background-image","url(static/images/dislike.ico)");
                var lc = parseInt($(obj).next("span[name='like']").html());
                $(obj).next("span[name='like']").html(lc+1);
            }
        },
        error:function () {
            layer.msg("数据获取异常，请稍后再试");
        }
    });
}