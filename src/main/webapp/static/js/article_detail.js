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
$(function(){
	//评论
	$("#blog_comment").click(function(){
		$.ajax({
			type:"POST",
	        url:root+"/public/comment",
	        data:{table_id:articleId,reply_user_id:authorUserId,content:ue.getContent(),praent_id:"",time:new Date().getTime()},
	        dataType:"json",
	        cache:false,
	        success: function(data){
	       	 if("success" == data.status){
	       		$("#commentModal").modal('show');
	       		addcomment(data.data,$("#comment-body"));
	       		task = setInterval("commentTask()",500);
	       		ue.setContent("");
	       	 }else if("auth" == data.status){
	       		window.location.href=root+"/toLogin";
	       	 }else{
	       		 alert(data.msg);
	       	 }
	        }
		})
	});
	
})
