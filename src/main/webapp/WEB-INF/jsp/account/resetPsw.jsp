<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>找回密码</title>
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
    /* Size and position */
    right: 0px;
    top: 0px;
    position: absolute;
    height: 36px;
    width: 36px;
    index:999;

    /* Line */
    border-right: 1px solid rgba(0, 0, 0, 0.1);
    box-shadow: 1px 0 0 rgba(255, 255, 255, 0.7);

    /* Styles */
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

.form-1 input[name=code] {
    font-family: 'Lato', Calibri, Arial, sans-serif;
    font-size: 13px;
    font-weight: 400;
    text-shadow: 0 1px 0 rgba(255,255,255,0.8);
    /* Size and position */
    width: 50%;
    padding: 10px 18px 10px 45px;

    /* Styles */
    border: none; /* Remove the default border */
    box-shadow: 
        inset 0 0 5px rgba(0,0,0,0.1),
        inset 0 3px 2px rgba(0,0,0,0.1);
    border-radius: 3px;
    background: #f9f9f9;
    color: #777;
    -webkit-transition: color 0.3s ease-out;
    -moz-transition: color 0.3s ease-out;
    -ms-transition: color 0.3s ease-out;
    -o-transition: color 0.3s ease-out;
    transition: color 0.3s ease-out;
}
.form-1 button[name=sendcode] {
    /* Size and position */
    width: 40%;
    height: 100%;
    margin-left:10%;
    font-size: 0.5em;
    line-height: 3;
    color: white;
	background: #52cfeb;
    cursor: pointer;
}

	</style>
</head>
<body>
	<div class="container">
		<header style="">
			<h1> <strong>找回密码</strong> </h1>
			<h2 id="msg" style="color: red"></h2>
		</header>
	
		<section class="main">
		<form class="form-1">
			<p class="field">
				<input type="text" name="email" placeholder="请输入您绑定的邮箱">
				<i class="icon-envelope icon-large"></i>
			</p>
			<p class="field blog-hide" id="p-open-input">
				<input type="text" name="openpassword" placeholder="请输入您的新密码"><span class="icon-eye-close" id="blog-hide"></span>
				<i class="icon-lock icon-large"></i>
			</p>
			<p class="field" id="p-close-input">
				<input type="password" name="password" placeholder="请输入您的新密码"><span class="icon-eye-open" id="blog-show"></span>
				<i class="icon-lock icon-large"></i>
			</p>
			<p class="field">
				<input type="text" name="code" placeholder="请填写您邮箱收到的验证码"/><button type="button" id="sendcode" name="sendcode" >发送验证码</button>
				<i class="icon-qrcode icon-large"></i>
			</p>
			<p>
				<button type="submit" name="submit">重置密码</button>
			</p>
			<div class="login-footer">
				<div class="login-left">
					<a href="<%=root%>/toRegister">注册</a><a href="<%=root%>/toLogin">登录</a>
				</div>
				<div class="login-right">
					<a href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101401237&redirect_uri=http://www.lrshuai.top/user/qqredirect&state=lrs_blog" ><img src="<%=root %>/static/images/qq.png"></a>
					<a href="https://api.weibo.com/oauth2/authorize?client_id=884248037&response_type=code&redirect_uri=http://www.lrshuai.top/user/weiboredirect" ><img src="<%=root %>/static/images/weibo.png"></a>
				</div>
			</div>
		</form>
		</section>
	</div>
	<script type="text/javascript" src="<%=root%>/static/js/common.js"></script>
	<script type="text/javascript">
	$(function(){
		$(":input[name='submit']").click(function(){
			if(checkReset()){
				$.ajax({
					type:"POST",
			        url:"<%=request.getContextPath()%>/user/resetPsw",
			        data:{password:$("input[name='password']").val(),email:$("input[name='email']").val(),code:$("input[name='code']").val(),time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	 if("success" == data.status){
			       		var islogin= confirm("您的密码重置成功是否跳转登录页面?");
			       		if(islogin){
			       			 window.location.href="<%=request.getContextPath()%>"+"/toLogin";
			       		}else{
			       			 window.location.href="toIndex/1";
			       		}
			       	 }else{
			       		 $("#msg").html(data.msg);
			       	 }
			        }
				})
			}
			return false;
		});
		
		$("#sendcode").click(function(){
			var email= $("input[name='email']").val();
			if(email == ""){
				$("#msg").html("邮箱不能为空");
				$("input[name='email']").focus();
				return false;
			}
			if(!checkEmail(email)){
				$("#msg").html("邮箱不合法");
				$("input[name='email']").focus();
				return false;
			}
			$("#sendcode").css("background","#ccc");
			code_index++;
			if(code_index < 2){
				code_task = setInterval("changeText()",1000);
				sendCode();
			}else{
				return false;
			}
		});
		
	})
	var code_index = 0;
	var code_time = 60;
	var code_task;
	
	function changeText(){
		code_time--;
		var el = $("#sendcode");
		var content = " s 后重试";
		var text = code_time + content;
		el.text(text);
		if(code_time <= 0){
			clearInterval(code_task);
			el.css("background","#52cfeb");
			el.text("发送验证码");
			code_time=60;
			code_index=0;
		}
	}
	
	function sendCode(){
		$.ajax({
			type:"POST",
	        url:"<%=request.getContextPath()%>/user/sendCode",
	        data:{email:$("input[name='email']").val(),time:new Date().getTime()},
	        dataType:"json",
	        cache:false,
	        success: function(data){
	       	 if("success" == data.status){
	       		alert("验证码已发到您的邮箱，请尽快查收。");
	       	 }else{
	       		 $("#msg").html(data.msg);
	       		clearInterval(code_task);
	       		$("#sendcode").css("background","#52cfeb");
	       		$("#sendcode").text("发送验证码");
				code_time=60;
				code_index=0;
	       	 }
	        }
		})
	}
	</script>
</body>
</html>