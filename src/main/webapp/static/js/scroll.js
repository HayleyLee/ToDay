var eot;
var eoh;
var wh = $(window).height();
var $win = $(window);
var itemOffsetTop;
var itemOuterHeight;
var winHeight = $win.height();
$win.scroll(function () {
    $("video").each(function () {
        itemOffsetTop = $(this).offset().top;
        itemOuterHeight = $(this).outerHeight();
        var winScrollTop = $win.scrollTop();
        if(!(winScrollTop > itemOffsetTop+itemOuterHeight) && !(winScrollTop < itemOffsetTop-winHeight)) {
            this.play();
        } else {
            this.pause();
        }
    });
});
$(window).scroll(function () {
    eot = $("h3[name='last']").offset().top;
    eoh = $("h3[name='last']").outerHeight();
    var wst = $(window).scrollTop();
    if(!(wst > eot+eoh) && !(wst < eot-wh)){
        getIndex();
    }
});