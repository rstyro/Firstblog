 $(function(){
	 $(".navbar-nav li:eq(1)").addClass("top-active");
	 beiginMusice();
	  $(".musicList li").click(function(){
	        var musicName = $(this).text();
	        $(".musicList li").removeClass("music-active");
	        $(this).addClass("music-active");
	        var rootpath = getRootPath();
	        mv.fileName = musicName;
	        mv.play(rootpath+"music/"+decodeUTF8(musicName)+".mp3");
	    });
	  $("#changeType").click(function(){
		  if(draw.type == "column"){
			  draw.type="dots";
		  }
		  /*else if(draw.type=="dots"){
			  draw.type="waveform";
		  }*/
		  else{
			  draw.type="column";
		  }
	  });
	  
	    $("#volume").change(function(){
	        var value = $(this).val();
	        var max = $(this).attr("max");
	        mv.changeVolume(value/max);
	        $("#volumetext").text(value)
	    });
	    $("#mstop").click(function(){
	    	mv.stop();
	    });
	    $("#cas").click(function(){
	    	stopAnimate();
	    });
	    
	    $("#btn-local").click(function(){
			$("#localmusic").click();
		});
	    
	    $("#localmusic").change(function(){
	    	$(".musicList li").removeClass("active");
//			mv.stop();
			var file = document.getElementById("localmusic").files[0];
			var fileName = file.name;
			mv.fileName = fileName;
			var fr = new FileReader();
            fr.onload = function(e){
            	mv.updateInfo(fileName+' 正在解析', true);
                var fileResult = e.target.result;
                if(mv.count > 0)return;
                mv.decode(fileResult , function(buffer){
                	if(mv.count > 0)return;
                	mv.updateInfo('开始读文件', true);
                	mv.stop();
                    mv.playMusic(buffer)
                }, function(e){
                	mv.updateInfo('文件读取失败', false);
                    console.log(e)
                    alert('文件解码失败')
                })
            }
            fr.readAsArrayBuffer(file);
	    });
	    
	    $(".blog-wall").mouseover( function() {
	          $(this).stop(true).animate({left:0},"slow");
	     }).mouseout( function(){
	    	 $(this).stop(true).animate({left:'-187px'},"slow");
	     });
  })
  		var width,height;
		var dots_width,dots_height;
        var canvas = document.getElementById('cas'),ctx=canvas.getContext('2d');
      
        var size = 64;
        var dots = [];
        var line;
        draw.type="dots";
        dots_move = "move";
        var mv = new MusicVisualizer({
        	size:size,
        	visualizer:draw
        });
        
        //播放音乐
        function beiginMusice(){
        	var thisLi = $(".musicList li").eq(0);
        	var musicName = $(thisLi).text();
	        $(".musicList li").removeClass("music-active");
	        $(thisLi).addClass("music-active");
	        var rootpath = getRootPath();
	        mv.fileName = musicName;
	        mv.play(rootpath+"music/"+decodeUTF8(musicName)+".mp3");
        }
        
        function stopAnimate(){
        	if(draw.type=="dots"){
        		for(var i=0;i<size;i++){
        			dots_move == "move"?dots[i].dx=0:dots[i].dx = dots[i].dx2;
        		}
        		dots_move = dots_move == "move"?"static":"move";
        	}
        }
        
        function random(m,n){
        	return Math.round(Math.random()*(n-m)+m);
        }
        function getDots(){
        	for(var i=0;i<size;i++){
        		var x = random(0,width);
        		var y = random(0,height);
        		var color="rgba("+random(0,255)+","+random(0,255)+","+random(0,255)+",0.3)";
        		dots.push({
        			x:x,
        			dx:random(1,4),
        			dx2:random(1,4),
        			y:y,
        			color:color,
        			cap:0
        		});
        	}
        }
        
        //窗口改变的时候调用
        function resize(){
        	width = window.document.getElementById('myCanvas').offsetWidth;
        	height = window.document.getElementById('myCanvas').offsetHeight;
        	canvas.width = width;
        	canvas.height = height;
        	
        	line = ctx.createLinearGradient(0,0,0,height);//渐变线
        	line.addColorStop(0,"red");
        	line.addColorStop(0.5,"yellow");
        	line.addColorStop(1,"green");
        	getDots();
        }
        resize()
        window.onresize=resize;
        
		function draw(arr){
			ctx.clearRect(0,0,width,height);//清屏
			var w = width / size;//宽度=总宽/个数
			var cw = w*0.8;
			var capH = cw > 2?2:cw;
			//ctx.fillStyle=line;
			var step = Math.round(arr.length / size);//计算从analyser中的采样步长
		    for(var i=size-1;i>=0;i--){
		    	var o = dots[i];
		    	if(draw.type=="column"){
		    		var h = arr[i*step] / 256 * height;//最大值为256* 总高度
		    		ctx.fillStyle=line;
		    		ctx.fillRect(w*i,height-h,cw,h);//0.4为间隙
		    		//ctx.fillStyle="pink";
		    		ctx.fillRect(w*i,height-(o.cap+capH),cw,capH);//0.4为间隙
		    		o.cap--;
		    		if(o.cap < 0){
		    			o.cap=0;
		    		}
		    		if(h> 0 && o.cap < h +20){
		    			o.cap = h+20 > height-capH ? height-capH:h+20;
		    		}
		    	}else if(draw.type=="dots"){
		    		//下面是圆
		    		if(i%3 == 0){//过滤一些圆，太多了不好
		    			ctx.beginPath();
		    			var r =10 + arr[i*step] / 256 * width / 10;//最少10
		    			ctx.arc(o.x,o.y,r,0,Math.PI*2,true);
		    			var g = ctx.createRadialGradient(o.x,o.y,0,o.x,o.y,r);
		    			g.addColorStop(0,"#fff");
		    			g.addColorStop(1,o.color);
		    			ctx.fillStyle=g;
		    			ctx.fill();
		    			o.x += o.dx;
		    			o.x = o.x > width?0:o.x;
		    		}
		    	}else{
		    		if(i%2 == 0){//过滤
					var midH = height/2;
		    		var energy = (arr[step * i] / 256.0) * 30;
		    		/* 指定渐变区域 */
		    		  var grad  = ctx.createLinearGradient(0,0, 0,height-100);
		    		  /* 指定几个颜色 */
		    		  grad.addColorStop(0,'green');    // 红
		    		  grad.addColorStop(0.5,'red'); // 绿
		    		  grad.addColorStop(0.6,'yellow');    // 红
		    		  grad.addColorStop(0.7,'green');  // 紫
		    		  grad.addColorStop(0.8,'green');  // 紫
		    		  grad.addColorStop(0.9,'red');  // 紫
		    		  grad.addColorStop(1,'green');  // 紫
		    		  ctx.strokeStyle = grad;
		    		  ctx.lineWidth = 2;
		            for (var j = 0; j < energy; j++) {
		                ctx.beginPath();
		                ctx.moveTo(w * i + 2, midH + 4 * j);
		                ctx.lineTo(w * (i + 1) - 2, midH + 4 * j);
		                ctx.stroke();
		                ctx.beginPath();
		                ctx.moveTo(w * i + 2, midH - 4 * j);
		                ctx.lineTo(w * (i + 1) - 2, midH - 4 * j);
		                ctx.stroke();
		            }
		            ctx.beginPath();
		            ctx.moveTo(w * i + 2, midH);
		            ctx.lineTo(w * (i + 1) - 2, midH);
		            ctx.stroke();
		    	}
		    	}
		    }
		    
		}
        
        function getRootPath() {
            var pathName = window.location.pathname.substring(1);
            var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/'));
            //return window.location.protocol + '//' + window.location.host + '/'+ webName + '/';
            return window.location.protocol + '//' + window.location.host + '/';
          }
        
        //判断是否是pc端
        function IsPC()  
        {  
           var userAgentInfo = navigator.userAgent;  
           var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod");  
           var flag = true;  
           for (var v = 0; v < Agents.length; v++) {  
               if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }  
           }  
           return flag;  
        }
        
        function encodeUTF8(str){
            var temp = "",rs = "";
            for( var i=0 , len = str.length; i < len; i++ ){
                temp = str.charCodeAt(i).toString(16);
                rs  += "\\u"+ new Array(5-temp.length).join("0") + temp;
            }
            return rs;
         }
         function decodeUTF8(str){
            return str.replace(/(\\u)(\w{4}|\w{2})/gi, function($0,$1,$2){
                return String.fromCharCode(parseInt($2,16));
            }); 
         } 