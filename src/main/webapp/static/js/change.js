$(function(){
    $("#autograph").hover(function() {
        $(this).find('i').show();
    }, function() {
        $(this).find('i').hide();
    });
});
$("#change").click(function () {
    layer.open({
        type: 2,
        area: ['450px', '300px'],
        skin: 'layui-layer-rim',
        content: '/changeAutograph.jsp',
        end: function(){
            location.reload();
        }
    });
});
$("#photo").click(function () {
    layer.open({
        type: 2,
        area: ['400px', '400px'],
        skin: 'layui-layer-rim',
        content: '/updatephoto.jsp',
        end: function(){
            location.reload();
        }
    });
});
$("#banner").click(function () {
    layer.open({
        type: 2,
        area: ['400px', '400px'],
        skin: 'layui-layer-rim',
        content: '/updatebanner.jsp',
        end: function(){
            location.reload();
        }
    });
});