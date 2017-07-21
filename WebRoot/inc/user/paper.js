	
	var QuestionIDS = [];
	var etimer;
	
	getUserKey = function(n){
		var Check = "";
		var checkedObj = $("[name='"+n+"'][@checked]"); 
		checkedObj.each(function(){
			var isCheck = this.value + ""; 
			Check += isCheck; 
		}); 
		return Check;
	}
		
	checkPaper = function(){
		var theForm = document.getElementById("selfform");
		var formcheck = Validator.Validate(theForm,3);
		if(formcheck){
			clearTimeout(etimer);
			
			$(".qk").each(function(i){
				var td_key_id = $(this).attr("id");
				var question_id = td_key_id.substring(3,td_key_id.length-2);
				
				var questionkey = $("#question_"+question_id+"_key").val();
				var userkey = getUserKey("question_"+question_id);
				var html = "答案：" + questionkey + "<br/>";
				html += "选择：" + userkey + "<br/>";
				var keycheck = (userkey == questionkey ? "true" : "err");
				html += "<img src='skins/images/"+keycheck+".png' width='35' /><br/>";
				
				$("#qes"+question_id+"td").html(html);
			});
			
		}else{
			return false;
		}
	}
		
		
	$(this).scroll(function(){ });
	
	
	$(function(){
		var n = 1;
		var html = '';
		html += "<div>快速跳转：</div>";
		$(".qk").each(function(i){
			var td_key_id = $(this).attr("id");
			var question_id = td_key_id.substring(3,td_key_id.length-2);
			html += '<a href="javascript:;" id="fastto_question_'+question_id+'" onclick="moveto('+$(this).parent().offset().top+')">'+n+'</a>';
			n++;
		});
		
		$("#div_processor_fastto").html(html);
		//$("#div_processor_timer").html('<span class="label">10:10</span>');
		etimer = setInterval("startTime()",1000); 
		$("#div_processor_ops").html('<input type="button" value="提交试卷" class="btn" onclick="checkPaper();" /><br/><br/>');
		
		
		$(".qclazz").click(function(){
			var thename = $(this).attr("name");
			//var checkedObj = $("[name='"+thename+"'][@checked]"); 
			if(getUserKey(thename)!=''){
				$("#fastto_"+thename).attr("class","finished");
			}else{
				$("#fastto_"+thename).attr("class","");
			}
		});
		
		
		$(".qoptions").each(function(){
			var lastoption = $(this).children("input.qclazz:last");
			lastoption.attr("dataType","Group");
			lastoption.attr("msg","未选择");
		});
		
		
		
	});
	
	
	function moveto(thetop){
		$("html:not(:animated),body:not(:animated)").animate({ scrollTop: thetop}, 1000);
	}
	
	
	
	var clock_second=0; 
	var clock_minute=0; 
	var clock_hour=0; 
	
	function startTime() { 
		clock_second ++;
		if(clock_second>60){
			clock_second = 0;
			clock_minute ++;
			if(clock_minute>60){
				clock_minute = 0;
				clock_hour ++;
			}
		}
		var str=clock_hour+"时 "+clock_minute+"分 "+clock_second+"秒 "; 
		$("#div_processor_timer").html('<span>'+str+'</span>');
	} 

	
	