<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>left</title>
<link href="<%=request.getContextPath() %>/static/css/menu.css" rel="stylesheet" type="text/css" />
<style>
</style>
</head>
<body>
	<div id="admin-left">
		<ul>
			<c:choose>
				<c:when test="${not empty menulist }">
					<c:forEach items="${menulist }" var="menu" varStatus="vvs">
							<li class="block">
								<input type="checkbox" name="item" id="item${vvs.index }" />   
								<label for="item${vvs.index }"><font><i class="${menu.menu_icon }"></i>&nbsp;&nbsp;${menu.menu_name }</font></label>
								<ul class="options">
									<c:forEach items="${menu.second_menu }" var="second" >
										<li><a href="<%=request.getContextPath() %>/${second.menu_url}" target="mainFramename"><font><i class="${second.menu_icon }"></i> ${second.menu_name }</font></a></li>
									</c:forEach>
								</ul>
							</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<li><a href="javascript:void(0);">你无权查看</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</body>
</html>