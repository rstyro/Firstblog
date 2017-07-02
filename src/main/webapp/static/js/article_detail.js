var ue = UE.getEditor('article_comment', {  
			toolbars: [
					    [
					        'emotion', //表情
					        'simpleupload', //单图上传
					        'insertimage', //多图上传
					        'link',
					        'insertcode',
					    ]
					],  
		          initialFrameHeight:200,
		          autoHeightEnabled: false,
		          autoFloatEnabled: true ,
		      }); 
			ue.addListener("ready", function() {
			// editor准备好之后才可以使用
			ue.setContent("来吐槽几句...");
		});
			
