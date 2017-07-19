<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/static/images/favicon.ico">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/checkbox.css"
	media="screen" type="text/css" />
<link href="<%=request.getContextPath()%>/static/editormd/css/editormd.css" rel="stylesheet" type="text/css" />
<title>${title }</title>
<style>
	.blog-form .row{
		padding:20px 0px; 
	}
	.blog-form .row input{
		height: 4em;
		font-weight: bold;
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
</head>
<body>
	<%@include file="../include/top.jsp"%>
	<div class="container">
		<form action="<%=root%>/article/${action}" class="blog-form" method="post">
			<%
				String token = "token_"+System.currentTimeMillis();
				session.setAttribute("token", token);
			%>
			<input type="hidden" name="token" value="<%=token%>">
			<input type="hidden" name="text" value="">
			<div class="row">
				<div class="col-md-11">
					<input type="text" class="form-control" name="title" id="title" value="${article.title }" placeholder="请输入标题">
				</div>
				<div class="col-md-1">
					<input type="submit" name="submit" id="submit" value="${btnValue }" class="btn btn-info pull-right" align="middle"/>
				</div>
			 </div>
			<div class="editormd" id="myeditormd">
		    	<textarea class="editormd-markdown-textarea" name="content" id="editormd">${article.content }</textarea>
		   		<textarea class="editormd-html-textarea" name="contenthtml" id="editorhtml"></textarea>       
		    </div>
			<h3 class="center">选择文章标签</h3>
			<div class="checkbox">
					<c:choose>
						<c:when test="${ not empty labelList}">
							<c:forEach items="${labelList }" var="label" varStatus="vs">
								<c:set var="flag" value="0"></c:set>
								<c:choose>
									<c:when test="${not empty article.labels}">
										<c:forEach items="${article.labels}" var="articlelabel"  varStatus="vvs">
											<c:if test="${articlelabel.label_id ==  label.label_id}">
												<c:set var="flag" value="1"></c:set>
											</c:if>
											
											<c:if test="${flag==1}">
												 <div class="label-checkbox">
													<h4>${label.label_name }</h4> 
													<input class='tgl tgl-flip' checked="checked" id='${label.label_id }' name="labels" value="${label.label_id }" type='checkbox'>
													<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上' for='${label.label_id }'></label>
												</div>
												<c:set var="flag" value="2"></c:set>
											</c:if>
											<c:if test="${flag == 0 }">
												<c:if test="${vvs.last }">
													<div class="label-checkbox">
													<h4>${label.label_name }</h4> 
													<input class='tgl tgl-flip' id='${label.label_id }' name="labels" value="${label.label_id }" type='checkbox'>
													<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上' for='${label.label_id }'></label>
												</div>
												</c:if>
											</c:if>
									</c:forEach>
									</c:when>
									<c:otherwise>
										<div class="label-checkbox">
												<h4>${label.label_name }</h4> 
												<input class='tgl tgl-flip' id='${label.label_id }' name="labels" value="${label.label_id }" type='checkbox'>
												<label class='tgl-btn' data-tg-off='不带' data-tg-on='带上' for='${label.label_id }'></label>
											</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
		</form>
	</div>
	<%@include file="../include/footer.jsp" %>
	<script type="text/javascript" src="<%=root%>/static/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="<%=root%>/static/editormd/editormd.js"></script>
    <script type="text/javascript">
  	  var testEditor;
  	  var root = '<%=root%>';

  	  //初始化
	  testEditor=$(function() {
	      editormd("myeditormd", {
	           width: "100%",
               height: 740,
               path : root+"/static/editormd/lib/",
               previewTheme : "dark",				//预览的主题
               //theme : "dark",					//工具栏的主题
               //editorTheme : "pastel-on-dark",	//编辑栏的主题
               //markdown : md,						//这不知道是什么东西，开启的时候报错
               //watch : true,               		// 关闭实时预览
               syncScrolling : true,				//这个看着意思是同步滑动。。。。false的时候，右边不显示了。。。。
               codeFold : true,						//代码折叠 ?   选中 然后按快捷键 Ctrl + Q,好像设置成false也可以用.....不知道，知道求告知
               saveHTMLToTextarea : true,   		// 保存 HTML 到 Textarea
               searchReplace : true,
               htmlDecode : "style,script,iframe|on*",   // 开启 HTML 标签解析，为了安全性，默认不开启    
               //toolbar  : false,             			 //关闭工具栏
               //previewCodeHighlight : false, 			 // 关闭预览 HTML 的代码块高亮，默认开启
               emoji : true,				 // 表情
               taskList : true,			 // 这个具体不知道,知道求告知
               //tocm            : true,       // Using [TOCM]
               //tex : true,                   // 开启科学公式TeX语言支持，默认关闭
               //flowChart : true,             // 开启流程图支持，默认关闭
               //sequenceDiagram : true,       // 开启时序/序列图支持，默认关闭,
               //dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
               //dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
               //dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
               //dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
               //dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff
               imageUpload : true,
               imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
               imageUploadURL : root+"/uploadImg",        	//上传地址
               onload : function() {							//加载完后执行
                   console.log('onload', this);
               }
	      });
	  });
	  
	  $(function(){
			$("#submit").click(function(){
				var length = $("input[type='checkbox']:checked").length;
				if(length == 0){
					alert("至少选择一个标签");
					return false;
				}
				if(length > 3){
					alert("最多只能选择三个标签");
					return false;
				}
				var title = $("#title").val();
				if(!title){
					$("#title").focus();
					alert("标题不能为空");
					return false;
				}
				var content = $("#editormd").val();
				if(!content){
					$("#editormd").focus();
					alert("内容不能为空");
					return false;
				}
				var contenthtml = $("#editorhtml").val();
				var result = delHTMLTag(contenthtml);
				$("input[name='text']").val(result);
				return true;
			});
		})
		
		//把html代码  变成文本，正则的意思是以 < 开头和 > 结尾的内容全部替换为空
        function delHTMLTag(htmlStr){
            htmlStr = htmlStr.replace(/<[^>]+>/g,"");
            return htmlStr;
        }
		
		//去空格，is_global  是表示是否是所有
        function Trim(str,is_global){
            var result;
            result = str.replace(/(^\s+)|(\s+$)/g,"");
            if(is_global.toLowerCase()=="g"){
                result = result.replace(/\s/g,"");
             }
            return result;
		}

</script>
</body>
</html>