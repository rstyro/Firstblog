<%@page import="com.lrs.blog.entity.User"%>
<%@page import="com.lrs.util.Const"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String root = request.getContextPath();
	String username = "";
	String name = "";
	String user_id = "0";
	String userImg = "";
	try{
		User user = (User)session.getAttribute(Const.BLOG_USER_SESSION);
		user_id = user.getUser_id();
		username = user.getUsername();
		name = user.getName();
		userImg = user.getImg();
	}catch(Exception e){
		
	}
%>