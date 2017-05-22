<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息列表</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
</head>
<%@include file="../include/top.jsp"%>
<style>
	.row img{
		width: 100%;
		border-radius: 50%;
	}
	.row a{
		text-decoration: none;
	}
</style>
<body>
	<div class="container">
		<div style="height: 20px;"></div>
		<div class="row">
			<div class="col-sm-3 col-md-2">
				<ul id="myTab" class="nav nav-tabs nav-pills nav-stacked">
					<li class="active"><a href="#comment" data-toggle="tab"><span class="glyphicon glyphicon-comment"></span> 评论</a></li>
					<li><a href="#privateLetter" data-toggle="tab"><span class="glyphicon glyphicon-envelope"></span> 私信</a></li>
					<li><a href="#concern" data-toggle="tab"><span class="glyphicon glyphicon-thumbs-up"></span> 关注</a></li>
					<li><a href="#praise" data-toggle="tab"><span class="glyphicon glyphicon-thumbs-up"></span> 点赞</a></li>
					<li><a href="#reward" data-toggle="tab"><span class="glyphicon glyphicon-usd"></span> 打赏</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-md-10">
				<div id="myTabContent" class="tab-content">
				</div>
			</div>
		</div>
		<script>
			$(function() {
				var wh = $(document).height();
				$("#myTabContent").css("height",wh-150);
			});
		</script>
	</div>
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>
</html>