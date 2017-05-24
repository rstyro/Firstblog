<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FromData Demo</title>

<style type="text/css" >
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
    </style>
</head>
<body>
<form action="http://192.168.1.83/gdinterface/app/topic/saveTopic" id="testForm" method="post">
	<a href="javascript:;" class="file">请选择文件<input type="file" name="img" id="fielinput" ></a><br>
	<input type="text" name="key" value="dZvi88r7reCAJQET"/><br>
	<input type="text" name="title" value="测试网页标题"/><br>
	<input type="text" name="content" value="帖子的内容！！！！"/><br>
	<input type="submit" name="submit" value="提交">
</form>


<script src="<%=request.getContextPath()%>/static/jquery/1.12.4/jquery.min.js"></script>
<script>
    window.onload = function () {
        var input = document.getElementById("fielinput");
        if (typeof (FileReader) === 'undefined') {
            result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用现代浏览器操作！";
            input.setAttribute('disabled', 'disabled');
        } else {
            input.addEventListener('change', readFile, false);
            //txshow.onclick = function () { input.click(); }
        }
		
        $("input[name='submit']").click(function(){
        	var data = [];
        	for(var i=1;i <= index;i++){
    			var text = $("input[name='file"+i+"']").val();
	        	data.push(text);
        	}
        	var key = $("input[name='key']").val();
            var title=$("input[name='title']").val();
            var content=$("input[name='title']").val();

        	$.ajax({
				type:"POST",
		        url:"http://192.168.1.83/gdinterface/app/topic/saveTopic",
		        data:{topic_pic:JSON.stringify(data),key:key,title:title,content:content,time:new Date().getTime()},
		        dataType:"jsonp",
		        cache:false,
		        success: function(data){
		       		console.log(data);
		        }
			})
        	return false;
        });

    }
     var index=0;
    function readFile() {
        var file = this.files[0];
        //判断是否是图片类型
        if (!/image\/\w+/.test(file.type)) {
            alert("只能选择图片");
            return false;
        }
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {
        	//txshow.src = this.result;
        	//alert(this.result);
        	++index;
        	$("#testForm").prepend("<img class='txshow' src='"+this.result+"' style='width:100px;height:100px;'/>"
        				+"<input type='hidden' name='file"+index+"' value='"+this.result+"'/><br>");
        }

    
    }

</script>
</body>
</html>