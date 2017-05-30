<!-- 
		(‧_‧？),有什么能帮你的？，加我QQ:1006059906!
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${user.name }</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
</head>
<%@include file="../include/top.jsp"%>
<%
	String userId = user_id;
%>
<style>
.blog-user {
	padding-top: 1em;
}

.blog-user h2 {
	text-align: left;
}

.blog-user img {
	margin-top: 1em;
	border-radius: 50%;
	width: 100%;
}

.blog-user p {
	padding-top: 1em;
}

.blog-user p span {
	font-weight: bold;
	font-size: 1.1em;
}

#myTab>li.active>a, #myTab>li.active>a:hover, #myTab>li.active>a:focus {
	background-color: #e2e2e2;
	font-weight: bold;
	color: #111;
}
</style>
<body>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>

	<div class="container">
		<div class="row blog-user">
			<div class="col-sm-2 col-md-2">
				<img alt="用户头像" src="/${userInfo.img}">
			</div>
			<div class="col-sm-7 col-md-7">
				<h2>${userInfo.name }</h2>
				<div class="row">
					<p class="col-sm-2">
						<c:if test="${userInfo.user_id == '1' }">
							<span><i class="glyphicon glyphicon-fire red"></i> 博主</span>
						</c:if>
						<c:if test="${userInfo.user_id != '1' }">
							<span><i class="glyphicon glyphicon-fire red"></i> 博员</span>
						</c:if>
					</p>
					<p class="col-sm-2">
						关注数:<span>${userInfo.concern_num }</span>
					</p>
					<p class="col-sm-2">
						粉丝数:<span>${userInfo.fans_num }</span>
					</p>
					<p class="col-sm-2">
						获赞数:<span>${userInfo.fans_num }</span>
					</p>
					<p class="col-sm-4">
						位置:<span>${userInfo.locate }</span>
					</p>
				</div>
				<p>${userInfo.sign }</p>
				<div class="row">
					<div class="blog-labels">
						<c:choose>
							<c:when test="${not empty userLabels}">
								<c:forEach items="${userLabels}" var="label" varStatus="vs">
									<div class="${label.label_class}">
										<a title="${label.label_name } 的标签">${label.label_name }</a>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="center">没有标签</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="col-sm-3 col-md-3">
				<c:if test="${userInfo.user_id != user_id}">
					<c:if test="${concern.concern_flag == '1' }">
						<a href="javascript:void(0)" uid="${userInfo.user_id }" 
						 class="btn btn-default-concern btn-concern">
							<span>已关注</span>
						</a>
					</c:if>
					<c:if test="${concern.concern_flag == '0' }">
						<a href="javascript:void(0)" uid="${userInfo.user_id }" 
						 class="btn btn-info btn-concern">
							<span class="glyphicon glyphicon-plus"></span><span> 关注</span>
						</a>
					</c:if>
					<a href="javascript:void(0);" uid="${userInfo.user_id }" uname="${userInfo.name }"
						class="btn btn-info btn-letter"><span><i
							class="glyphicon glyphicon-envelope"></i> 私信</span></a>
				</c:if>
			</div>
		</div>

		<hr style="padding: 20px;">
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a href="#article" data-toggle="tab"><i
					class="glyphicon glyphicon-list-alt"></i> 文章</a></li>
			<li><a href="#dynamic" data-toggle="tab"><i
					class="glyphicon glyphicon-globe"></i> 动态</a></li>
			<li><a href="#comment" data-toggle="tab"><i
					class="glyphicon glyphicon-comment"></i> 最近评论</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="article">
				<div class="row">
					<div class="col-sm-10 col-md-10">
						<div class="blog-user-article">
							<%@include file="../include/right.jsp"%>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="dynamic">
				<div class="row">
					<p>
						这个冬天不太冷 发布了文章<a href="#">《linux 操作系统》</a>
					</p>
				</div>
			</div>
			<div class="tab-pane fade" id="comment">
				<div class="row">
					<p>
						最近评论了<a href="javascript:void(0);">《Linux 入门到精通》</a>
					</p>
				</div>
			</div>
		</div>

	</div>
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>
<script type="text/javascript">
$(function(){
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
	          location.href = "<%=right_root%>/user/"+${userInfo.user_id}+"/" + page;
	      }
	  };
	  element.bootstrapPaginator(options);
	  
	  var wh = $(window).height();
	  var h = $(".blog-user").height();
	  $("#myTabContent").css("height",wh-h-200);
	
});
</script>
</html>