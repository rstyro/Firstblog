<!--
                              _.._        ,--------------------------.
                           ,'      `.    ( 你是想干嘛，是在找奴家吗？ )
                          /  __) __` \    `-,------------------------'
                         (  (`-`(-')  ) _.-'
                         /)  \  = /  (
                        /'    |--' .  \
                       (  ,---|  `-.)__`
                        )(  `-.,--'   _`-.
                       '/,'          (  看这里",
                        (_       ,    `/,-' )
                        `.__,  : `-'/  /`--'
                          |     `--'  |
                          `   `-._   /
                           \        (
                           /\ .      \.  我美吗？
                          / |` \     ,-\
                         /  \| .)   /   \
                        ( ,'|\    ,'     :
                        | \,`.`--"/      }
                        `,'    \  |,'    /
                       / "-._   `-/      |
                       "-.   "-.,'|     ;
                      /        _/["---'""]
                     :        /  |"-     '
                     '           |      /
                                 `      |
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="Const.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="keywords" content="这个冬天不太冷,个人博客,个人网站,文章,帅大叔" /> 
<meta name="description" content="这个冬天不太冷的个人博客,闲时写写文章,分享技术干货,顺便做笔记,主要学JAVA" /> 
<link rel="shortcut icon" type="image/x-icon"
	href="<%=root%>/static/images/favicon.ico">
	
<title>这个冬天不太冷的个人博客</title>
<!-- 
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"这个冬天不太冷","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"5","bdPos":"right","bdTop":"100"}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
 -->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"这个冬天不太冷的博客","bdMini":"2","bdMiniList":["qzone","tsina","bdysc","weixin","tqq","tqf","tieba","douban","sqq","isohu","fbook","twi","linkedin","h163"],"bdPic":"http://www.lrshuai.top/upload/user/20170612/05976238.png","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"5","bdPos":"right","bdTop":"167.5"},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
<link href="<%=root%>/static/bootstrap-3.3.7/css/bootstrap.css"
	rel="stylesheet">
<link href="<%=root%>/static/ueditor/third-party/SyntaxHighlighter/shCoreDefault.css"
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

.jumbotron {
	background-color: #E2E2E2;
	background-image: url("<%=root%>/static/images/bg.jpg");
}

.jumbotron p,.jumbotron h2 {
	text-align: center;
}
.toTop{
		position: fixed;
		bottom: 100px;
		right: 1em;
		font-size: 2em;
		display: none;
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
					<span class="sr-only">Blog</span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="<%=root%>/"
					data-toggle="tooltip" data-placement="bottom" title="我的笔名">这个冬天不太冷</a>
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
						if (!"".equals(username)) {
					%>
					<li><a href="<%=root%>/toNotice"><span
							class="glyphicon glyphicon-bell"></span> 消息<i class="badge">${notice.totalNum }</i></a></li>
					<%
						}
					%>
					<li><a href="<%=root%>/toAboutMe"><span
							class="glyphicon glyphicon-magnet"></span> 关于</a></li>
				</ul>
			</div>
			<div class="btn-group  pull-right">
				<div class="h_search">
					<form class="bs-example bs-example-form"
						action="<%=root%>/toSearch/1" method="get" id="searchform"
						role="search">
						<div class="input-group" data-toggle="tooltip" data-placement="bottom" title="站内文章搜索">
							<span class="input-group-addon" id="blog_search"><a
								class="glyphicon glyphicon-search" href="javascript:void();"></a></span>
							<input type="text" name="keyword" id="search_key"
								class="form-control" placeholder="客官，没合适的，来这里搜搜">
						</div>
					</form>
				</div>
				<div style="float: right">
					<ul class="nav nav-tabs topul">
						<%
							if (!"".equals(username)) {
						%>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"><%=name%> <span
								class="caret"></span></a>
							<ul class="dropdown-menu">
								<% 
									if("1".equals(user_id)){
								%>
								<li><a href="<%=root%>/article/add/go">发布文章</a></li>
								<%} %>
								<li><a href="<%=root%>/user/<%=user_id%>/1">个人信息</a></li>
								<li class="divider"></li>
								<li id="logout"><a href="JavaScript:void(0);"
									onclick="logout()">退出</a></li>
							</ul></li>
						<%
							} else {
						%>
						<li><a class="login btn btn-normal btn-primary navbar-btn"
							href="<%=root%>/toLogin" 
							data-placement="bottom" 
							target="_blank">登录</a></li>
							<%-- 
						<li><a
							class="register btn btn-normal btn-success  navbar-btn"
							href="<%=root%>/toRegister" data-placement="bottom" 
							target="_blank">注册</a></li>
							 --%> 
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<div style="margin-top: 50px;"></div>

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
					<textarea rows="5" cols="50" id="letter-content"></textarea>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-info sendLetter">发送</button>
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
	<script src="<%=root%>/static/js/top.js"></script>
	<!-- ueditor编辑器  代码高亮 -->
	<script src="<%=root%>/static/ueditor/third-party/SyntaxHighlighter/shCore.js"></script>
	<script type="text/javascript">
	
	 SyntaxHighlighter.all();
	 $(function(){
		 $("[data-toggle='tooltip']").tooltip();
	 })
	 
		var uid="";
		var uname="";
		var troot = '<%=root%>';
	</script>
</body>
</html>