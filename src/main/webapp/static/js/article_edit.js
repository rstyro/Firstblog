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
	
