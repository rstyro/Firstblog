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
				        'horizontal', //分隔线
				        'inserttable', //插入表格
				        'insertparagraphbeforetable', //"表格前插入行"
				        'mergecells', //合并多个单元格
				        'deletetable', //删除表格
				        'deleterow', //删除行
				        'deletecol', //删除列
				        'forecolor', //字体颜色
				        'backcolor', //背景色
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
	
