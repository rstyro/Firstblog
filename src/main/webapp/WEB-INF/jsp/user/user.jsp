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
	<link href="<%=root %>/static/css/cropper.min.css" rel="stylesheet">
</head>
<%
	int meId=Integer.parseInt(user_id);
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
.blog-user div.modify{
	position: absolute;
	width: 100%;
	height:30%;
	left: 0;
	text-align:center;
	background-color:#000;
	color:#fff;
	opacity:0.8;
	bottom: -30%;
}
.blog-user div.modify a{
	color:#fff;
	font-size: 0.9em;
	text-decoration: none;
}

#myTab>li.active>a, #myTab>li.active>a:hover, #myTab>li.active>a:focus {
	background-color: #e2e2e2;
	font-weight: bold;
	color: #111;
}
#dynamic{
	padding: 1em;
}
#headModal .modal-content .modal-body img{
	width:100%;
	border-radius: 50%;
}
#headModal .modal-content .modal-body .row div div{
	text-align: center;
	padding-top: 1em;
}
#headModal .modal-content .modal-body .row div input[name='imgfile']{
	display: none;
}
#headModal .modal-content .modal-body .row div div a{
	text-decoration: none;
}
#headModal .modal-content .modal-header{
	border-bottom: 0px;
}

#uploadModal .cropBg{
	width: 500px;
	height: 500px;
}
#uploadModal .cropBg img{
	height: 100%;
}
</style>
<body>
	<script src="<%=root%>/static/js/cropper.min.js"></script>
	<script src="<%=root%>/static/js/bootstrap-paginator.js"></script>

	<div class="container">
		<div class="row blog-user">
			<div class="col-sm-2 col-md-2">
				<div class="uh">
					<img alt="用户头像" src="${userInfo.img}">
					<c:if test="${userInfo['user_id'] eq user_id}">
						<div class="modify">
							<p><a href="javascript:void(0);">更换头像</a></p>
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
				<p>${userInfo.sign }</p>
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
						 class="btn btn-default-concern btn-concern">
							<span>已关注</span>
						</a>
					</c:if>
					<c:if test="${concern.concern_flag == '0' }">
						<a href="javascript:void(0)" uid="${userInfo.user_id }" 
						 class="btn btn-info btn-concern">
							<span class="glyphicon glyphicon-plus"></span><span> 关注</span>
						</a>
					</c:if>
					<a href="javascript:void(0);" uid="${userInfo.user_id }" uname="${userInfo.name }"
						class="btn btn-info btn-letter"><span><i
							class="glyphicon glyphicon-envelope"></i> 私信</span></a>
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
						<p>
							这个冬天不太冷 发布了文章<a href="#">《linux 操作系统》</a>
						</p>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="comment">
				<div class="row">
					<p>
						最近评论了<a href="javascript:void(0);">《Linux 入门到精通》</a>
					</p>
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
								<div class="col-md-4 col-md-offset-1"><a href="javascript:void(0);" class="changeUI">换一换</a></div>
								<div class="col-md-4 col-md-offset-2"><a href="javascript:void(0);" class="uploadUI">上传头像</a></div>
								<input type="file" name="imgfile" id="imgfile" />
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="margin: 0px auto; width: 25%;">
					<button type="button" class="btn btn-info imgsure" >确定</button>
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
					<div class="cropBg"><img src="" id="uCropImg"></div>
					<div class="docs-preview clearfix">
					  <div class="img-preview preview-lg"></div>
					  <div class="img-preview preview-md"></div>
					  <div class="img-preview preview-sm"></div>
					  <div class="img-preview preview-xs"></div>
					</div>
				</div>
				<div class="modal-footer" style="margin: 0px auto; width: 25%;">
					<button type="button" class="btn btn-info" id="uploadimgsure" >上传</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>
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
	          location.href = "<%=right_root%>/user/"+${userInfo.user_id}+"/" + page;
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
	  $(".modify a").click(function(){
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
	  
	  var input = document.getElementById("imgfile");
      if (typeof (FileReader) === 'undefined') {
          result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用现代浏览器操作！";
          input.setAttribute('disabled', 'disabled');
      } else {
          input.addEventListener('change', readFile, false);
      }
});

	function uploadImg(obj){
		var x=obj.x;
	    var y=obj.y;
	    var width=obj.width;
	    var height=obj.height;
	    var rotate=obj.rotate;
	    $.ajax({
	    	type:"POST",
	    	url:root+"/user/uploadImg",
	    	data:{x:x,y:y,width:width,height:height,rotate:rotate,base64code:base64Code,time:new Date().getTime()},
	    	dataType:"json",
	    	cache:false,
	    	success:function(data){
	    		console.log(data);
	    		$("#uploadModal").modal("hide");
	    		$(".uimg").attr("src",data.data);
	    		uploadI=0;
	    	}
	    });
	}

	function updateImg(img){
		$.ajax({
			type:"POST",
	        url:root+"/user/update",
	        data:{img:img,time:new Date().getTime()},
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

	}
	
	var $image = $('#uCropImg');
	/* 初始化配置 */
	$image.cropper({
			background:false,
			guides:false,
		    movable: true,
	        resizable: false,
	        zoomable: true,
	        rotatable: false,
	        scalable: false,
	        dashed:false,
	        dragCrop:false,
	        autoCropArea:0.9,
	        aspectRatio: 1 / 1,
	        preview: '.img-preview',
	});
	var uploadI=0;
	var base64Code;
	function readFile() {
		 var file = this.files[0];
        //判断是否是图片类型
        if (!/image\/\w+/.test(file.type)) {
            alert("只能选择图片");
            return false;
       }
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {
        	base64Code=this.result;
        	$("#uploadModal").modal("show");
        	$("#uCropImg").attr("src",this.result);
        	$image.cropper("reset", true).cropper("replace", this.result).css("width","500px");
        }

    
    }

</script>
</html>