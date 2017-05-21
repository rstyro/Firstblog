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
<style>
	.blog-user{
		padding-top: 1em;
	}
	.blog-user h2{
		text-align: left;
	}
	.blog-user img{
		margin-top:1em;
		border-radius: 50%;
		width: 100%;
	}
	.blog-user p{
		padding-top: 1em;
	}
	.blog-user p span{
		font-weight: bold;
		font-size: 1.1em;
	}
</style>
<body>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>

	<div class="container">
		<div class="row blog-user">
			<div class="col-sm-2 col-md-2">
				<img alt="用户头像" src="/${user.img}">
			</div>
			<div class="col-sm-7 col-md-7">
				<h2>${user.name }</h2>
				<div class="row">
					<p class="col-sm-2">
					<c:if test="${user.user_id == '1' }"><span><i class="glyphicon glyphicon-fire red"></i> 博主</span></c:if>
					<c:if test="${user.user_id != '1' }"><span><i class="glyphicon glyphicon-fire red"></i> 博员</span></c:if>
					</p>
					<p class="col-sm-2">关注数:<span>${user.concern_num }</span></p>
					<p class="col-sm-2">粉丝数:<span>${user.fans_num }</span></p>
					<p class="col-sm-2">获赞数:<span>${user.fans_num }</span></p>
					<p class="col-sm-2">位置:<span>${user.locate }</span></p>
				</div>
				<p>${user.sign }</p>
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
				<span class="btn btn-info">关注</span>
				<span class="btn btn-info">私信</span>
			</div>
		</div>
		
		<hr style="padding: 20px;">
		<div class="row">
			<div class="col-sm-10 col-md-10">
				<%@include file="../include/right.jsp" %>
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
	          location.href = "<%=right_root %>/user/"+${user.user_id}+"/" + page;
	      }
	  };
	  element.bootstrapPaginator(options);
	
});
</script>
</html>