<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="${article.title }" /> 
<c:choose>
	<c:when test="${fn:length(article.text) > 105}">
		<meta name="description" content="${fn:substring(article.text, 0, 105)}..."/> 
	</c:when>
	<c:otherwise>
		<meta name="description" content="${article.text}"/> 
	</c:otherwise>
</c:choose> 
<title>${article.title }</title>
<%@include file="../include/top.jsp"%>
<!-- editormd start -->
    <script type="text/javascript" src="<%=root%>/static/editormd/editormd.min.js"></script>
    <script src="<%=root%>/static/editormd/lib/marked.min.js"></script>
	<script src="<%=root%>/static/editormd/lib/prettify.min.js"></script>
	<script src="<%=root%>/static/editormd/lib/raphael.min.js"></script>
	<script src="<%=root%>/static/editormd/lib/underscore.min.js"></script>
	<script src="<%=root%>/static/editormd/lib/sequence-diagram.min.js"></script>
	<script src="<%=root%>/static/editormd/lib/flowchart.min.js"></script>
	<script src="<%=root%>/static/editormd/lib/jquery.flowchart.min.js"></script>
	<!-- end -->
	
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>
	<script src="<%=root%>/static/js/jquery.qqFace.js"></script>
	<script src="<%=root%>/static/js/detail.js"></script>
	<script src="<%=root%>/static/js/comment.js"></script>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
<link href="<%=request.getContextPath()%>/static/css/article_detail.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/static/editormd/css/editormd.css" rel="stylesheet" type="text/css" />
<style>
	.bottom-tip{
		width: 720px;
		height: 50px;
	}
	.emoji{
		margin-top: 10px;
	}
</style>
</head>
<body>
	<div class="container">
		<div style="min-height: 900px;">
			<div class="row">
				<input type="hidden" name="authorUserId" value="${article.user_id}">
				<input type="hidden" name="articleId" value="${article.article_id}">
				<div
					class="col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1 col-lg-10 col-lg-offset-1 article-detail">
					<p class="article-detail-title">${article.title }</>
					<div class="row">
						<div class="col-sm-1 col-md-1">
							<a href="<%=root%>/user/${article.user_id}/1" target="_blank"><img
								src="${article.img}" /></a>
						</div>
						<div class="col-sm-9 col-md-9">
							<div>
								<i class="glyphicon glyphicon-edit red"></i>
								<p class="article-author">${article.name}</p>
							</div>
							<div class="article-property">
								<span><i class="glyphicon glyphicon-time blog-primary"></i>
									${article.create_time }</span> <span><i
									class="glyphicon glyphicon-eye-open blog-info"></i>
									${article.browse_num }</span> <span><i
									class="glyphicon glyphicon-comment blog-success"></i>
									${article.comment_num }</span> <span><i
									class="glyphicon glyphicon-thumbs-up red"></i>
									${article.praise_num }</span>
							</div>
						</div>
						<div class="col-sm-2 col-md-2">
							<c:if test="${article.user_id eq user_id}">
								<a class="btn btn-default pull-right"
									href="<%=root%>/article/edit/${article.article_id}">编辑文章</a>
								<a class="btn btn-default pull-right"
									href="<%=root%>/article/del/${article.article_id}">删除文章</a>
							</c:if>
						</div>
					</div>
					<div id="codeView" >
					     <textarea style="display:none;" name="content">${article.content }</textarea>
					</div>
					<div>
						<div class="row">
							<div class="col-md-3">
								<c:forEach items="${article.labels }" var="label"
									varStatus="vs2">
									<span> <label class="label label-${label.label_class }">${label.label_name }</label>
									</span>
								</c:forEach>
							</div>
							<div class="col-md-9">
								<p class="pull-right">© 著作权归作者所有</p>
							</div>
						</div>
						<div class="row">
							<div class="col-md-3">
								<div
									class="btn btn-lg btn-praise 
								<c:if test="${article.praise_flag == '0' }">red</c:if>
								<c:if test="${article.praise_flag == '1' }">blog-btn-active</c:if>
								">
									<span><i class="glyphicon glyphicon-thumbs-up"></i> 赞 </span>
									<div id="praiseNum">${article.praise_num }</div>
								</div>
							</div>
							<div class="col-md-9">
								<h4 style="text-align: right;">如果觉得文章对你有帮助，也可以分享到朋友圈哦！</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- row end -->

			<div>
				<h3><span class="glyphicon glyphicon-edit"></span> 发表评论</h3>
				<hr>
				<textarea id="article_comment" name="content" cols="100" style="resize:none;" rows="5" placeholder="想说点什么就说吧，别墨迹了.........."></textarea>
				<div class="bottom-tip">
					<img class="emoji" src="<%=root%>/static/images/emoji.png">
					<a href="javascript:void(0);" id="blog_comment" class="btn btn-info pull-right"
						style="margin-top: 1em;">吐槽一下</a>
				</div>
			</div>
			<!-- 评论列表 -->
			<div class="row">
				<div class="col-sm-10  col-md-10 ">
					<h5>
						总共 ${article.comment_num }条评论  	<span class="glyphicon glyphicon-comment"></span>
					</h5>
					<hr>
					<ul class="media-list" id="comment-body">
					</ul>
					
					<div class="pull-right">
						<ul id='mypage' class="pagination"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../include/footer.jsp"%>
	<script>
		var floorNum=1;
		var index=0;
		var task=0;
		var task_count=2;
		
		var root = '<%=root%>';
		var userId = '<%=user_id%>';
		
		var authorUserId = $("input[name='authorUserId']").val();
		var articleId = $("input[name='articleId']").val();
		
		/*$(function(){
			$(".bottom-tip").hide();
			$("#article_comment").focus(function(){
				if($(".bottom-tip").hide()){
					$(".bottom-tip").show()
				}
			}).blur(function(){
				if($(".bottom-tip").show()){
					$(".bottom-tip").hide()
				}
			});
			
			
		})*/
		
	</script>
</body>
</html>