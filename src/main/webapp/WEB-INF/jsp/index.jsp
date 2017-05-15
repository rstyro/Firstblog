<!-- 
		(‧_‧？),有什么能帮你的？，加我QQ:1006059906!
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>这个冬天不太冷</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
</head>
<body>
	<%@include file="./include/top.jsp"%>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>
	<div class="jumbotron">
		<div class="container">
			<h2 class="center">${jumbotron.title}</h2>
			<p>${jumbotron.content }</p>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-sm-3 col-md-4">
				<%@include file="./include/left.jsp" %>
			</div>
			<!-- left end -->

			<div class="col-sm-8 col-sm-offset-1 col-md-7 col-md-offset-1"
				id="blog-article-list">
				<%@include file="./include/right.jsp" %>
			</div>
			<!--row right -->

		</div>
	</div>
	<!-- footer -->
	<%@include file="./include/footer.jsp"%>
</body>
<script type="text/javascript">
$(function(){
	$(".navbar-nav li:eq(0)").addClass("top-active");
	
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
	          location.href = "<%=right_root %>/toIndex/" + page;
	      }
	  };
	  element.bootstrapPaginator(options);
	
});

</script>
</html>