<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>404</title>
<%
String root = request.getContextPath();
%>
<style>
	body{
		background-color: #fff;
	}
	.fourTofour{
		margin: 0px auto;
		font-size: 2em;
		text-align: center;
	}
	.fourTofour a{
		text-decoration: none;
	}
	.fourTofour h1{
		font-size: 4em;
		padding: 0;
		margin: 0;
	}
	.fourTofour h2{
		padding: 0;
		margin: 0;
	}
	
</style>
</head>
<body>
	<div class="fourTofour">
		<img alt="404图片" src="<%=root%>/static/images/404.jpg">
		<h1>404</h1>
		<h2>您要找的页面不存在</h2>
		<p>可能是因为您的链接地址有误,或者该页面已被作者删除或屏蔽</p>
		<h2><a href="<%=root%>/">回到首页</a></h2>
	</div>
</body>
</html>