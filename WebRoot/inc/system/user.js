	
	var qs = new queryStr();
	
	//页面加载
	$(function(){
		if(qs.action=="load"){
			$("select[name=status]").val(_status);
			$("select[name=gid]").val(_gid);
			
		}else if(qs.action=="add"){
			
			
			$("input[name=userno]").attr("style","background:#ffa");
			$("input[name=sfzhm]").attr("style","background:#ffa");
			
			
			//唯一性检查
			$("input[name=userno]").blur(function(){
				var this_val = $(this).val();
				if(this_val==null || ""==this_val){
					$("#span_userno").html("");
				}else{
					$.ajax({
					   type: "POST",
					   url: "ajax.do?action=checkUser",
					   data: {val:$(this).val(),t:rnd(),cw:"userno"},
					   success: function(msg){
					     if("1"==msg || 1==msg){
						 	$("#span_userno").attr("style","color:#ff0000");
						 	$("#span_userno").html("编号已经存在");
						 }else{
						 	$("#span_userno").attr("style","color:#00ff00");
						 	$("#span_userno").html("可以使用");
						 }
					   }
					}); 
				}	
				
				
				
			});
			
			
			//唯一性检查
			$("input[name=sfzhm]").blur(function(){
				var this_val = $(this).val();
				if(this_val==null || ""==this_val){
					$("#span_sfzhm").html("");
				}else{
					$.ajax({
					   type: "POST",
					   url: "ajax.do?action=checkUser",
					   data: {val:$(this).val(),t:rnd(),cw:"sfzhm"},
					   success: function(msg){
					     if("1"==msg || 1==msg){
						 	$("#span_sfzhm").attr("style","color:#ff0000");
						 	$("#span_sfzhm").html("身份证号码已经存在");
						 }else{
						 	$("#span_sfzhm").attr("style","color:#00ff00");
						 	$("#span_sfzhm").html("可以使用");
						 }
					   }
					}); 
				}
				
			});
			
		}else if(qs.action=="list"){
			if("null"!=_s_gid && null!=_s_gid) 
				$("select[name=s_gid]").val(_s_gid);
			
			if("null"!=_s_userno && null!=_s_userno) 
				$("input[name=s_userno]").val(_s_userno);
			
			if("null"!=_s_username && null!=_s_username) 
				$("input[name=s_username]").val(_s_username);
			
			if("null"!=_s_realname && null!=_s_realname) 
				$("input[name=s_realname]").val(_s_realname);
			
			if("null"!=_s_status && null!=_s_status) 
				$("select[name=s_status]").val(_s_status);
			
			if("null"!=_s_sfzhm && null!=_s_sfzhm) 
				$("input[name=s_sfzhm]").val(_s_sfzhm);
				
			
		}
	});
	

function submitPrint(){
	bf.action = "print/system_user_print.jsp";
	bf.submit();
}
	