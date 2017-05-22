<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
</head>
<%@include file="../include/top.jsp"%>
<style>
	.row img{
		width: 100%;
		border-radius: 50%;
	}
	.row a{
		text-decoration: none;
	}
	.notice-border{
		height: 20px;
		border-top: 1px solid #ccc;
	}
	#letterDetailList .container .row .media-list img{
		width: 7em;
	}
	#letterDetailList .container .row .media-list .media-body{
		width:40%;
		background-color: #ccc;
		color: #fff;
		margin-top: 1em;
	}
	#letterDetailList .container .row .media-list .media-body p{
		padding-left: 0.5em;
		padding-right: 0.5em;
	}
	

</style>
<body>
	<div class="container">
		<div style="height: 20px;"></div>
		<div class="row">
			<div class="col-sm-3 col-md-2">
				<ul id="myTab" class="nav nav-tabs nav-pills nav-stacked">
					<li class="active"><a href="#comment" data-toggle="tab"><span class="glyphicon glyphicon-comment"></span> 评论</a></li>
					<li id="li-letter"><a href="#privateLetter" data-toggle="tab"><span class="glyphicon glyphicon-envelope"></span> 私信</a></li>
					<li id="li-concern"><a href="#concern" data-toggle="tab"><span class="glyphicon glyphicon-thumbs-up"></span> 关注</a></li>
					<li id="li-praise"><a href="#praise" data-toggle="tab"><span class="glyphicon glyphicon-thumbs-up"></span> 点赞</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-md-10">
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane fade in active" id="comment">
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 在文章<a href="#">《Linux 下安装配置svn服务器》</a> 中评论了你</p>
								<p><a href="#">@这个冬天不太冷</a> <span>这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！</span></p>
								<p class="pull-right"><a href="#">回复</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div class="notice-border"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1"><a href="#"><img src="/upload/user/default.png"></a></div>
							<div class="col-sm-10 col-md-10">
								<p><a href="#">匿名用户</a> 在文章<a href="#">《Linux 下安装配置svn服务器》</a> 中评论了你</p>
								<p><a href="#">@这个冬天不太冷</a> <span>这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！</span></p>
								<p class="pull-right"><a href="#">回复</a></p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div class="notice-border"></div>
					</div>
					<div class="tab-pane fade" id="privateLetter">
						<div id="letterDetailList">
							<div class="container">
								<div class="row">
									<div class="col-sm-5 col-md-4">
										<span><i class="glyphicon glyphicon-chevron-left"></i>
											返回信件列表</span>
									</div>
									<div class="col-sm-7 col-md-8">与 这个冬天不太冷的对话</div>
								</div>
								<hr style="">
								<div class="row">
									<ul class="media-list">
										<li class="media"><a class="pull-left" href="#">
										<img class="media-object" src="<%=root %>/../upload/user/default.png" alt="通用的占位符图像">
										</a><div class="media-body pull-left">
												<p>这是一些示例文本。这是一些示例文本。 这是一些示例文本。这是一些示例文本。
													这是一些示例文本。这是一些示例文本。 这是一些示例文本。这是一些示例文本。 这是一些示例文本。这是一些示例文本。</p>
												<p>2017-05-24 12:12:12</p>
											</div>
										</li>
										<li class="media">
										<a class="pull-right" href="#"><img class="media-object" src="<%=root %>/../upload/user/default.png" alt="通用的占位符图像">
										</a>
											<div class="media-body pull-right">
												<p>
												这是一些示例文本。这是一些示例文本。 这是一些示例文本。这是一些示例文本。 这是一些示例文本。这是一些示例文本。
												这是一些示例文本。这是一些示例文本。 这是一些示例文本。这是一些示例文本。</p>
												<p class="pull-right">2017-05-24 12:12:12</p>
											</div>
										</li>
										
										
									</ul>
								</div>
								
							</div>
						</div>
						<div id="letterList"></div>
						<div class="pull-right">
							<ul id='letterPage' class="pagination"></ul>
						</div>
					</div>
					<div class="tab-pane fade" id="concern">
						<div id="concernList"></div>
						<div class="pull-right">
							<ul id='concerPage' class="pagination"></ul>
						</div>
					</div>
					<div class="tab-pane fade" id="praise">
						<div id="praiseList"></div>
						<div class="pull-right">
							<ul id='praisePage' class="pagination"></ul>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>
		<script>
			$(function() {
				var wh = $(document).height();
				$("#myTabContent").css("height",wh-150);
				$("#li-concern").click(function(){
					if($("#concernList").children(".row").length == 0){//如果是空节点再请求
						addConcernList(1);
					}
				});
				$("#li-praise").click(function(){
					if($("#praiseList").children(".row").length == 0){//如果是空节点再请求
						addPraiseList(1);
					}
				});
				$("#li-letter").click(function(){
					if($("#letterList").children(".row").length == 0){//如果是空节点再请求
						addLetterList(1);
					}
				});
				
			});
			
			//添加关注列表
			function addConcernList(pageNo){
				$.ajax({
					type:"GET",
			        url:"<%=root%>/notice/getConcernList",
			        data:{page_no:pageNo,time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			        console.log(data);
			       	 if("success" == data.status){
			       		if(data.page.totalPage > 1){
				       		//分页
						    var element = $('#concerPage');
							  options = {
							      bootstrapMajorVersion:3, //对应的bootstrap版本
							      currentPage:data.page.currentPage, //当前页数，
							      numberOfPages:data.page.showCount, //每页的大小
							      totalPages:data.page.totalPage, //总页数，
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
							    	  addConcernList(page);
							      }
							  };
							  element.bootstrapPaginator(options);
			       		}
				       		addConcernData(data.data);
			       	 }else if("auth" == data.status){
			       		window.location.href="<%=root%>/toLogin";
			       	 }else{
			       		 alert(data.msg);
			       	 }
			        }
				})
			}
			
			//添加关注数据
			function addConcernData(data){
				$("#concernList").empty();
				var str = "";
				for(var i=0;i<data.length;i++){
					var obj = data[i];
					str += "<div class='row'><div class='col-sm-1 col-md-1'><a href='<%=root%>/user/"+obj.from_user_id+"/1'>"
						+"<img src='<%=root%>/../"+obj.img+"'></a></div><div class='col-sm-10 col-md-10'><p><a href='<%=root%>/user/"+obj.from_user_id+"/1'>"+obj.name+"</a> 关注了你</p>"
						+"<p>"+obj.create_time+"</p></div></div><div class='notice-border'></div>";
				}
				$("#concernList").prepend(str);
			}
			
			//添加点赞列表
			function addPraiseList(pageNo){
				$.ajax({
					type:"GET",
			        url:"<%=root%>/notice/getPraiseList",
			        data:{page_no:pageNo,time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			        console.log(data);
			       	 if("success" == data.status){
			       		if(data.page.totalPage > 1){
				       		//分页
						    var element = $('#praisePage');
							  options = {
							      bootstrapMajorVersion:3, //对应的bootstrap版本
							      currentPage:data.page.currentPage, //当前页数，
							      numberOfPages:data.page.showCount, //每页的大小
							      totalPages:data.page.totalPage, //总页数，
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
							    	  addPraiseList(page);
							      }
							  };
							  element.bootstrapPaginator(options);
			       		}
			       			addpraiseData(data.data);
			       	 }else if("auth" == data.status){
			       		window.location.href="<%=root%>/toLogin";
			       	 }else{
			       		 alert(data.msg);
			       	 }
			        }
				})
			}
			//添加点赞数据
			function addpraiseData(data){
				$("#praiseList").empty();
				var str = "";
				for(var i=0;i<data.length;i++){
					var obj = data[i];
					str += "<div class='row'><div class='col-sm-1 col-md-1'><a href='<%=root%>/user/"+obj.from_user_id+"/1'>"
						+"<img src='<%=root%>/../"+obj.img+"'></a></div><div class='col-sm-10 col-md-10'><p><a href='<%=root%>/user/"+obj.from_user_id+"/1'>"+obj.name+"</a> 赞了您的文章<a href='<%=root%>/article/"+obj.table_id+"'>《"+obj.title+"》</a></p>"
						+"<p>"+obj.create_time+"</p></div></div><div class='notice-border'></div>";
				}
				
				$("#praiseList").prepend(str);
			}
			
			
			//添加信件列表
			function addLetterList(pageNo){
				$.ajax({
					type:"GET",
			        url:"<%=root%>/notice/getLetterList",
			        data:{page_no:pageNo,time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			        console.log(data);
			       	 if("success" == data.status){
			       		if(data.page.totalPage > 1){
				       		//分页
						    var element = $('#letterPage');
							  options = {
							      bootstrapMajorVersion:3, //对应的bootstrap版本
							      currentPage:data.page.currentPage, //当前页数，
							      numberOfPages:data.page.showCount, //每页的大小
							      totalPages:data.page.totalPage, //总页数，
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
							    	  addLetterList(page);
							      }
							  };
							  element.bootstrapPaginator(options);
			       		}
			       		addLetterData(data.data);
			       	 }else if("auth" == data.status){
			       		window.location.href="<%=root%>/toLogin";
			       	 }else{
			       		 alert(data.msg);
			       	 }
			        }
				})
			}
			//添加信件数据
			function addLetterData(data){
				$("#letterList").empty();
				var str = "";
				for(var i=0;i<data.length;i++){
					var obj = data[i];
					str += "<div class='row'><div class='col-sm-1 col-md-1'><a href='<%=root%>/user/"+obj.from_user_id+"/1'>"
						+"<img src='<%=root%>/../"+obj.img+"'></a></div><div class='col-sm-10 col-md-10'><p><a href='<%=root%>/user/"+obj.from_user_id+"/1'>"+obj.name+"</a> 给你写了信</p>"
						+"<p class='pull-right'><a href='javascript:void(0);' onclick='lookletterDetail("+obj.table_id+")'>查看详情</a></p><p>"+obj.create_time+"</p></div></div><div class='notice-border'></div>";
				}
				$("#letterList").prepend(str);
			}
			
			function lookletterDetail(tableId){
				$("#letterList").hide();
				if($("#letterDetailList").children("#det"+tableId).length == 0){
					addLetterDetail(tableId);
				}else{
					$("#letterDetailList").show();
				}
			}
			
			function addLetterDetail(tableId){
				$("#letterDetailList").empty();
				var str="";
			}
		</script>
	</div>
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>
</html>