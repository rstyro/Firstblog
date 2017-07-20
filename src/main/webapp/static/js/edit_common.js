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
	
	//把html代码  变成文本，正则的意思是以 < 开头和 > 结尾的内容全部替换为空
    function delHTMLTag(htmlStr){
        htmlStr = htmlStr.replace(/<[^>]+>/g,"");
        return htmlStr;
    }
	
	//去空格，is_global  是表示是否是所有
    function Trim(str,is_global){
        var result;
        result = str.replace(/(^\s+)|(\s+$)/g,"");
        if(is_global.toLowerCase()=="g"){
            result = result.replace(/\s/g,"");
         }
        return result;
	}