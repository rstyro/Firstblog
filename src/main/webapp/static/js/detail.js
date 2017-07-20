$(document).ready(function() {
    var wordsView;
    wordsView = editormd.markdownToHTML("codeView", {
    	htmlDecode      : false,
    	emoji           : true,
        taskList        : true,
        previewTheme: "dark",//预览主题
    });
})		

$(function(){
			
			$('.emoji').qqFace({
				id : 'facebox', 
				assign:'article_comment', 
				path:emojiPath	//表情存放的路径
			});

		    
		    $(".article-detail-title").click(function(){
		    	if($("#codeView").hasClass("editormd-preview-theme-dark")){
		    		$("#codeView").removeClass("editormd-preview-theme-dark")
		    	}else{
		    		$("#codeView").addClass("editormd-preview-theme-dark")
		    	}
		    });
			
			//评论
	    	$("#blog_comment").click(function(){
	    		var content = $("#article_comment").val();
	    		content = replace_em(content);
	    		$.ajax({
	    			type:"POST",
	    	        url:root+"/public/comment",
	    	        data:{table_id:articleId,reply_user_id:authorUserId,content:content,praent_id:"",time:new Date().getTime()},
	    	        dataType:"json",
	    	        cache:false,
	    	        success: function(data){
	    	       	 if("success" == data.status){
	    	       		$("#commentModal").modal('show');
	    	       		addcomment(data.data,$("#comment-body"));
	    	       		task = setInterval("commentTask()",500);
	    	       		$("#article_comment").val("");
	    	       	 }else if("auth" == data.status){
	    	       		window.location.href=root+"/toLogin";
	    	       	 }else{
	    	       		 alert(data.msg);
	    	       	 }
	    	        }
	    		})
	    	});
		})
		
