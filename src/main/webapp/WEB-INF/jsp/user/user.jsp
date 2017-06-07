<!-- 
		(‧_‧？),有什么能帮你的？，加我QQ:1006059906!
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${user.name }</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/static/images/favicon.ico">

<%@include file="../include/top.jsp"%>
<link href="<%=root%>/static/css/cropper.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/checkbox.css"
	media="screen" type="text/css" />
</head>
<%
	int meId = Integer.parseInt(user_id);
%>
<style>
.blog-user {
	padding-top: 1em;
}

.blog-user .uh {
	margin-top: 1em;
	border-radius: 50%;
	border: 2px solid #f00;
	width: 100%;
	height: 100%;
	overflow: hidden;
	position: relative;
}

.blog-user h2 {
	text-align: left;
}

.blog-user img {
	width: 100%;
}

.blog-user p {
	padding-top: 1em;
}

.blog-user p span {
	font-weight: bold;
	font-size: 1.1em;
}

.blog-user div.modify {
	position: absolute;
	width: 100%;
	height: 30%;
	left: 0;
	text-align: center;
	background-color: #000;
	color: #fff;
	opacity: 0.8;
	bottom: -30%;
}

.blog-user div.modify a {
	color: #fff;
	font-size: 0.9em;
	text-decoration: none;
}

#myTab>li.active>a, #myTab>li.active>a:hover, #myTab>li.active>a:focus {
	background-color: #e2e2e2;
	font-weight: bold;
	color: #111;
}

#dynamic {
	padding: 1em;
}

#headModal .modal-content .modal-body img {
	width: 100%;
	border-radius: 50%;
}

#headModal .modal-content .modal-body .row div div {
	text-align: center;
	padding-top: 1em;
}

#headModal .modal-content .modal-body .row div input[name='imgfile'] {
	display: none;
}

#headModal .modal-content .modal-body .row div div a {
	text-decoration: none;
}

#headModal .modal-content .modal-header {
	border-bottom: 0px;
}

#uploadModal .cropBg {
	width: 500px;
	height: 500px;
}

#uploadModal .cropBg img {
	height: 100%;
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
<body>
	<script src="<%=root%>/static/js/cropper.min.js"></script>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>

	<div class="container">
		<div class="row blog-user">
			<div class="col-sm-2 col-md-2">
				<div class="uh">
					<img alt="用户头像" src="${userInfo.img}" onerror="imgerror(this)">
					<c:if test="${userInfo['user_id'] eq user_id}">
						<div class="modify">
							<p>
								<a href="javascript:void(0);">更换头像</a>
							</p>
						</div>
					</c:if>
				</div>
			</div>
			<div class="col-sm-7 col-md-7">
				<h2>${userInfo.name }</h2>
				<div class="row">
					<p class="col-sm-2">
						<c:if test="${userInfo.user_id == '1' }">
							<span><i class="glyphicon glyphicon-fire red"></i> 博主</span>
						</c:if>
						<c:if test="${userInfo.user_id != '1' }">
							<span><i class="glyphicon glyphicon-fire red"></i> 博员</span>
						</c:if>
					</p>
					<p class="col-sm-2">
						关注数:<span>${userInfo.concern_num }</span>
					</p>
					<p class="col-sm-2">
						粉丝数:<span>${userInfo.fans_num }</span>
					</p>
					<p class="col-sm-2">
						获赞数:<span>${userInfo.fans_num }</span>
					</p>
					<p class="col-sm-4">
						位置:<span>${userInfo.locate }</span>
					</p>
				</div>
				<p><i class="glyphicon glyphicon-pencil green"></i>${userInfo.sign }</p>
				<div class="row">
					<div class="blog-labels">
						<c:choose>
							<c:when test="${not empty userLabels}">
								<c:forEach items="${userLabels}" var="label" varStatus="vs">
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
			<div class="col-sm-3 col-md-3">
				<c:if test="${userInfo.user_id != user_id}">
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
					<a href="javascript:void(0);" uid="${userInfo.user_id }"
						uname="${userInfo.name }" class="btn btn-info btn-letter"><span><i
							class="glyphicon glyphicon-envelope"></i> 私信</span></a>
				</c:if>
				<c:if test="${userInfo.user_id eq user_id}">
					<a href="javascript:void(0)" uid="${userInfo.user_id }"
						class="btn btn-default btn-edit"> <span
						class="glyphicon glyphicon-edit"></span><span> 编辑</span>
					</a>
				</c:if>
			</div>
		</div>

		<hr style="padding: 20px;">
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a href="#article" data-toggle="tab"><i
					class="glyphicon glyphicon-list-alt"></i> 文章</a></li>
			<li><a href="#dynamic" data-toggle="tab"><i
					class="glyphicon glyphicon-globe"></i> 动态</a></li>
			<li><a href="#comment" data-toggle="tab"><i
					class="glyphicon glyphicon-comment"></i> 最近评论</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="article">
				<div class="row">
					<div class="col-sm-10 col-md-10">
						<div class="blog-user-article">
							<%@include file="../include/right.jsp"%>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="dynamic">
				<div class="row">
					<div class="col-sm-10 col-md-10">
						<p>有空开发！！！！！！！</p>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="comment">
				<div class="row">
					<div class="col-sm-10 col-md-10">
						<p>有空开发！！！！！！！</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="headModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">更改头像</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-6 col-md-6 col-sm-offset-3 col-md-offset-3">
							<img class="uimg" src="${userInfo.img}" />
							<div class="row">
								<div class="col-md-4 col-md-offset-1">
									<a href="javascript:void(0);" class="changeUI">换一换</a>
								</div>
								<div class="col-md-4 col-md-offset-2">
									<a href="javascript:void(0);" class="uploadUI">上传头像</a>
								</div>
								<input type="file" name="imgfile" id="imgfile" />
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="margin: 0px auto; width: 25%;">
					<button type="button" class="btn btn-info imgsure">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">更改头像</h4>
				</div>
				<div class="modal-body">
					<div class="cropBg">
						<img src="" id="uCropImg">
					</div>
				</div>
				<div class="modal-footer" style="margin: 0px auto; width: 25%;">
					<button type="button" class="btn btn-info" id="uploadimgsure">上传</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="uInfo" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">编辑个人信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					  <div class="form-group">
					    <label for="name" class="col-sm-2 control-label">昵称</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" name="name" value="${userInfo.name}" id="name" placeholder="请输入名字">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="locate" class="col-sm-2 control-label">城市</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" name="locate" value="${userInfo.locate}" id="locate" placeholder="请输入城市">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="locate" class="col-sm-2 control-label">个性签名</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" name="sign" value="${userInfo.sign}" id="sign" placeholder="请输入个性签名">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="labels" class="col-sm-2 control-label">标签</label>
					    <div class="col-sm-10">
					    	<div class="checkbox">
								<c:choose>
										<c:when test="${ not empty labels}">
											<c:forEach items="${labels }" var="label" varStatus="vs">
												<c:set var="flag" value="0"></c:set>
												<c:choose>
													<c:when test="${not empty userLabels}">
														<c:forEach items="${userLabels}" var="ulabel"
															varStatus="vvs">
															<c:if test="${ulabel.label_id ==  label.label_id}">
																<c:set var="flag" value="1"></c:set>
															</c:if>

															<c:if test="${flag==1}">
																<div class="label-checkbox">
																	<h4>${label.label_name }</h4>
																	<input class='tgl tgl-flip' checked="checked"
																		id='${label.label_id }' name="labels"
																		value="${label.label_id }" type='checkbox'> <label
																		class='tgl-btn' data-tg-off='不带' data-tg-on='带上'
																		for='${label.label_id }'></label>
																</div>
																<c:set var="flag" value="2"></c:set>
															</c:if>
															<c:if test="${flag == 0 }">
																<c:if test="${vvs.last }">
																	<div class="label-checkbox">
																		<h4>${label.label_name }</h4>
																		<input class='tgl tgl-flip' id='${label.label_id }'
																			name="labels" value="${label.label_id }"
																			type='checkbox'> <label class='tgl-btn'
																			data-tg-off='不带' data-tg-on='带上'
																			for='${label.label_id }'></label>
																	</div>
																</c:if>
															</c:if>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<div class="label-checkbox">
															<h4>${label.label_name }</h4>
															<input class='tgl tgl-flip' id='${label.label_id }'
																name="labels" value="${label.label_id }" type='checkbox'>
															<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上'
																for='${label.label_id }'></label>
														</div>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</c:when>
									</c:choose>
									</div>
					    </div>
					  </div>
					  
					</form>
				</div>
				<div class="modal-footer" style="margin: 0px auto; width: 25%;">
					<button type="button" class="btn btn-info" id="editSure">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>
<script type="text/javascript" src="<%=root%>/static/js/user.js"></script>
<script type="text/javascript">
	var root ="<%=root%>";
	$(function(){
		 var element = $('#mypage');
		  options = {
		      bootstrapMajorVersion:3, //对应的bootstrap版本
		      currentPage: ${page.currentPage }, //当前页数，这里是用的EL表达式，获取从后台传过来的值
		      numberOfPages:${page.showCount }, //每页页数
		      totalPages:${page.totalPage }, //总页数，这里是用的EL表达式，获取从后台传过来的值
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
		          location.href = root+"/user/"+${userInfo.user_id}+"/" + page;
		      }
		  };
		  element.bootstrapPaginator(options);
		  
		  var wh = $(window).height();
		  var h = $(".blog-user").height();
		  $("#myTabContent").css("height",wh-h-200);
		 
		  $(".uh").mouseenter(function(){
				$(this).find(".modify").stop().animate({bottom:0},300);
			}).mouseleave(function(){
				$(this).find(".modify").stop().animate({bottom:"-30%"},300);
			});
		  $(".modify").click(function(){
			  $("#headModal").modal("show");
		  });
		  var index = 1;
		  var userPath = $(".uimg").attr("src");
		  $(".changeUI").click(function(){
			  var path = "/upload/user/i"+index+".png";
			  $(".uimg").attr("src",path);
			  index++;
			  if(index == 101){
				  index=1;
			  }
		  });
		  $(".uploadUI").click(function(){
			$("#imgfile").click();
		  });
		  
		  $(".imgsure").click(function(){
			  var newpath = $(".uimg").attr("src");
				$("#headModal").modal("hide");
			  if(userPath != newpath){
				  updateImg(newpath);
				  document.location.reload();//当前页面 
			  }
		  });
		  
		  //上传按钮
		  $('#uploadimgsure').on('click',function(){
				uploadI++;
				if(uploadI > 1){
					console.log("大于1");
				}else{
		  		    var data = $image.cropper('getData');
		  		    console.log(data);
		  		    uploadImg(data);
				}
			});
		  
		  //编辑用户信息
		  $(".btn-edit").click(function(){
			  $("#uInfo").modal("show");
		  });
		  //编辑的确认按钮
		  $("#editSure").click(function(){
			  var name = $("input[name='name']").val();
			  var locate=$("input[name='locate']").val();
			  var sign=$("input[name='sign']").val();
			  var length = $("input[type='checkbox']:checked").length;
			  var labels = "";
			  $("input[type='checkbox']:checked").each(function(i){
				if(i == 0){
				  labels=$(this).val();
				}else{
				  labels=labels+","+$(this).val();
				}
			  });
			  $.ajax({
					type:"POST",
			        url:root+"/user/update",
			        data:{name:name,locate:locate,sign:sign,labels:labels,time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
				       	 if("success" == data.status){
				       		 document.location.reload();//当前页面 
				       	 }else if("auth" == data.status){
				       		window.location.href=root+"/toLogin";
				       	 }else{
				       		 alert(data.msg);
				       	 }
			        }
				})
		  });
		  
		  var input = document.getElementById("imgfile");
	      if (typeof (FileReader) === 'undefined') {
	          result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用现代浏览器操作！";
	          input.setAttribute('disabled', 'disabled');
	      } else {
	          input.addEventListener('change', readFile, false);
	      }
	});
	
</script>
</html>