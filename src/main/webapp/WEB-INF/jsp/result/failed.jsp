<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>failed</title>
<%@include file="../include/top.jsp" %>
<link href="<%=root%>/static/css/result.css" rel="stylesheet">
</head>
<body>
	<div class="blog-failed">
		<div class="failed-icon"><span class="glyphicon glyphicon-ok"></span></div>
		<h1 class="${msg_class }">${msg }</h1>
		<h2><a href="<%=request.getContextPath()%>/">回到首页</a></h2>
	</div>
</body>
</html>