<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="wb:webmaster" content="7383e34a05d5ab94" />
<title>登陆</title>
<%
String root = request.getContextPath();
%>
<link rel="icon" type="image/x-icon"
	href="<%=root%>/static/images/favicon.ico">
<link href="<%=root%>/static/login/login.css"
	rel="stylesheet">
<script
	src="<%=root%>/static/js/modernizr.custom.63321.js"></script>
	<script src="<%=root%>/static/jquery/1.12.4/jquery.min.js"></script>
	<style>
	.container > header {
	margin: 10px;
	padding: 5% 10px 10px 10px;
	position: relative;
	display: block;
	text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
    text-align: center;
}

.container > header h1 {
	font-size: 30px;
	line-height: 38px;
	margin: 0;
	position: relative;
	font-weight: 300;
	color: #666;
	text-shadow: 0 1px 1px rgba(255,255,255,0.6);
}

.container > header h2 {
	font-size: 14px;
	font-weight: 300;
	margin: 0;
	padding: 15px 0 5px 0;
	color: #666;
	font-family: Cambria, Georgia, serif;
	font-style: italic;
	text-shadow: 0 1px 1px rgba(255,255,255,0.6);
}
	</style>
</head>
<body>
	<div class="container">
		<header style="">
			<!--  
			<h1> <strong>登录</strong> </h1>
			<h2>Internal testing, temporarily does not support the registration function </h2>
			-->
			<h2 id="msg" style="color: red"></h2>
		</header>
	
		<section class="main">
		<form class="form-1">
			<p class="field">
				<input type="text" name="username" placeholder="Username or email">
				<i class="icon-user icon-large"></i>
			</p>
			<p class="field">
				<input type="password" name="password" placeholder="Password">
				<i class="icon-lock icon-large"></i>
			</p>
			<p class="submit">
				<button type="submit" name="submit">
					<i class="icon-arrow-right icon-large"></i>
				</button>
			</p>
			<div class="login-footer">
				<div class="login-left">
					<a href="<%=root%>/toResetPsw">找回密码</a><a href="<%=root%>/toRegister">注册</a>
				</div>
				<div class="login-right">
					<a href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=1105267694&redirect_uri=http://www.localhost/blog/user/qqredirect&state=lrs_blog" ><img src="<%=root %>/static/images/qq.png"></a>
					<a href="javascript:void();" onclick='toWXLogin()'><img src="<%=root %>/static/images/weixin.png"></a>
					<a href="https://api.weibo.com/oauth2/authorize?client_id=884248037&response_type=code&redirect_uri=http://www.localhost/blog/user/weiboredirect" ><img src="<%=root %>/static/images/weibo.png"></a>
				</div>
			</div>
		</form>
		</section>
	</div>
	<script type="text/javascript" src="<%=root%>/static/js/common.js"></script>
	<script type="text/javascript">
	$(function(){
		$(":input[name='submit']").click(function(){
			if(checkLogin()){
				$.ajax({
					type:"POST",
			        url:"<%=request.getContextPath()%>/user/login",
			        data:{username:$("input[name='username']").val(), password:$("input[name='password']").val(),time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	 if("success" == data.status){
			       		 if(data.lastUrl == "" || data.lastUrl == "null" || data.lastUrl == null){
				       		 window.location.href="toIndex/1";
			       		 }else{
			       			 window.location.href="<%=request.getContextPath()%>"+data.lastUrl;
			       		 }
			       	 }else{
			       		 $("#msg").html(data.msg);
			       	 }
			        }
				})
			}
			return false;
		});
		
	})
	
	function toQQLogin(){
	var url="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=1105267694&redirect_uri=http://localhost/blog&state=blog";
	var response_type="code";
	var client_id="1105267694";
	var redirect_uri="http://localhost/blog";
	var state="blog";
	$.ajax({
		type:"GET",
        url:url,
        data:{response_type:response_type,client_id:client_id,redirect_uri:redirect_uri,state:state,time:new Date().getTime()},
        dataType:"json",
        cache:false,
        success: function(data){
        	console.log(data);
        }
	})
}
function toWXLogin(){
	alert("待开发");
}
function toWBLogin(){
	alert("待开发");
}
	
	</script>
</body>
</html>