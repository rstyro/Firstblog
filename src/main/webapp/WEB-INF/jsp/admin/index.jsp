<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String root = request.getContextPath();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Blog后台管理</title>
<link rel="shortcut icon" type="image/x-icon" href="<%=root%>/static/images/favicon.ico">
<link href="<%=root%>/static/bootstrap-3.3.7/css/bootstrap.css"
	rel="stylesheet">
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style>
    	.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
  padding-left: 0px;
  padding-right: 0px;
}
    </style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@include file="top.jsp" %>
		</div>
		<div class="row">
			<div class="col-sm-3 col-md-2">
				<%@include file="left.jsp" %>
			</div>
			<div class="col-sm-9 col-md-10">
				<div>
					<iframe name="mainFramename" id="mainFramename" frameborder="0" src="<%=request.getContextPath() %>/admin/main" style="margin:0 auto;width:100%;"></iframe>
				</div>
			</div>
		</div>
	</div>
	
	<script src="<%=root%>/static/jquery/1.12.4/jquery.min.js"></script>
	<script src="<%=root%>/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script>
		$(function(){
			var wh = $(document).height();
			var topH = $(".admin-top").height();
			$("#mainFramename").css("height",wh-topH);
		})
	</script>
</body>
</html>