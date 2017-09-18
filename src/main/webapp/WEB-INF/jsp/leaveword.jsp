<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="留言" /> 
<meta name="description" content="留言" /> 
<title>写下你想写的，想说...</title>
<%@include file="./include/top.jsp" %>
<style>
	body{
			/*
				background-image: url("static/images/bg.jpg");
			*/
			background-image: url("");
			background-color: #000;
			color: #fff;
		}
		.blog-leaveword textarea{
			resize:none;
			box-shadow:5px 5px 50px #fee;
			background-color: #000;
		}
		.blog-leaveword h2{
			text-align: left;
		}
		/*加载*/
		.loader--glisteningWindow {
		  width: 0.25em;
		  height: 0.25em;
		  box-shadow: 0.70711em 0.70711em 0 0em #2ecc71, -0.70711em 0.70711em 0 0.17678em #9b59b6, -0.70711em -0.70711em 0 0.25em #3498db, 0.70711em -0.70711em 0 0.17678em #f1c40f;
		  animation: gw 1s ease-in-out infinite, rot 2.8s linear infinite;
		}
		@keyframes rot {
		  to {
		    transform: rotate(360deg);
		  }
		}
		@keyframes gw {
		  0% {
		    box-shadow: 0.70711em 0.70711em 0 0.125em #2ecc71, -0.70711em 0.70711em 0 0.39017em #9b59b6, -0.70711em -0.70711em 0 0.5em #3498db, 0.70711em -0.70711em 0 0.39017em #f1c40f;
		  }
		  25% {
		    box-shadow: 0.70711em 0.70711em 0 0.39017em #2ecc71, -0.70711em 0.70711em 0 0.5em #9b59b6, -0.70711em -0.70711em 0 0.39017em #3498db, 0.70711em -0.70711em 0 0.125em #f1c40f;
		  }
		  50% {
		    box-shadow: 0.70711em 0.70711em 0 0.5em #2ecc71, -0.70711em 0.70711em 0 0.39017em #9b59b6, -0.70711em -0.70711em 0 0.125em #3498db, 0.70711em -0.70711em 0 0.39017em #f1c40f;
		  }
		  75% {
		    box-shadow: 0.70711em 0.70711em 0 0.39017em #2ecc71, -0.70711em 0.70711em 0 0.125em #9b59b6, -0.70711em -0.70711em 0 0.39017em #3498db, 0.70711em -0.70711em 0 0.5em #f1c40f;
		  }
		  100% {
		    box-shadow: 0.70711em 0.70711em 0 0.125em #2ecc71, -0.70711em 0.70711em 0 0.39017em #9b59b6, -0.70711em -0.70711em 0 0.5em #3498db, 0.70711em -0.70711em 0 0.39017em #f1c40f;
		  }
		}
		#blog-mask{
			width: 100%;
			height: 100%;
			position: absolute;
			background-color: #ccc;
			position: 0.1;
			top: 0;
			left: 0;
			display: none;
		}
		#blog-mask .loader{
			position: absolute;
			top: 50%;
			left:50%;
		}
		.panel-body p{
			color: #000;
		}
		.modal{
			color: #000;
		}
</style>
</head>
<body>
	<div id="blog-mask">
		<div class='loader loader--glisteningWindow'></div>
	</div>
	<div class="jumbotron" style="background-color: #000;background-image: url('');color: #fff;">
		<div class="container">
			<h2 class="center">${jumbotron.title}</h2>
			<p>${jumbotron.content }</p>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<div style="height: 10px;"></div>
				<div class="row">
					<div class="panel panel-default wall">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="glyphicon glyphicon-leaf"></i><strong> 个人资料</strong>
							</h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-4 blog-info-head">
									<a
										href="<%=request.getContextPath()%>/user/${userInfo.user_id }/1"><img
										src="${userInfo.img }"></a>
									<c:if test="${concern.concern_flag == '1' }">
										<a href="javascript:void(0)" uid="${userInfo.user_id }"
											class="btn btn-default-concern btn-concern"> <span>已关注</span>
										</a>
									</c:if>
									<c:if test="${concern.concern_flag == '0' }">
										<a href="javascript:void(0)" uid="${userInfo.user_id }"
											class="btn btn-info btn-concern"> <span
											class="glyphicon glyphicon-plus"></span><span> 关注</span>
										</a>
									</c:if>
									<a href="javascript:void(0)" uid="${userInfo.user_id }"
										uname="${userInfo.name }" class="btn btn-success btn-letter">
										<span class="glyphicon glyphicon-envelope"></span><span>
											私信</span>
									</a>
								</div>
								<div class="col-md-8">
									<a
										href="<%=request.getContextPath()%>/user/${userInfo.user_id }/1"
										class="index-user"><h4>
											<i class="glyphicon glyphicon-fire red"></i> <font
												style="font-weight: bold;">${userInfo.name }</font>
										</h4></a>
									<p>
										<i class="glyphicon glyphicon-info-sign green"></i>
										${userInfo.sign }
									</p>
									<p>
										<i class="glyphicon glyphicon-map-marker green"></i>
										${userInfo.locate }
									</p>
									<div class="row">
										<div class="col-sm-1 col-md-2">
											<i class="glyphicon glyphicon glyphicon-tags green"></i>
										</div>
										<div class="col-sm-11 col-md-10">
											<div class="blog-labels">
												<c:choose>
													<c:when test="${not empty userLabels}">
														<c:forEach items="${userLabels}" var="label"
															varStatus="vs">
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
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div class="row">
					<div class="panel panel-default wall">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="glyphicon glyphicon-bookmark"></i><strong> 联系方式</strong>
							</h3>
						</div>
						<div class="panel-body">
							<p><span><i class="glyphicon glyphicon-envelope"></i> 邮箱</span>:1006059906@qq.com</p>
							<p><span><i class="glyphicon glyphicon-phone"></i> 手机</span>:18818864644</p>
							<div>
								<p><span><i class="	glyphicon glyphicon-qrcode"></i> 微信:</span></p>
								<img src="<%=root %>/static/images/twocode.png" style="width:100%;"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-7 col-md-offset-1">
				<div class="blog-leaveword">
					<textarea id="leaveWord" autofocus="autofocus" cols="80" rows="10" placeholder="写下你的看法，只要不是污言秽语，都可以"></textarea>
					<p><div id="submit" class="btn btn-info btn-lg">提交</div></p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="./include/footer.jsp"%>
	<script type="text/javascript" src="<%=root%>/static/js/loader/modernizr.js"></script>
	<script type="text/javascript" src="<%=root%>/static/js/loader/prefixfree.min.js"></script>
	<script src="<%=root%>/static/js/snow/snowfall.jquery.js"></script>
	<script type="text/javascript">
	$(function(){
		$(".navbar-nav li:eq(2)").addClass("top-active");
		//下雪
		//$(document).snowfall({shadow : true, flakeCount:200,round : true,filter:true,minSize: 2, maxSize:10,filterNum:1.5,collection:".wall"});
		
		var wh = $(document).height();
		var textareaH = $("#leaveWord").height();
		$(".blog-leaveword").css("height",wh-textareaH+50);
		var index=0;
		$("#submit").click(function(){
			index = index +1;
			var text = $("#leaveWord").val();
			if(text == ""){
				alert("内容为空无法提交");
				return false;
			}
			//防止网络卡时，提交多次
			if(index == 1){
				$("#blog-mask").show();
				$.ajax({
					type:"POST",
			        url:"<%=root%>/public/leaveword",
			        data:{content:text,time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
					$("#blog-mask").hide();
			       	 if("success" == data.status){
			       		 index = 0;
			       		 alert(data.msg);
			       		$("#leaveWord").val('');
			       	 }else{
			       		 alert(data.msg);
			       	 }
			        }
				})
			}
			return false;
		});
		
	})
	</script>
</body>
</html>