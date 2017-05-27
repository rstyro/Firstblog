<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${article.title }</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">
<link href="<%=request.getContextPath()%>/static/css/article_detail.css"
	rel="stylesheet">
<style>
	.comment-li{
		padding: 1em;
		border-bottom: 1px dashed #fff;
	}
	.comment-li img{
		height:5em;
	}
	.comment-li a img{
		border-radius: 50%;
	}
	.comment-li .media-body p{
		padding-top: 1em;
	}
	.comment-li .media-body p span{
		padding: 1em;
	}
	.comment-li p i{
		cursor: pointer;
	}
	.comment-li .icomment{
		cursor: pointer;
	}
	.comment-li .media-body .media{
		border-left: 3px solid #ccc;
		padding-left: 1em;
	}
	.comment-li .media-body .pcont{
		font-size: 1em;
	}
	.comment-li .media-body .pcont p span{
		color: #868282;
	}
	.comment-li .media-body .pcont p  a.idelc{
		text-decoration:none;
		color: #868282;
	}
	.comment-li .media-body .idelc{
		display: none;
	}
	.comment-li .media-body .media div{
		border-bottom: 1px dashed #ccc;
	}
	.comment-li .media-body .media div p{
		padding: 0;
	}
	.comment-li .media-body .media div p span{
		padding-left: 0;
		color: #868282;
	}
	.comment-li .media-body .media div p a{
		text-decoration: none;
		padding-right: 0.1em;
	}
	.comment-li .media-body .media div p a.pull-right{
		padding-right: 1em;
		color: #868282;
	}
	.comment-li .media-body .media div p a.delc{
		display: none;
	}
</style>
</head>
<body>
	<%@include file="../include/top.jsp"%>
	<div class="container">
		<div style="min-height: 900px;">
			<div class="row">
				<div
					class="col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1 article-detail">
					<p class="article-detail-title">${article.title }</>
					<div class="row">
						<div class="col-sm-1 col-md-1">
							<a href="<%=root%>/user/${article.user_id}/1" target="_blank"><img
								src="/${article.img}" /></a>
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
					<div class="article-content">${article.content }</div>
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

			<div class="row">
				<div class="col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1">
					<h2>
						<span class="glyphicon glyphicon-edit"></span> 发表评论
					</h2>
					<hr>
					<script id="article_comment" name="content" type="text/plain"></script>
					<a href="javascript:void(0);" id="blog_comment" class="btn btn-info pull-right"
						style="margin-top: 1em;">吐槽一下</a>
				</div>
			</div>
			<!-- 评论列表 -->
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1">
					<h5>
						<span class="glyphicon glyphicon-comment"></span> ${article.comment_num }条评论
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
	<script type="text/javascript"
		src="<%=root%>/static/ueditor/ueditor.config.js"></script>
	<script type="text/javascript"
		src="<%=root%>/static/ueditor/ueditor.all.js"></script>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>
	<script src="<%=root%>/static/js/article_detail.js"></script>
	<script>
		var floorNum=1;
		var index=0;
		var task=0;
		var task_count=2;
		$(function(){
			//获取评论
			getComment(1,10);
			
			//点赞
			$(".btn-praise").click(function(){
				$.ajax({
					type:"POST",
			        url:"<%=root%>/public/praise",
			        data:{table_id:${article.article_id},table_type:"article",time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	 if("success" == data.status){
			       		var praiseNum = $("#praiseNum").text();
						if($(".btn-praise").hasClass("red")){
							$(".btn-praise").removeClass("red");
							$("#praiseNum").text(Number(praiseNum)+1);
							$(".btn-praise").addClass("blog-btn-active")
						}else{
							$(".btn-praise").removeClass("blog-btn-active");
							$("#praiseNum").text(Number(praiseNum)-1);
							$(".btn-praise").addClass("red")
						}
			       	 }else if("auth" == data.status){
			       		window.location.href="<%=root%>/toLogin";
			       	 }else{
			       		 alert(data.msg);
			       	 }
			        }
				})
			});
			//评论
			$("#blog_comment").click(function(){
				$.ajax({
					type:"POST",
			        url:"<%=root%>/public/comment",
			        data:{table_id:${article.article_id},reply_user_id:${article.user_id},content:ue.getContent(),praent_id:"",time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	 if("success" == data.status){
			       		$("#commentModal").modal('show');
			       		addcomment(data.data,$("#comment-body"));
			       		task = setInterval("commentTask()",500);
			       		ue.setContent("");
			       	 }else if("auth" == data.status){
			       		window.location.href="<%=root%>/toLogin";
			       	 }else{
			       		 alert(data.msg);
			       	 }
			        }
				})
			});
		})
		
		//弹出框任务
		function commentTask(){
			 if(task_count>0){
				 task_count--;
             }else if(task_count<=0){
                 window.clearInterval(task); 
                 task_count = 2;
                 $("#commentModal").modal('hide');
             }
		}
		
		//添加单条评论
		function addcomment(obj,element){
			var str ="<li class='media comment-li'>"+"<a class='pull-left' href='#''>"
					+"<img class='media-object' src='<%=root%>"+"/../"+obj.img+"' alt='用户头像'></a>"
					+"<div class='media-body'>"+"<h4 class='media-heading'>"+obj.name+"</h4>"
					+"<h5>"+this.floorNum+" 楼  "+obj.create_time+"</h5>"+obj.content
					+"<p><span><i class='glyphicon glyphicon-thumbs-up ipraise'></i><font> "+obj.praise_num+"</font>人赞</span><span><i class='glyphicon glyphicon-comment icomment'></i> 回复</span></p>"
					+"</div></li>";
			element.prepend(str);
			window.floorNum++;
			window.totalPage++;
		}
		
		
		//添加回复评论
		function addReplycomment(obj,element){
			var replyli="<div class='rpy-li'><p><a href='<%=root%>/user/"+obj.user_id+"/1'>"+obj.name+"</a>："
			if(obj.user_id != obj.reply_user_id){
				replyli=replyli+"<a href='<%=root%>/user/"+obj.reply_user_id+"/1'>@"+obj.reply_user_name+" </a>";
			}
			replyli = replyli + obj.content +"</p><p><span>"+obj.create_time+"</span>";
			if(<%=user_id%> == obj.user_id){
				replyli=replyli+"<a href='javascript:void(0);' class='pull-right delc'> 删除</a>";
			}
			replyli=replyli+"</p></div>";
			if(element.find("div.media").length == 0){
				replyli = 	"<div class='media'>"+replyli+"</div>";
				element.append(replyli);
			}else{
				element.find("div.media").append(replyli);
			}
		}
		
		//添加评论列表
		function addCommentList(data){
			if(data.length > 0){
				$("#comment-body").empty();
				var str = "";
				for(var i = 0;i< data.length;i++){
					var obj = data[i];
					str = str+ "<li class='media comment-li' id='"+obj.comment_id+"' user_id='"+obj.user_id+"'>"+"<a class='pull-left' href='<%=root%>/user/"+obj.user_id+"/1''>"
						+"<img class='media-object' src='<%=root%>"+"/../"+obj.img+"' alt='用户头像'></a>"
						+"<div class='media-body'>"+"<h4 class='media-heading'>"+obj.name+"</h4>"
						+"<h5>"+this.floorNum+" 楼  "+obj.create_time+"</h5><div class='pcont'>"+obj.content
						+"<p><span><i class='glyphicon glyphicon-thumbs-up ipraise'></i><font> "+obj.praise_num+"</font>人赞</span><span class='icomment'><i class='glyphicon glyphicon-comment'></i> 回复</span>";
						if(<%=user_id%> == obj.user_id){
							str=str+"<a href='javascript:void(0);' class='pull-right idelc' cid='"+obj.comment_id+"'> 删除</a>";
						}
						str=str+"</p></div>";
						//回复体
						if(typeof(obj.replybody) != "undefined"){
							var replystr="<div class='media'>";
							var rpybody="";
							for(var j=0;j<obj.replybody.length;j++){
								var reply = obj.replybody[j];
								var replyli="<div class='rpy-li'><p><a href='<%=root%>/user/"+reply.user_id+"/1' uid='"+reply.user_id+"'>"+reply.name+"</a>：";
								if(reply.user_id != reply.reply_user_id){
									replyli=replyli+"<a href='<%=root%>/user/"+reply.reply_user_id+"/1'>@"+reply.reply_user_name+" </a>";
								}
								replyli = replyli + reply.content +"</p><p><span>"+reply.create_time+"</span>";
								
								if(reply.user_id != <%=user_id%>){
									replyli=replyli+"<a href='javascript:void(0);' class='pull-right replyreply'><i class='glyphicon glyphicon-comment'></i> 回复</a>";
								}
								if(<%=user_id%> == reply.user_id){
									replyli=replyli+"<a href='javascript:void(0);' class='pull-right delc' cid='"+reply.comment_id+"'> 删除</a>";
								}
								replyli=replyli+"</p></div>";
								rpybody =rpybody+replyli;
							}
							replystr =replystr+rpybody+"</div>";
							str = str+replystr;
						}
						str = str+"</div></li>";
						this.floorNum++;
				}
				//评论点赞
				$("#comment-body").append(str).find("i.ipraise").click(function(){
					var tableId = $(this).parent().parent().parent().parent().parent().attr("id");
					var praiseNum = $(this).next().text();
		       		var thisi = $(this);
						$.ajax({
							type:"POST",
					        url:"<%=root%>/public/praise",
					        data:{table_id:tableId,table_type:"comment",time:new Date().getTime()},
					        dataType:"json",
					        cache:false,
					        success: function(data){
						       	 if("success" == data.status){
									if(thisi.hasClass("red")){
										thisi.removeClass("red");
										thisi.next().text(Number(praiseNum)-1);
									}else{
										thisi.addClass("red")
										thisi.next().text(Number(praiseNum)+1);
									}
						       	 }else if("auth" == data.status){
						       		window.location.href="<%=root%>/toLogin";
						       	 }else{
						       		 alert(data.msg);
						       	 }
					        }
						})
				
					});
				
				
				//回复评论
				$("#comment-body").find(".icomment").click(function(){
					var parentId = $(this).parent().parent().parent().parent().attr("id");
					var replyUserId = $(this).parent().parent().parent().parent().attr("user_id");
					var replyBody = $(this).parent().parent().parent();
					var replyUserName = $(this).parent().parent().parent().find("h4.media-heading").text();
					if($(".replytext > textarea").length == 0){
						$(".replytext").remove();
						$(this).parent().parent().append("<div class='replytext media'><textarea cols='100' rows='3' autofocus='autofocus' style='resize:none;'></textarea><br><span class='btn btn-info' id='replyfloor'>回复</span></div>").find("#replyfloor").click(function(){
								var content = $(this).prev().prev().val();
								$.ajax({
									type:"POST",
							        url:"<%=root%>/public/comment",
							        data:{table_id:${article.article_id},reply_user_id:replyUserId,reply_user_name:replyUserName,content:content,parent_id:parentId,time:new Date().getTime()},
							        dataType:"json",
							        cache:false,
							        success: function(data){
							       	 if("success" == data.status)  {
							       		addReplycomment(data.data,replyBody);
							       		$(".replytext").remove();
							       	 }else if("auth" == data.status){
							       		window.location.href="<%=root%>/toLogin";
							       	 }else{
							       		 alert(data.msg);
							       	 }
							        }
								})
							});
						}else{
							$(".replytext").remove();
						}
				});
				
				//回复体里的回复
				$("#comment-body").children().children().children().find("a.replyreply").click(function(){
					var parentId = $(this).parent().parent().parent().parent().parent().attr("id");
					var url="<%=root%>/public/comment";
					var replyBody=$(this).parent().parent().parent().parent();
					var tableId=${article.article_id};
					var replyUserId=$(this).parent().prev().find("a").eq(0).attr("uid");
					var replyUserName=$(this).parent().prev().find("a").eq(0).html();
					if($(".replytext > textarea").length == 0){
						$(".replytext").remove();
						$(this).parent().parent().append("<div class='replytext media'><textarea cols='100' rows='3' autofocus='autofocus' style='resize:none;'></textarea><br><span class='btn btn-info' id='replyfloor'>回复</span></div>").find("#replyfloor").click(function(){
							var content = $(this).prev().prev().val();
							replyComment(url,tableId,replyUserId,replyUserName,content,parentId,replyBody)
						});
					}else{
						$(".replytext").remove();
					}
				});
				
				//显示删除按钮
				$("#comment-body").children().children().children("div.pcont").mouseenter(function(){
					$(this).find(".idelc").show();
				}).mouseleave(function(){
					$(this).find(".idelc").hide();
				});
				$("#comment-body").children().children().children().children("div.rpy-li").mouseenter(function(){
					$(this).find(".delc").show();
				}).mouseleave(function(){
					$(this).find(".delc").hide();
				});
				
				//删除楼层的评论
				$("#comment-body").children().children().children().find(".idelc").click(function(){
					var commentId = $(this).attr("cid");
					var el = $(this).parent().parent().parent().parent();
					var url="<%=root%>/public/delComment";
					delComment(commentId,el,url);
				});
				//删除子评论
				$("#comment-body").children().children().children().children().find(".delc").click(function(){
					var commentId = $(this).attr("cid");
					var el = $(this).parent().parent();
					var url="<%=root%>/public/delComment";
					delComment(commentId,el,url);
				});
			}
		}
		
		function delComment(commendId,el,url){
			$.ajax({
				type:"GET",
		        url:url,
		        data:{comment_id:commendId,time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		       	 if("success" == data.status)  {
		       		el.remove();
		       	 }else if("auth" == data.status){
		       		window.location.href="<%=root%>/toLogin";
		       	 }else{
		       		 alert(data.msg);
		       	 }
		        }
			})
		}
		
		//回复评论
		function replyComment(url,tableId,replyUserId,replyUserName,content,parentId,replyBody){
			$.ajax({
				type:"POST",
		        url:url,
		        data:{table_id:tableId,reply_user_id:replyUserId,reply_user_name:replyUserName,content:content,parent_id:parentId,time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		       	 if("success" == data.status)  {
		       		addReplycomment(data.data,replyBody);
		       		$(".replytext").remove();
		       	 }else if("auth" == data.status){
		       		window.location.href="<%=root%>/toLogin";
		       	 }else{
		       		 alert(data.msg);
		       	 }
		        }
			})
		}
		
		//获取评论
		function getComment(pageNo,pageSize){
			$.ajax({
				type:"GET",
		        url:"<%=root%>/public/getComment",
		        data:{page_no:pageNo,page_size:pageSize,table_id:${article.article_id},time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		       	 if("success" == data.status){
		       		this.floorNum = data.page.totalResult;
		       		if(data.page.totalPage > 1){
			       		//分页
					    var element = $('#mypage');
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
						    	  floorNum=(page-1)*10+1;
						          getComment(page,10);
						      }
						  };
						  element.bootstrapPaginator(options);
		       		}
		       		addCommentList(data.data);
		       	 }else if("auth" == data.status){
		       		window.location.href="<%=root%>/toLogin";
		       	 }else{
		       		 alert(data.msg);
		       	 }
		        }
			})
		};
	</script>
</body>
</html>