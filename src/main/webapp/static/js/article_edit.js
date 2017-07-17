var wh = document.documentElement.clientHeight;
var text = $("#text").html();
	var ue = UE.getEditor('article_content', {  
		toolbars: [
				    [
				        'bold', //加粗
				        'insertcode', //代码语言
				        'fontsize', //字号
				        'simpleupload', //单图上传
				        'insertimage', //多图上传
				        'emotion', //表情
				        'link',//链接
				        'justifyleft', //居左对齐
				        'justifyright', //居右对齐
				        'justifycenter', //居中对齐
				        'justifyjustify', //两端对齐
				    ]
				],  
	          initialFrameHeight:wh-200,
	          autoHeightEnabled: false,
	          autoFloatEnabled: true ,
	      }); 
	
	ue.addListener("ready", function() {
		// editor准备好之后才可以使用
		ue.setContent(text);
		//ue.execCommand( 'inserthtml', text);
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
			var content = ue.getContent();
			if(!content){
				alert("文章内容不能为空");
				return false;
			}
			$(":input[name='text']").val(ue.getContentTxt());
			return true;
		});
	})