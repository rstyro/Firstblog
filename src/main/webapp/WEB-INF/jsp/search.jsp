<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>搜一搜</title>
<%@include file="./include/top.jsp"%>
<%
	String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<style>
body {
	background-image: url("<%=root%>/static/images/bg.jpg");
}

.container>header {
	margin: 10px;
	padding: 5% 10px 10px 10px;
	position: relative;
	display: block;
	text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.2);
	text-align: left;
}

.container>header h1 {
	font-size: 30px;
	line-height: 38px;
	margin: 0;
	position: relative;
	font-weight: 300;
	color: #666;
	text-shadow: 0 1px 1px rgba(255, 255, 255, 0.6);
}
.blog-search-article {
	border: 1 solid #eee;
	background-color: #fff;
	padding: 1em;
}
.blog-search-article h3 a{
	color: #338ECF;
	text-decoration: none;
}
.blog-search-article  .article-property span{
	padding: 1em;
}
.blog-search-article  .article-property .article-content{
	padding-top: 1em;
}
.blog-search-article  .article-footer a{
	color: green;
	text-decoration: none;
}

</style>
<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>
</head>
<body>
	<div class="container">
		<header>
		<h1>
			<strong>搜一搜</strong>
		</h1>
		<h2 id="msg" style="color: red"></h2>
		</header>
		<div class="search-body">
			<form class="bs-example bs-example-form" action="<%=root%>/toSearch/1" id="formsearch" action="" role="form">
				<div class="row">
					<div class="col-lg-8 col-md-8">
						<div class="input-group">
							<input type="text" name="keyword" value="${keyword }" class="form-control"> <span
								class="input-group-btn">
								<button class="btn btn-default" id="btn-seartch" type="button">搜一搜</button>
							</span>
						</div>
					</div>
				</div>
				<!-- /.row -->
			</form>
			<div style="height: 50px;"></div>
			<div class="row">
				<div class="col-md-8">
					<div style="padding-bottom: 50px;">
					<c:choose>
						<c:when test="${not empty keyword }">
							<c:choose>
						<c:when test="${not empty article_search }">
							<c:forEach items="${article_search }" var="article" varStatus="vs">
								<div class="blog-search-article">
									<h3><a href="<%=root%>/article/${article.article_id}">${article.title }</a></h3>
									<div class="article-property">
										<div class="row">
											<span><i class="glyphicon glyphicon-edit blog-primary"></i><a href="#"> ${article.name }</a></span>
											<span><i class="glyphicon glyphicon-time blog-primary"></i> ${article.create_time }</span>
											<span><i class="glyphicon glyphicon-eye-open blog-primary"></i> ${article.browse_num }</span>
										</div>
										<p class="article-content">
												<c:choose>
													<c:when test="${fn:length(article.text) > 100}">
														<c:out value="${fn:substring(article.text, 0, 100)}..." />
													</c:when>
													<c:otherwise>
														<c:out value="${article.text}" />
													</c:otherwise>
												</c:choose>
										</p>
										<footer class="article-footer"><a href="#"><%=path %>/article/${article.article_id }</a></footer>
									</div>
								</div>
							</c:forEach>
							<c:if test="${page.totalPage > 1}">
								<div class="pull-right">
									<ul id='mypage' class="pagination"></ul>
								</div>
							</c:if>
						</c:when>
						<c:otherwise>
							<p>哎呦，这里没有您要点的菜呢，我会跟老板反馈的！</p>
						</c:otherwise>
					</c:choose>
						</c:when>
						<c:otherwise>
							<p>哎呦，客官请输入你的菜名</p>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
				<div class="col-md-3 col-md-offset-1">
				
					<div class="panel panel-default">
						<div class="panel-heading">
							<h2 class="panel-title"><strong>热门搜索</strong></h2>
						</div>
						<div class="panel-body">
							<c:choose>
								<c:when test="${not empty article_hot }">
									<c:forEach items="${article_hot }" var="hot"
										varStatus="vs">
										<p title="${hot.title }">
											<a
												href="<%=request.getContextPath()%>/article/${hot.article_id }">
												<c:choose>
													<c:when test="${fn:length(hot.title) > 15}">
														<c:out value="${fn:substring(hot.title, 0, 15)}..." />
													</c:when>
													<c:otherwise>
														<c:out value="${hot.title}" />
													</c:otherwise>
												</c:choose>
											</a>
										</p>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<p>暂无搜索内容</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					
					
					<div class="panel panel-default">
						<div class="panel-heading">
							<h2 class="panel-title"><strong>站长推荐</strong></h2>
						</div>
						<div class="panel-body">
							<c:choose>
								<c:when test="${not empty article_recommend }">
									<c:forEach items="${article_recommend }" var="recommend"
										varStatus="vs">
										<p title="${recommend.title }">
											<a
												href="<%=request.getContextPath()%>/article/${recommend.article_id }">
												<c:choose>
													<c:when test="${fn:length(recommend.title) > 15}">
														<c:out value="${fn:substring(recommend.title, 0, 15)}..." />
													</c:when>
													<c:otherwise>
														<c:out value="${recommend.title}" />
													</c:otherwise>
												</c:choose>
											</a>
										</p>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<p>暂无推荐</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>

	<!-- footer -->
	<%@include file="./include/footer.jsp"%>

	<script type="text/javascript">
		$(function() {
			var wh = $(document).height();
			$(".search-body").css("height", wh-70);
			$("#btn-seartch").click(function(){
				$("#formsearch").submit();
			});
			var element = $('#mypage');
			  options = {
			      bootstrapMajorVersion:3, //对应的bootstrap版本
			      currentPage: ${page.currentPage }, //当前页数，这里是用的EL表达式，获取从后台传过来的值
			      numberOfPages:${page.showCount }, //每页页数
			      totalPages:${page.totalPage }, //总页数，这里是用的EL表达式，获取从后台传过来的值
			      itemTexts: function (type, page, current) {//设置显示的样式，默认是箭头
			          switch (type) {
			              case "first":
			                  return "首页";
			              case "prev":
			                  return "上一页";
			              case "next":
			                  return "下一页";
			              case "last":
			                  return "末页";
			              case "page":
			                  return page;
			          }
			      },
			    //点击事件
			      onPageClicked: function (event, originalEvent, type, page) {
			          location.href = "<%=root %>/toSearch/" + page;
			      }
			  };
			  element.bootstrapPaginator(options);
			
		})
	</script>
</body>
</html>