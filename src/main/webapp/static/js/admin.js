function admin() {
    var img = "<img src='/static/images/weixin.jpg'/>";
    layer.open({
        type: 1,
        title: false,
        closeBtn: 0,
        area: '251px',
        skin: 'layui-layer-nobg', //没有背景色
        shadeClose: true,
        content: img
    });
}
function msg() {
    layer.msg("我们杀了一个程序员祭天！正在开发中~敬请期待");
}
function aboutToDay() {
    layer.msg("该站点仅供学习，欢迎同行一起交流学习，联系方式就在站内");
}
