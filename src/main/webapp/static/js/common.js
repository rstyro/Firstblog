$(function(){
	$("input").change(function(){
		$("#msg").html("");
	});
	
	$("#blog-hide").click(function(){
		var text = $("input[name='openpassword']").val();
	 	$("input[name='password']").val(text);
	 	$("#p-open-input").addClass("blog-hide");
	 	$("#p-close-input").removeClass("blog-hide");
	});
	
	$("#blog-show").click(function(){
		var text = $("input[name='password']").val();
	 	$("input[name='openpassword']").val(text);
	 	$("#p-close-input").addClass("blog-hide");
	 	$("#p-open-input").removeClass("blog-hide");
	});
	
	
})

function checkLogin(){
	if($("input[name='username']").val() == ""){
		alert("username cannot be empty")
		$("input[name='username']").focus();
		return false;
	}
	if($("input[name='password']").val() == ""){
		alert("password cannot be empty")
		$("input[name='password']").focus();
		return false;
	}
	return true;
}

function checkRegister(){
	if($("input[name='username']").val() == ""){
		$("#msg").html("username cannot be empty");
		$("input[name='username']").focus();
		return false;
	}
	if($("input[name='password']").val() == ""){
		$("#msg").html("password cannot be empty");
		$("input[name='password']").focus();
		return false;
	}
	var email = $("input[name='email']").val();
	if(email == ""){
		$("#msg").html("email cannot be empty");
		$("input[name='email']").focus();
		return false;
	}
	if(!checkEmail(email)){
		$("#msg").html("邮箱不合法");
		$("input[name='email']").focus();
		return false;
	}
	return true;
}

function checkReset(){
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
	if($("input[name='password']").val() == ""){
		$("input[name='password']").val($("input[name='openpassword']").val());
	}
	
	if($("input[name='password']").val() == ""){
		$("#msg").html("密码不能为空");
		$("input[name='password']").focus();
		return false;
	}
	if($("input[name='code']").val() == ""){
		$("#msg").html("验证码不能为空");
		$("input[name='code']").focus();
		return false;
	}
	return true;
}

function checkEmail(email){
		var reg= /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if(reg.test(email)){
			return true;
		}else{
			return false;
		}
	}


