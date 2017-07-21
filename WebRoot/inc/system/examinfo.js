	
	//页面加载
	$(function(){
		
		//追加设置按钮
		$(".qks").each(function(){
			var qtype = $(this).attr("qtype");
			var qscore = $(this).attr("qscore");
			var did = $(this).attr("did");
			
			//if(1==qtype || "1"==qtype){
				var html = '';
				html += '<a href="javascript:;" style="color:#f00" onmouseover="buildSetter('+qscore+',this,'+did+');">设置得分</a>';
				$(this).append("<br/>" + html);
			//}
			
		});
		
		
		//隐藏小操作面板
		$(".body").click(function(){
			$("#divsetter").hide();
		});
		
		
	});


	//小面板
	buildSetter = function(qscore,obj,did){
		var offset = $(obj).offset();
		var the_top = offset.top;
		var the_left = offset.left;
			
		var btns = '';
		for(var i=0; i<=eval(qscore); i++){
			btns += '<a href="javascript:;" onclick="setScore('+i+','+did+');" class="lnk_score">'+i+'</a> ';
		}
		
		$("#divsetter").css("width","100px");
		$("#divsetter").css("height","auto");
		$("#divsetter").css("top",the_top+"px");
		$("#divsetter").css("left",the_left+"px");
		$("#divsetter").html(btns);
		$("#divsetter").show();
	}	


	//设置分值
	setScore = function(_score,_did){
		
		$.ajax({
			type: "POST",
			url: "ajax.do?action=manualCheck",
			data: {pid:_pid, uid:_uid, did:_did, iid:_iid, score:_score, t:rnd()},
			success: function(msg){
				if("1"==msg || 1==msg || 2==msg || "2"==msg){
					alert("操作成功");
					
					//在页面上设置改变后的分值
					var old_this_val = $(".qks[did="+_did+"]").children("span.label:first").html();
					var old_total_score = $("#u_total_score").html();
					
					var n_this_val = _score;
					var n_total_score = eval(old_total_score-old_this_val+n_this_val);
					$("#u_total_score").html(n_total_score);
					$(".qks[did="+_did+"]").children("span.label:first").html(""+n_this_val);
					
					
				}else{
					alert("操作失败");
				}
			},
			error: function(){
				alert("向系统发送请求时,发生异常。请与系统管理员联系。");
			}
		}); 
	}














