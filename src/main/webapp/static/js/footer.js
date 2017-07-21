var d1 = '2017-04-30';
var lastTime = "2017-07-21";
d1 = new Date(d1.replace(/-/g, "/"));
d2 = new Date();
var days = d2.getTime() - d1.getTime();
var time = parseInt(days / (1000 * 60 * 60 * 24));
$(function(){
	$(".run_date").html("博客已运行: "+time+" 天 &nbsp;&nbsp;|&nbsp;&nbsp; 最后更改时间 : "+lastTime);
});