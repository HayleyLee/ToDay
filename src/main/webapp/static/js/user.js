function login(){
    layer.open({
        type: 2,
        title: '放心，这是登陆页面',
        area: ['400px', '250px'],
        skin: 'layui-layer-rim',
        content: '/userlogin.jsp'
    });
}
function create(){
    layer.open({
        type: 2,
        title: '放心，这是注册页面',
        area: ['450px', '470px'],
        skin: 'layui-layer-rim',
        content: '/create.jsp'
    });
}