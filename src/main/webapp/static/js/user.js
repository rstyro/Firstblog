
	function imgerror(img){
		$(img).attr("src","/upload/user/404.png");
	}

	function uploadImg(obj){
		var x=obj.x;
	    var y=obj.y;
	    var width=obj.width;
	    var height=obj.height;
	    var rotate=obj.rotate;
	    $.ajax({
	    	type:"POST",
	    	url:root+"/user/uploadImg",
	    	data:{x:x,y:y,width:width,height:height,rotate:rotate,base64code:base64Code,time:new Date().getTime()},
	    	dataType:"json",
	    	cache:false,
	    	success:function(data){
	    		console.log(data);
	    		$("#uploadModal").modal("hide");
	    		$(".uimg").attr("src",data.data);
	    		uploadI=0;
	    	}
	    });
	}

	function updateImg(img){
		$.ajax({
			type:"POST",
	        url:root+"/user/update",
	        data:{img:img,time:new Date().getTime()},
	        dataType:"json",
	        cache:false,
	        success: function(data){
		       	 if("success" == data.status){
		       		 document.location.reload();//当前页面 
		       	 }else if("auth" == data.status){
		       		window.location.href=root+"/toLogin";
		       	 }else{
		       		 alert(data.msg);
		       	 }
	        }
		})

	}
	
	var $image = $('#uCropImg');
	/* 初始化配置 */
	$image.cropper({
			background:false,
			guides:false,
		    movable: true,
	        resizable: false,
	        zoomable: true,
	        rotatable: false,
	        scalable: false,
	        dashed:false,
	        dragCrop:false,
	        autoCropArea:0.9,
	        aspectRatio: 1 / 1,
	        preview: '.img-preview',
	});
	var uploadI=0;
	var base64Code;
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
        	base64Code=this.result;
        	$("#uploadModal").modal("show");
        	$("#uCropImg").attr("src",this.result);
        	$image.cropper("reset", true).cropper("replace", this.result).css("width","500px");
        }
    }