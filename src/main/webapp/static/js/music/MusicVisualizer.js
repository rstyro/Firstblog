function MusicVisualizer(obj){
	this.source = null;
	var infoUpdateId = null;
	this.count = 0;
	this.fileName = null;
	this.analyser = MusicVisualizer.ac.createAnalyser();
	this.size = obj.size;
	//this.analyser.fftSize = 512;
	this.gainNode = MusicVisualizer.ac[MusicVisualizer.ac.createGain?"createGain":"createGainNode"]();
	this.gainNode.connect(MusicVisualizer.ac.destination);
	this.analyser.connect(this.gainNode);
	this.xhr = new XMLHttpRequest();
	
	this.visualizer = obj.visualizer;
	this.visualize();
}
window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext || window.msAudioContext;
try {
    MusicVisualizer.ac = new AudioContext();
} catch (e) {
	MusicVisualizer.updateInfo('你的浏览器不支持AudioContext，可换 谷歌、火狐、360,亲测有效', false);
    console.log(e);
}

MusicVisualizer.prototype.load = function(url,fun){
	this.xhr.abort();//之前的请求，中断
	this.xhr.open("GET", url);
	this.xhr.responseType="arraybuffer";
	var self = this;
	this.xhr.onload = function(){
		fun(self.xhr.response)
	}
	this.xhr.send();
}
MusicVisualizer.prototype.decode = function(arraybuffer,fun){
	MusicVisualizer.ac.decodeAudioData(arraybuffer,function(buffer){
		fun(buffer);
	},function(err){
		MusicVisualizer.ac.updateInfo('文件读取失败', false);
		consoe.log("解码失败");
	})
}

MusicVisualizer.prototype.play = function(url){
	var n = ++this.count;
	var self = this;
	//停止当前正在播放的bufferSource
	this.source && this.stop();
	self.updateInfo('正在请求', true);
	this.load(url,function(arraybuffer){
		if(n != self.count && self.count > 1)return;
		self.updateInfo("正在解析",true);
		self.decode(arraybuffer,function(buffer){
			if(n != self.count && self.count > 1)return;
			self.updateInfo('Starting read the file', true);
			var bs = MusicVisualizer.ac.createBufferSource();
			bs.connect(self.analyser);
			bs.buffer = buffer;
			//console.log(buffer);
			bs[bs.start?"start":"noteOn"](0);
			self.source = bs;
			self.count=0;
			self.updateInfo('正在播放:'+self.fileName, false);
		})
	});
}


MusicVisualizer.prototype.playMusic = function(buffer){
	var n = ++this.count;
	var self = this;
	if(n != self.count && self.count > 1)return;
    var absn = MusicVisualizer.ac.createBufferSource();
    absn.connect(self.analyser);
    absn.buffer = buffer;
    absn[absn.start?"start":"noteOn"](0);
    self.source = absn;
    self.updateInfo('正在播放:'+self.fileName, false);
    self.count = 0;
}

MusicVisualizer.prototype.stop=function(){
	var that = this;
	if(that.source != null){
		that.source[that.source.stop?"stop":"noteOff"]();
		that.count=0;
		that.updateInfo("",false);
	}
}

MusicVisualizer.prototype.changeVolume = function(percent){
	this.gainNode.gain.value = percent*percent;
}

MusicVisualizer.prototype.updateInfo = function(text,processing){
	var infoElement =  document.getElementById('info'),
    	dots = '...',
    	i = 0,
    	that = this;
    infoElement.innerHTML = text + dots.substring(0, i++);
	 if (this.infoUpdateId !== null) {
	     clearTimeout(this.infoUpdateId);
	 };
	 if (processing) {
	     //animate dots at the end of the info text
	     var animateDot = function() {
	         if (i > 3) {
	             i = 0
	         };
	         infoElement.innerHTML = text + dots.substring(0, i++);
	         that.infoUpdateId = setTimeout(animateDot, 250);
	     }
	     this.infoUpdateId = setTimeout(animateDot, 250);
	 };
}

/*动画*/
MusicVisualizer.prototype.visualize = function(){
	var arr = new Uint8Array(this.analyser.frequencyBinCount);
    var requestAnimationFrame =  window.requestAnimationFrame || 
    							  window.webkitRequestAnimationFrame ||
    							  window.mozRequestAnimationFrame || 
    							  window.oRequestAnimationFrame || 
    							  window.msRequestAnimationFrame;
    var self = this;
    function view(){
        self.analyser.getByteFrequencyData(arr);
        self.visualizer(arr);
        requestAnimationFrame(view);
    }
    requestAnimationFrame(view);
}



