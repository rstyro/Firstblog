<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>注册</title>
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

.form-1 .field span {
    right: 0px;
    top: 0px;
    position: absolute;
    height: 36px;
    width: 36px;
    border-right: 1px solid rgba(0, 0, 0, 0.1);
    box-shadow: 1px 0 0 rgba(255, 255, 255, 0.7);
    color: #777777;
    text-align: center;
    line-height: 42px;
    -webkit-transition: all 0.3s ease-out;
    -moz-transition: all 0.3s ease-out;
    -ms-transition: all 0.3s ease-out;
    -o-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
    pointer-events: auto;
    cursor: pointer;
}

.blog-hide{
	display: none;
}

.login-footer{
	padding-top:1em;
	font-size: 0.5em;
	height: 2em;
}
	</style>
</head>
<body>
	<div class="container">
		<header>
		<!-- 
			<h1> <strong>注册</strong> </h1>
			 -->
			<h2 id="msg" style="color: red"></h2>
		</header>
	
		<section class="main">
		<form class="form-1">
			<p class="field">
				<input type="text" name="username" placeholder="请输入您的用户名">
				<i class="icon-user icon-large"></i>
			</p>
			<p class="field blog-hide" id="p-open-input">
				<input type="text" name="openpassword" placeholder="请输入您的密码"><span class="icon-eye-close" id="blog-hide"></span>
				<i class="icon-lock icon-large"></i>
			</p>
			<p class="field" id="p-close-input">
				<input type="password" name="password" placeholder="请输入您的密码"><span class="icon-eye-open" id="blog-show"></span>
				<i class="icon-lock icon-large"></i>
			</p>
			<p class="field">
				<input type="text" name="email" placeholder="请填写您的邮箱，需要邮箱激活账号">
				<i class="icon-envelope icon-large"></i>
			</p>
			<p>
				<button type="submit" name="submit">注册</button>
			</p>
			<div class="login-footer">
				<div class="login-left">
					<a href="<%=root%>/toResetPsw">找回密码</a><a href="<%=root%>/toLogin">登录</a>
				</div>
				<div class="login-right">
					<a href="javascript:void();" onclick='toQQLogin()'><img src="<%=root %>/static/images/qq.png"></a>
					<a href="javascript:void();" onclick='toWXLogin()'><img src="<%=root %>/static/images/weixin.png"></a>
					<a href="javascript:void();" onclick='toWBLogin()'><img src="<%=root %>/static/images/weibo.png"></a>
				</div>
			</div>
		</form>
		</section>
	</div>
	<script type="text/javascript" src="<%=root%>/static/js/common.js"></script>
	<script type="text/javascript">
	$(function(){
		$(":input[name='submit']").click(function(){
			if(checkRegister()){
				$.ajax({
					type:"POST",
			        url:"<%=request.getContextPath()%>/user/register",
			        data:{username:$("input[name='username']").val(), password:$("input[name='password']").val(),email:$("input[name='email']").val(),time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	 if("success" == data.status){
				       	alert("您的注册信息已录入成功，你的邮箱会收到激活账号的邮件，请再10分钟内激活，过期无效！");
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
	</script>
</body>
</html>