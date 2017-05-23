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
.row img {
	width: 100%;
	border-radius: 50%;
}

.row a {
	text-decoration: none;
}

.notice-border {
	height: 20px;
	border-top: 1px solid #ccc;
}

#letterDetailList {
	position: relative;
}

#letterDetailList .container .replybody {
	margin-top: 10em;
}

#letterDetailList .container .row #returnlist {
	cursor: pointer;
	color: #9a9090;
	font-weight: bold;
}
#letterDetailList .container .row #fromUsername {
	color: #111;
	font-weight: bold;
}
#letterDetailList .container .row .media-list img {
	width: 7em;
}

#letterDetailList .container .row .media-list {
	overflow: auto;
	width: 100%;
	max-height: 500px;
}

#letterDetailList .container .row input[name='reply'] {
	width: 80%;
	height: 2em;
	float: left;
}

#letterDetailList .container .row .media-list .media-body {
	width: 40%;
	background-color: #ccc;
	color: #fff;
	margin-top: 1em;
}

#letterDetailList .container .row .media-list .media-body p {
	padding-left: 0.5em;
	padding-right: 0.5em;
}

#letterDetailList .container .row .media-list div {
	border-radius: 0.5em;
}

#letterDetailList .container .row textarea {
	float: right;
}

#letterDetailList .container .row button {
	float: left;
}

#letterDetailList .container .row .media-list div.pull-left {
	background-color: #5DADF5;
}

#letterDetailList .container .row .media-list div.pull-right {
	background-color: #646962;
}
</style>
<body>
	<div class="container">
		<div style="height: 20px;"></div>
		<div class="row">
			<div class="col-sm-3 col-md-2">
				<ul id="myTab" class="nav nav-tabs nav-pills nav-stacked">
					<li class="active"><a href="#comment" data-toggle="tab"><span
							class="glyphicon glyphicon-comment"></span> 评论</a></li>
					<li id="li-letter"><a href="#privateLetter" data-toggle="tab"><span
							class="glyphicon glyphicon-envelope"></span> 私信</a></li>
					<li id="li-concern"><a href="#concern" data-toggle="tab"><span
							class="glyphicon glyphicon-thumbs-up"></span> 关注</a></li>
					<li id="li-praise"><a href="#praise" data-toggle="tab"><span
							class="glyphicon glyphicon-thumbs-up"></span> 点赞</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-md-10">
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane fade in active" id="comment">
						<div class="row">
							<div class="col-sm-1 col-md-1">
								<a href="#"><img src="/upload/user/default.png"></a>
							</div>
							<div class="col-sm-10 col-md-10">
								<p>
									<a href="#">匿名用户</a> 在文章<a href="#">《Linux 下安装配置svn服务器》</a>
									中评论了你
								</p>
								<p>
									<a href="#">@这个冬天不太冷</a> <span>这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！</span>
								</p>
								<p class="pull-right">
									<a href="#">回复</a>
								</p>
								<p>2017.05.19 17:35:02</p>
							</div>
						</div>
						<div class="notice-border"></div>
						<div class="row">
							<div class="col-sm-1 col-md-1">
								<a href="#"><img src="/upload/user/default.png"></a>
							</div>
							<div class="col-sm-10 col-md-10">
								<p>
									<a href="#">匿名用户</a> 在文章<a href="#">《Linux 下安装配置svn服务器》</a>
									中评论了你
								</p>
								<p>
									<a href="#">@这个冬天不太冷</a> <span>这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！这个冬天确实不怎么冷哦，夏天还比较冷！！！！</span>
								</p>
								<p class="pull-right">
									<a href="#">回复</a>
								</p>
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
										<span id="returnlist"><i class="glyphicon glyphicon-chevron-left"></i>
											返回信件列表</span>
									</div>
									<div class="col-sm-7 col-md-8">与 <span id="fromUsername">这个冬天不太冷</span> 的对话</div>
								</div>
								<hr style="">
								<div class="row talk">
								</div>
								<div class="row replybody">
									<div class="col-sm-9 col-md-10">
										<textarea name="reply" placeholder="回复" cols="80" rows="5"></textarea>
									</div>
									<div class="col-sm-3 col-md-2">
										<button class="btn btn-info btn-lg" id="replyletter">发送</button>
									</div>
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
				$("#letterDetailList").hide();
				var wh = $(document).height();
				$("#myTabContent").css("min-height",wh-150);
				$(".media-list").css("max-height",wh-150);
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
					$("#letterDetailList").hide();
					$("#letterList").show();
					$("#letterPage").show();
					if($("#letterList").children(".row").length == 0){//如果是空节点再请求
						addLetterList(1);
					}
				});
				
				$("#returnlist").click(function(){
					$("#letterDetailList").hide();
					$("#letterList").show();
					$("#letterPage").show();
					if($("#letterList").children(".row").length == 0){//如果是空节点再请求
						addLetterList(1);
					}
				});
				
				$("#replyletter").click(function(){
					var text = $("textarea[name='reply']").val();
					sendLetty(text);
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
				$("#letterPage").hide();
				if($("#let"+tableId).children().length == 0){
					$.ajax({
						type:"GET",
				        url:"<%=root%>/notice/getLetterDetail",
				        data:{table_id:tableId,time:new Date().getTime()},
				        dataType:"json",
				        cache:false,
				        success: function(data){
				       	console.log(data);
				       	 if("success" == data.status){
				       		addLetterDetail(data.data,tableId);
				       	 }else if("auth" == data.status){
				       		window.location.href="<%=root%>/toLogin";
							} else {
								alert(data.msg);
							}
						}
					})
				}
				$("#letterDetailList").show();
			}
			var lastDetailId="";
			var fromUserId="";
			var userId = "";
			var userimg="";
			function addLetterDetail(data,tableId) {
				$("#let"+lastDetailId).remove();
	       		console.log("之前-lastDetailId="+lastDetailId);
	       		lastDetailId=tableId;
	       		console.log("之后-lastDetailId="+lastDetailId);
	       		
				var str = "<div id='let"+tableId+"'><ul class='media-list'>";
				for(var i=0;i<data.length;i++){
					var obj = data[i];
					if(i==0){
						fromUserId = obj.from_user_id;
						userId = obj.user_id;
						$("#fromUsername").text(obj.name);
					}
					var sli="";
					if(fromUserId == obj.from_user_id){
						//左边
						sli = "<li class='media'><a class='pull-left' href='<%=root%>/user/"+obj.from_user_id+"/1'>"
							+"<img class='media-object' src='<%=root%>/../"+obj.img+"' alt='用户头像'></a>"
							+"<div class='media-body pull-left'><p>"+obj.content+"</p><p>"+obj.create_time+"</p></div></li>";
					}else{
						userimg=obj.img;
						//右边
						sli = "<li class='media'><a class='pull-right' href='<%=root%>/user/"+obj.from_user_id+"/1'>"
							+"<img class='media-object' src='<%=root%>/../"+obj.img+"' alt='用户头像'></a>"
							+"<div class='media-body pull-right'><p>"+obj.content+"</p><p>"+obj.create_time+"</p></div></li>";
					}
						str += sli;
				}
				str += "</ul></div>";
				$("#letterDetailList ").children().children(".talk").append(str);
			}
			
			function getNowFormatDate() {
			    var date = new Date();
			    var seperator1 = "-";
			    var seperator2 = ":";
			    var month = date.getMonth() + 1;
			    var strDate = date.getDate();
			    if (month >= 1 && month <= 9) {
			        month = "0" + month;
			    }
			    if (strDate >= 0 && strDate <= 9) {
			        strDate = "0" + strDate;
			    }
			    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
			            + " " + date.getHours() + seperator2 + date.getMinutes()
			            + seperator2 + date.getSeconds();
			    return currentdate;
			}
			
			function sendLetty(text){
				var nowTime = getNowFormatDate();
				$.ajax({
					type:"POST",
			        url:"<%=root%>/notice/replyLetter",
			        data:{content:text,from_user_id:fromUserId,parent_id:lastDetailId,time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	console.log(data);
			       	 if("success" == data.status){
							$("textarea[name='reply']").val('');
							var sli = "<li class='media'><a class='pull-right' href='<%=root%>/user/"+userId+"/1'>"
							+"<img class='media-object' src='<%=root%>/../"+userimg+"' alt='用户头像'></a>"
							+"<div class='media-body pull-right'><p>"+text+"</p><p>"+nowTime+"</p></div></li>";
							$("#let"+lastDetailId).append(sli);
			       	 }else{
						alert(data.msg);
					}
			        }
				})
			}
		</script>
	</div>
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>
</html>