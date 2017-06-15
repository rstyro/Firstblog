<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
	<div id="blog-mask">
		<div class='loader loader--glisteningWindow'></div>
	</div>
	<div class="container">
		<div class="blog-leaveword">
			<header class="">
				<h1>给我留言</h1>
				<h2>联系我</h2>
				<p>邮箱:1006059906@qq.com</p>
			</header>
			<textarea id="leaveWord" autofocus="autofocus" cols="100" rows="10" placeholder="写下你的看法，只要不是污言秽语，都可以"></textarea>
			<p><div id="submit" class="btn btn-info btn-lg">提交</div></p>
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="./include/footer.jsp"%>
	<script type="text/javascript" src="<%=root%>/static/js/loader/modernizr.js"></script>
	<script type="text/javascript" src="<%=root%>/static/js/loader/prefixfree.min.js"></script>
	<script src="<%=root%>/static/js/snow/snowfall.jquery.js"></script>
	<script type="text/javascript">
	$(function(){
		//下雪
		$(document).snowfall({shadow : true, flakeCount:200});
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