<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>failed</title>
<style>
	.blog-failed{
		margin: 3em auto;
		font-size: 3em;
		text-align: center;
	}
	.blog-failed .failed-icon{
		border-radius: 50%;
		height: 2em;
		width:13%;
		margin:0 auto;
		background-color: #5CB85C;
		color: #fff;
		font-size: 2em;
		text-align: center;
	}
	.blog-failed .failed-icon span{
		padding-top: 0.3em;
	}
	.blog-failed h2 a{
		text-decoration: none;
	}
	.blog-failed p{
		padding-top: 1.5em;
	}
	.blog-failed p a{
		text-decoration: none;
		color: #000;
	}
</style>
</head>
<body>
	<%@include file="../include/top.jsp" %>
	<div class="blog-failed">
		<div class="failed-icon"><span class="glyphicon glyphicon-ok"></span></div>
		<h1 class="${msg_class }">${msg }</h1>
		<h2><a href="<%=request.getContextPath()%>/">回到首页</a></h2>
	</div>
</body>
</html>