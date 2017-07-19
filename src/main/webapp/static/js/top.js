$(function(){
			$(window).scroll(function(){
				var wh = $(document.body).height();
				var sroh = $(document).scrollTop();
				if(sroh > (wh/2)){
					$(".toTop").show();
				}else{
					$(".toTop").hide();
				}
			});
			
			 $('.list-group li').each(function() {
	                $(this).click(function() {
	                    location.href = troot+"/article/month/"+ $(this).attr('id') + "/1";
								})
			})
			$("#blog_search").click(function(){
				$("#searchform").submit();
			});
			 
			$(".btn-concern").click(function(){
				var uid = $(this).attr("uid");
				var El = $(this);
				concern(uid,El);
			});
			$(".btn-letter").click(function(){
				uid = $(this).attr("uid");
				uname = $(this).attr("uname");
				$("#modelHead").html("给用户 <strong>"+uname+"</strong> 写信");
				$("#letterModal").modal('show');
			});
			$(".sendLetter").click(function(){
				var content = $("#letter-content").val();
				sendLetter(uid,uname,content);
				$("#letter-content").val('');
				$("#letterModal").modal('hide');
			});
		})
		
		function sendLetter(uid,uname,content){
			$.ajax({
				type:"POST",
		        url:troot+"/public/letter",
		        data:{wrt_user_id:uid,content:content,time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
			       	 if("auth" == data.status){
			       		window.location.href=troot+"/toLogin";
			       	 }else{
		       		 	alert(data.msg);
		        	}
		        }
			})
		}
		
		function logout(){
			$.ajax({
				type:"GET",
		        url:troot+"/user/logout",
		        data:{time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		       	 if("success" == data.status){
		       		location.reload();
		       	 }else{
		       		 $("#msg").html(data.msg);
		       	 }
		        }
			})
		}
		function concern(userId,El){
			$.ajax({
				type:"POST",
		        url:troot+"/public/concern",
		        data:{beconcern_user_id:userId,time:new Date().getTime()},
		        dataType:"json",
		        cache:false,
		        success: function(data){
		        	console.log(data);
		       	 if("success" == data.status){
		       		if(El.hasClass("btn-default-concern")){
		       			El.html("<span class='glyphicon glyphicon-plus'></span><span> 关注</span>");
		       			El.removeClass("btn-default-concern");
		       			El.addClass("btn-info");
					}else{
						El.html("<span>已关注</span>");
						El.addClass("btn-default-concern");
						El.removeClass("btn-info");
					}
		       	 }else if("auth" == data.status){
		       		window.location.href=troot+"/toLogin";
							} else {
								$("#msg").html(data.msg);
							}
						}
					})
		}