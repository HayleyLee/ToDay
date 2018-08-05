layui.use('util', function(){
    var util = layui.util;
    //执行
    util.fixbar({
        bar1: true
        ,click: function(type){
            if(type === 'bar1'){
                layer.msg('功能正在实现...敬请期待');
            }
        }
    });
});