<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String right_root = request.getContextPath();
%>
<c:choose>
	<c:when test="${not empty articles }">
		<c:forEach items="${articles }" var="article" varStatus="vs">
			<c:if test="${vs.index == 0 }">
				<div class="blog-article">
					<div class="author">
						<a href="<%=right_root%>/user/${article.user_id}/1" target="_blank"><img
							src="${article.img}"> <span
							style="font-size: 1.3em; padding-top: 10px;">${article.name}</span></a>
					</div>
					<div class="title">
						<a target="_blank"  title="${article.title}"  data-toggle="tooltip" data-placement="bottom"
							href="<%=right_root%>/article/${article.article_id}">
							<c:choose>
								<c:when test="${fn:length(article.title) > 20}">
									<c:out value="${fn:substring(article.title, 0, 20)}..." />
								</c:when>
								<c:otherwise>
									<c:out value="${article.title}" />
								</c:otherwise>
							</c:choose>
						</a>
					</div>
					<div class="content">
						<p>
							<c:choose>
								<c:when test="${fn:length(article.text) > 90}">
									<c:out value="${fn:substring(article.text, 0, 90)}..." />
								</c:when>
								<c:otherwise>
									<c:out value="${article.text}" />
								</c:otherwise>
							</c:choose>
						</p>
					</div>
					<div class="footer">
						<div class="footer-left">
							<span><i class="glyphicon glyphicon-eye-open blog-info"></i>
								${article.browse_num }</span> <span><i
								class="glyphicon glyphicon-comment blog-success"></i>
								${article.comment_num }</span> <span><i
								class="glyphicon glyphicon glyphicon-thumbs-up red"></i>
								${article.praise_num }</span>
						</div>
						<div class="footer-right">
							<c:forEach items="${article.labels }" var="label" varStatus="vs2">
								<span> <label class="label label-${label.label_class }">${label.label_name }</label>
								</span>
							</c:forEach>

							<span><i class="glyphicon glyphicon-time blog-primary"></i>
								${article.create_time }</span>
						</div>
					</div>
				</div>
			</c:if>

			<c:if test="${vs.index != 0 }">
				<div class="blog-article blog-article-top">
					<div class="author">
						<a href="<%=right_root%>/user/${article.user_id}/1"><img
							src="${article.img}"> <span
							style="font-size: 1.3em; padding-top: 10px;">${article.name}</span></a>
					</div>
					<div class="title">
						<a  title="${article.title}"  data-toggle="tooltip" data-placement="bottom" href="<%=right_root%>/article/${article.article_id}"> <c:choose>
								<c:when test="${fn:length(article.title) > 20}">
									<c:out value="${fn:substring(article.title, 0, 20)}..." />
								</c:when>
								<c:otherwise>
									<c:out value="${article.title}" />
								</c:otherwise>
							</c:choose>
						</a>
					</div>
					<div class="content">
						<p>
							<c:choose>
								<c:when test="${fn:length(article.text) > 90}">
									<c:out value="${fn:substring(article.text, 0, 90)}..." />
								</c:when>
								<c:otherwise>
									<c:out value="${article.text}" />
								</c:otherwise>
							</c:choose>
						</p>
					</div>
					<div class="footer">
						<div class="footer-left">
							<span><i class="glyphicon glyphicon-eye-open blog-info"></i>
								${article.browse_num }</span> <span><i
								class="glyphicon glyphicon-comment blog-success"></i>
								${article.comment_num }</span> <span><i
								class="glyphicon glyphicon glyphicon-thumbs-up red"></i>
								${article.praise_num }</span>
						</div>
						<div class="footer-right">
							<c:forEach items="${article.labels }" var="label" varStatus="vs2">
								<span> <label class="label label-${label.label_class }">${label.label_name }</label>
								</span>
							</c:forEach>
							<span><i class="glyphicon glyphicon-time blog-primary"></i>
								${article.create_time }</span>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
		<c:if test="${page.totalPage > 1}">
			<div class="pull-right">
				<ul id='mypage' class="pagination"></ul>
			</div>
		</c:if>
	</c:when>
	<c:otherwise>
		<h1>暂无此系列的文章发表</h1>
	</c:otherwise>
</c:choose>
