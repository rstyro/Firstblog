<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/static/images/favicon.ico">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/checkbox.css"
	media="screen" type="text/css" />
<title>${title }</title>
<style>
	.blog-form .row{
		padding:20px 0px; 
	}
	.blog-form .row input{
		height: 4em;
		font-weight: bold;
	}
	.checkbox .label-checkbox{
		float:left;
		padding-right: 2em;
	}
	.checkbox .label-checkbox h4{
		font-size: 1.2em;
		font-weight: bold;
	}
</style>
</head>
<body>
	<%@include file="../include/top.jsp"%>
	<script type="text/javascript" src="<%=root %>/static/ueditor/ueditor.config.js"></script>  
    <script type="text/javascript" src="<%=root %>/static/ueditor/ueditor.all.js"></script> 
	<div class="container">
		<form action="<%=root%>/article/${action}" class="blog-form" method="post">
			<%
				String token = "token_"+System.currentTimeMillis();
				session.setAttribute("token", token);
			%>
			<input type="hidden" name="token" value="<%=token%>">
			<div class="row">
				<div class="col-md-11">
					<input type="text" class="form-control" name="title" id="title" value="${article.title }" placeholder="请输入标题">
				</div>
				<div class="col-md-1">
					<input type="submit" name="submit" id="submit" value="${btnValue }" class="btn btn-info pull-right" align="middle"/>
				</div>
			 </div>
			<div>
				<textarea name="text" style="display: none;"></textarea>
				<code id="text"  style="display: none;">${article.content }</code>
				
				<script id="article_content" name="content" type="text/plain"></script>
			</div>
			<h3 class="center">选择文章标签</h3>
			<div class="checkbox">
					<c:choose>
						<c:when test="${ not empty labelList}">
							<c:forEach items="${labelList }" var="label" varStatus="vs">
								<c:set var="flag" value="0"></c:set>
								<c:choose>
									<c:when test="${not empty article.labels}">
										<c:forEach items="${article.labels}" var="articlelabel"  varStatus="vvs">
											<c:if test="${articlelabel.label_id ==  label.label_id}">
												<c:set var="flag" value="1"></c:set>
											</c:if>
											
											<c:if test="${flag==1}">
												 <div class="label-checkbox">
													<h4>${label.label_name }</h4> 
													<input class='tgl tgl-flip' checked="checked" id='${label.label_id }' name="labels" value="${label.label_id }" type='checkbox'>
													<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上' for='${label.label_id }'></label>
												</div>
												<c:set var="flag" value="2"></c:set>
											</c:if>
											<c:if test="${flag == 0 }">
												<c:if test="${vvs.last }">
													<div class="label-checkbox">
													<h4>${label.label_name }</h4> 
													<input class='tgl tgl-flip' id='${label.label_id }' name="labels" value="${label.label_id }" type='checkbox'>
													<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上' for='${label.label_id }'></label>
												</div>
												</c:if>
											</c:if>
									</c:forEach>
									</c:when>
									<c:otherwise>
										<div class="label-checkbox">
												<h4>${label.label_name }</h4> 
												<input class='tgl tgl-flip' id='${label.label_id }' name="labels" value="${label.label_id }" type='checkbox'>
												<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上' for='${label.label_id }'></label>
											</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
		</form>
	</div>
	<%@include file="../include/footer.jsp" %>
	<script src="<%=root%>/static/js/article_edit.js"></script>
</body>
</html>