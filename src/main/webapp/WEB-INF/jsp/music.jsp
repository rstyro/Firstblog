<!-- 
	找啥找，有问题给我留言！！！！！！！
 -->
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一个人的音乐是心灵最深处地呻吟</title>
<%@include file="include/top.jsp"%>
<link href="<%=root%>/static/css/music.css" rel="stylesheet"
	media="screen" type="text/css">
</head>
<body id="music-b">
	<div class="blog-music-main">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<span class="text-center" id="btn-local">播放本地歌曲</span> <input
						type="file" id="localmusic" style="display: none" />
				</div>
				<div class="col-md-3">
					<span id="mstop" class="music-stop btn-music">Stop</span> <span
						id="changeType" class="btn-music">切换风格</span>
				</div>
				<div class="col-md-1">
					<p style="border: 0px;">
						音量<span id="volumetext">60</span>%<input id="volume" class="volum"
							type="range" min="0" max="100" value="50">
				</div>
				<div class="col-md-4">
					<div id="info" style="color: red;"></div>
				</div>
			</div>
			<div class="row">
				<div id="myCanvas">
					<canvas id='cas' height="600"></canvas>
				</div>
			</div>
		</div>
		
		<div class="blog-wall">
			<h3>音乐列表</h3>
			<div class="musicBg">
				<ol class="musicList">
					<c:forEach items="${musicList }" var="music">
						<li title="${music.music_name }">${music.music_name }</li>
					</c:forEach>
				</ol>
			</div>
		<div class="music-icon">
			<i class="glyphicon glyphicon-chevron-right" style="position: absolute;top: 50%;"></i>
		</div>
		</div>
	</div>
	<script src="<%=root%>/static/js/music/MusicVisualizer.js"></script>
	<script src="<%=root%>/static/js/music/music.js"></script>
	<script type="text/javascript">
	var wh = $(document).height();
	$("#music-b").css("height",wh);
	</script>
</body>
</html>