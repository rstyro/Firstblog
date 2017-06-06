<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="Const.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="renderer" content="webkit"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta property="wb:webmaster" content="7383e34a05d5ab94" />
<link rel="shortcut icon" type="image/x-icon"
	href="<%=root%>/static/images/favicon.ico">
<title>Blog</title>

<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"这个夏天好冷","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"5","bdPos":"right","bdTop":"100"}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
<link href="<%=root%>/static/bootstrap-3.3.7/css/bootstrap.css"
	rel="stylesheet">
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
body {
	margin: 0px;
	padding: 0px;
	width: 100%;
	height: 100%;
	background-image: url("<%=root%>/static/images/bg.jpg");
}

.jumbotron{
	background-color: #E2E2E2;
	background-image:url("<%=root%>/static/images/bg.jpg");
}
.jumbotron p, h2 {
	text-align: center;
}
.navbar-toggle{
	background-color: #403c3c;
}
.navbar-toggle .icon-bar{
	background-color: #fff;
}
</style>
<link href="<%=root%>/static/css/top.css" rel="stylesheet"
	media="screen" type="text/css">
</head>
<body>
	<nav class="navbar navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-left navbar-toggle collapsed "
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Blog</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="这是logo">Blog</a>
			</div>

			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav" id="myTab">
					<li><a href="<%=root%>/"><span
							class="glyphicon glyphicon-home"></span> 首页</a></li>
					<li><a href="<%=root%>/toMusic"><span
							class="glyphicon glyphicon-headphones"></span> 音乐</a></li>
					<li><a href="<%=root%>/toLeaveWord"><span
							class="glyphicon glyphicon-comment"></span> 留言</a></li>
					<% 
					if(!"".equals(username)){
					%>
					<li><a href="<%=root%>/toNotice"><span
							class="glyphicon glyphicon-bell"></span> 消息<i class="badge">${notice.totalNum }</i></a></li>
					<%
						}
					%>
					<li data-toggle="modal" data-target="#myModal"><a href="#"><span
							class="glyphicon glyphicon-magnet"></span> 关于</a></li>
				</ul>
			</div>
			<div class="btn-group  pull-right">
				<div class="h_search">
					<form class="bs-example bs-example-form" action="<%=root%>/toSearch/1" method="get" id="searchform" role="search">
						<div class="input-group">
							<span class="input-group-addon" id="blog_search"><a
								class="glyphicon glyphicon-search"  href="javascript:void();"></a></span> <input
								type="text" name="keyword" id="search_key" class="form-control" placeholder="客官，没合适的，来这里搜搜">
						</div>
					</form>
				</div>
				<div style="float: right">
					<ul class="nav nav-tabs topul">
						<%
							if(!"".equals(username)){
						%>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"><%=name %> <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="<%=root%>/article/add/go">发布文章</a></li>
								<li><a href="<%=root%>/user/<%=user_id %>/1">个人信息</a></li>
								<li class="divider"></li>
								<li id="logout"><a href="JavaScript:void(0);" onclick="logout()">退出</a></li>
							</ul>
						</li>
						<%}else{ %>
						<li><a class="login btn btn-normal btn-primary navbar-btn"
							href="<%=root%>/toLogin" data-toggle="tooltip"
							data-placement="bottom" title="目前只提供登录功能，暂未开放注册功能" target="_blank">登录</a></li>
						<li><a
							class="register btn btn-normal btn-success  navbar-btn"
							href="<%=root%>/toRegister" data-toggle="tooltip"
							data-placement="bottom" title="目前只提供登录功能，暂未开放注册功能" target="_blank">注册</a></li>
						<%} %>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<div style="margin-top: 50px;"></div>

	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">个人博客</h4>
				</div>
				<div class="modal-body">
					<p>记录我迈过的坑坑坎坎。。。。</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="letterModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="modelHead"></h4>
				</div>
				<div class="modal-body">
					<textarea rows="5" cols="50" id="letter-content"></textarea><br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-info sendLetter" >发送</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="commentModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<p>评论成功</p>
				</div>
			</div>
		</div>
	</div>

	<script src="<%=root%>/static/jquery/1.12.4/jquery.min.js"></script>
	<script src="<%=root%>/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		var uid="";
		var uname="";
		$(function(){
			$("[data-toggle='tooltip']").tooltip();
			
			 $('.list-group li').each(function() {
	                $(this).click(function() {
	                    location.href = "<%=root%>/article/month/"+ $(this).attr('id') + "/1";
								})
			})
			$("#blog_search").click(function(){
				$("#searchform").submit();
			});
			 
			$(".btn-concern").click(function(){
				var uid = $(this).attr("uid");
				var El = $(this);
				concern(uid,El);
			});
			$(".btn-letter").click(function(){
				uid = $(this).attr("uid");
				uname = $(this).attr("uname");
				$("#modelHead").html("给用户 <strong>"+uname+"</strong> 写信");
				$("#letterModal").modal('show');
			});
			$(".sendLetter").click(function(){
				var content = $("#letter-content").val();
				sendLetter(uid,uname,content);
				$("#letterModal").modal('hide');
			});
		})
		
		function sendLetter(uid,uname,content){
			alert("uid="+uid+",uname="+uname+",content="+content);
		}
		
		function logout(){
			$.ajax({
				type:"GET",
		        url:"<%=root%>/user/logout",
		        data:{time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		       	 if("success" == data.status){
		       		location.reload();
		       	 }else{
		       		 $("#msg").html(data.msg);
		       	 }
		        }
			})
		}
		function concern(userId,El){
			$.ajax({
				type:"POST",
		        url:"<%=root%>/public/concern",
		        data:{beconcern_user_id:userId,time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		        	console.log(data);
		       	 if("success" == data.status){
		       		if(El.hasClass("btn-default-concern")){
		       			El.html("<span class='glyphicon glyphicon-plus'></span><span> 关注</span>");
		       			El.removeClass("btn-default-concern");
		       			El.addClass("btn-info");
					}else{
						El.html("<span>已关注</span>");
						El.addClass("btn-default-concern");
						El.removeClass("btn-info");
					}
		       	 }else if("auth" == data.status){
		       		window.location.href="<%=root%>/toLogin";
		       	 }else{
		       		 $("#msg").html(data.msg);
		       	 }
		        }
			})
		}
	</script>
	<script src="<%=root%>/static/js/skill.js"></script>
</body>
</html>