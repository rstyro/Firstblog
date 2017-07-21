<!-- 
		(‧_‧？),有什么能帮你的？，加我QQ:1006059906!
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关于我</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
	<%@include file="./include/top.jsp"%>
	<style>
		body{
			color: #403e3e;
		}
		#aboutMe{
			padding-left: 3em;
			padding-right: 3em;
		}
		.img{
			width: 100%;
		}
		.text{
			line-height: 30px;
			font-size:1.3em;
			/*
			border-bottom: 1px dashed #fff;
			*/
			display: inline;
		}
		.blog-pull-right{
			float: right !important;
			margin-top: 100px;
			font-weight: bold;
			font-size: 1em;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-8" id="aboutMe">
				<h1>关于我</h1>
				<div class="row">
					<p class="text">${user.content1 }</p>
					<div style="height: 20px;"></div>
					<p class="text">${user.content2 }</p>
					<div style="height: 20px;"></div>
					<p class="text">${user.content3 }</p>
					<div style="height: 20px;"></div>
					<p class="text">${user.content4 }</p>
					<div style="height: 20px;"></div>
					<p class="text">${user.content5 }</p>
				</div>
				<div class="blog-pull-right">时间：${user.create_time }</div>
			</div>

			<div class="col-sm-3 col-md-4 ">
				<div style="height: 25px;"></div>
				<div class="row">
					<div class="panel panel-default wall">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="glyphicon glyphicon-bookmark"></i><strong> 基本信息</strong>
							</h3>
						</div>
						<div class="panel-body">
							<p><span><i class="glyphicon glyphicon-fire"></i> 网名</span>:${user.onlineName }</p>
							<p><span><i class="glyphicon glyphicon-home"></i> 籍贯</span>:${user.nativePlace }</p>
							<p><span><i class="glyphicon glyphicon-map-marker"></i> 现居</span>:${user.locate }</p>
							<p><span><i class="glyphicon glyphicon-pushpin"></i> 职业</span>:${user.profession }</p>
							<p><span><i class="glyphicon glyphicon-wrench"></i> 技能</span>:${user.skills }</p>
							<p><span><i class="glyphicon glyphicon-phone"></i> 手机</span>:${user.phone }</p>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div class="row">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="glyphicon glyphicon-leaf"></i><strong> 每日一乐</strong>
							</h3>
						</div>
						<div class="panel-body">
							<span>${user.joke }</span>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div class="row">
					<div class="panel panel-default wall">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="glyphicon glyphicon-camera"></i><strong> 帅照一张</strong>
							</h3>
						</div>
						<div class="panel-body">
							<div>
								<img src="static/images/me.png" class="img"/>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- footer -->
	<%@include file="./include/footer.jsp"%>
</body>
<script type="text/javascript">
$(function(){
	<%
		if(user_id.equals("0")){
	%>	
	$(".navbar-nav li:eq(3)").addClass("top-active");
	<%
		}else{
	%>
	$(".navbar-nav li:eq(4)").addClass("top-active");
		
	<%
		}
	%>
});

</script>
</html>