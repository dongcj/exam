	
	//获取对象
	$get = function(){
		var elements = new Array();
	  	for (var i = 0; i < arguments.length; i++) {
			var element = arguments[i];
			if (typeof element == 'string')
		  		element = document.getElementById(element);
			if (arguments.length == 1)
		  		return element;
			elements.push(element);
	  	}
	  	return elements;
	};


	//设置Cookie
	function setCookie(name, value){
		var argv = setCookie.arguments;
		var argc = setCookie.arguments.length;
		var expires = (argc > 2) ? argv[2] : null;
		if(expires!=null){
			var LargeExpDate = new Date ();
			LargeExpDate.setTime(LargeExpDate.getTime() + (expires*1000*3600*24));
		}
		document.cookie = name + "=" + escape (value)+((expires == null) ? "" : ("; expires=" +LargeExpDate.toGMTString()));
	}
	
	//获取Cookie
	function getCookie(Name){
		var search = Name + "=";
		if(document.cookie.length > 0) {
			offset = document.cookie.indexOf(search);
			if(offset != -1) {
				offset += search.length;
				end = document.cookie.indexOf(";", offset);
				if(end == -1) end = document.cookie.length;
				return unescape(document.cookie.substring(offset, end));
			}
			else 
				return "";
		}
	}

	
	//随机数
	function rnd(){
		return (new Date()).valueOf();
	}
	
	
	//配置当前应用路径
	function BasePath(act){
		return "ajax.do?action=" + act;
	}
	
	
	//数字判断
	function checkNumber(v){
		var pattern = /^[1-9][0-9]*$/;
		return v.match(pattern);
	}
	
	
	//查询字符串获取
	function queryStr(){
		var query = location.search.substring(1);
		var result = new Array();
		if(query){
			var arQuery = query.split("&");
			for(var i=0;i<arQuery.length;i++){
				var pos = arQuery[i].indexOf("=");
				var qName = arQuery[i].substring(0,pos);
				var qValue = arQuery[i].substring(pos+1);
				result[qName] = qValue;
			}
		}
		return result;
	}
	
	
	//打开窗口
	showWindow = function(url,w,h){
		var ret = window.showModalDialog(url,'ewin','dialogWidth='+w+'px;dialogHeight='+h+'px;top:0px');
		if(ret=="ok"){
			window.location.reload();
		}
	};
	
	//跳转
	gourl = function(url){
		window.location.href = url;
	};
	
	
	qTypeName = function(qtype){
		if("1"==qtype || 1==qtype){
			return "单选";
		}else if("2"==qtype || 2==qtype){
			return "多选";
		}else if("3"==qtype || 3==qtype){
			return "判断";
		}else if("4"==qtype || 4==qtype){
			return "填空";
		}else if("5"==qtype || 5==qtype){
			return "问答";
		}else{
			return "未知";
		}
		
	};
	
	
	function selcheck(obj) {
  		var objs = document.getElementsByTagName("input");
  		for(var i=0; i<objs.length; i++) {
    		if(objs[i].type.toLowerCase() == "checkbox" ){
				if(objs[i].id != obj)
				objs[i].checked = $get(obj).checked;
			}
  		}
	}

	
	
	//批量改变样式
	var style_id = getCookie("styleid");
//	if(style_id = "undefined"){
//		style_id = "";
//	}
	var css_link = document.getElementsByTagName("link");	//得到一个link的object list;
	for(var i=0; i<css_link.length; i++){
		var the_link = "" + css_link[i].href;				// 得到link地址，如http://localhost:8080/exam/skins/default/style.css
//		alert(style_id);
		if(style_id != ""){
			css_link[i].href = the_link.replace("default",style_id);
		} 
	}
	
	
	
	