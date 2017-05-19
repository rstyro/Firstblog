<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
</head>
<%@include file="./include/top.jsp"%>
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
					<div class="tab-pane fade in active" id="comment">
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 在文章<a href="#">《Linux 下安装配置svn服务器》</a> 中评论了你</p>
								<p><a href="#">@这个冬天不太冷</a> <span>这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！</span></p>
								<p class="pull-right"><a href="#">回复</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
					</div>
					<div class="tab-pane fade" id="privateLetter">
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 给你写了封信</a></p>
								<p class="pull-right"><a href="#">查看详情</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 给你写了封信</a></p>
								<p class="pull-right"><a href="#">查看详情</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 给你写了封信</a></p>
								<p class="pull-right"><a href="#">查看详情</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
					</div>
					<div class="tab-pane fade" id="concern">
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 关注了你</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 关注了你</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
					</div>
					<div class="tab-pane fade" id="praise">
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 赞了您的文章<a href="#">《Linux 下安装配置svn服务器》</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 赞了您的文章<a href="#">《Linux 下安装配置svn服务器》</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 赞了您的文章<a href="#">《Linux 下安装配置svn服务器》</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div style="height: 20px;border-top: 1px solid #ccc;"></div>
					</div>
					<div class="tab-pane fade" id="reward">
						<p><h2>暂无人打赏</h2></p>
					</div>
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
	<%@include file="./include/footer.jsp"%>
</body>
</html>