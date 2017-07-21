	
	String.prototype.trim=function(){      
    	return this.replace(/(^\s*)|(\s*$)/g, '');   
	}


	var qs = new queryStr();
	
	main_listener = function(){
		var slocation = "" + location;
		var i = slocation.indexOf("paper.do?action=detail");
		
		$.ajax({
			type: "POST",
			url: "ajax.do?action=listenToServer",
			data: {pid:qs.id ,t:rnd()},
			success: function(msg){
				var smsg = "" + msg;
				if("postpaper" == smsg.trim()){//收到交卷命令
					if(i>=0){//如果是答卷页
						alert("管理员强制收卷");
						var pid = $("form").attr("pid");
						$("form").attr("action","user/paper.do?action=postPaper&pid="+pid);
						$("form").submit();
					}
				}
			}
		}); 
		
		
	}

	//remove to userpaper.js
	//alert(-sys_communication_rate);
	//timer = setInterval("main_listener()",10*1000); 
	
	
	