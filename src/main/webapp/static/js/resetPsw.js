$(function(){
		$(":input[name='submit']").click(function(){
			if(checkReset()){
				$.ajax({
					type:"POST",
			        url:resetRoot+"/user/resetPsw",
			        data:{password:$("input[name='password']").val(),email:$("input[name='email']").val(),code:$("input[name='code']").val(),time:new Date().getTime()},
			        dataType:"json",
			        cache:false,
			        success: function(data){
			       	 if("success" == data.status){
			       		var islogin= confirm("您的密码重置成功是否跳转登录页面?");
			       		if(islogin){
			       			 window.location.href=resetRoot+"/toLogin";
			       		}else{
			       			 window.location.href="toIndex/1";
			       		}
			       	 }else{
			       		 $("#msg").html(data.msg);
			       	 }
			        }
				})
			}
			return false;
		});
		
		$("#sendcode").click(function(){
			var email= $("input[name='email']").val();
			if(email == ""){
				$("#msg").html("邮箱不能为空");
				$("input[name='email']").focus();
				return false;
			}
			if(!checkEmail(email)){
				$("#msg").html("邮箱不合法");
				$("input[name='email']").focus();
				return false;
			}
			$("#sendcode").css("background","#ccc");
			code_index++;
			if(code_index < 2){
				code_task = setInterval("changeText()",1000);
				sendCode();
			}else{
				return false;
			}
		});
		
	})
	var code_index = 0;
	var code_time = 60;
	var code_task;
	
	function changeText(){
		code_time--;
		var el = $("#sendcode");
		var content = " s 后重试";
		var text = code_time + content;
		el.text(text);
		if(code_time <= 0){
			clearInterval(code_task);
			el.css("background","#52cfeb");
			el.text("发送验证码");
			code_time=60;
			code_index=0;
		}
	}
	
	function sendCode(){
		$.ajax({
			type:"POST",
	        url:resetRoot+"/user/sendCode",
	        data:{email:$("input[name='email']").val(),time:new Date().getTime()},
	        dataType:"json",
	        cache:false,
	        success: function(data){
	       	 if("success" == data.status){
	       		alert("验证码已发到您的邮箱，请尽快查收。");
	       	 }else{
	       		 $("#msg").html(data.msg);
	       		clearInterval(code_task);
	       		$("#sendcode").css("background","#52cfeb");
	       		$("#sendcode").text("发送验证码");
				code_time=60;
				code_index=0;
	       	 }
	        }
		})
	}