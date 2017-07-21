	var USERNO_LENGTH = 3;
	var USERNAME_LENGTH = 3;
	var USERPASS_LENGTH = 5;
	var SFZHM_LENGTH = 16;
	var REALNAME_LENGTH = 2;
	

	$(function(){
		
		/** 用户分组 **/
		GroupList();
		
		/** 验证工号 **/
		//get the userno_tip content
		userno_tip_content=$("#userno_tip").html();
		$("input[name=userno]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#userno_tip").html(userno_tip_content);
				$("#span_userno").html("");
			}else{
				if(this_val.length<=USERNO_LENGTH){
					$("#userno_tip").html("");
					$("#span_userno").attr("style","color:#ff0000");
					$("#span_userno").html("工号输入长度必须大于"+USERNO_LENGTH);
					return;
				}
				if(!checkNumber(this_val)){
					$("#userno_tip").html("");
					$("#span_userno").attr("style","color:#ff0000");
					$("#span_userno").html("工号必须是数字");
					return;
				}
				$.ajax({
				   type: "POST",
				   url: "ajax.do?action=checkUser",
				   data: {val:$(this).val(),t:rnd(),cw:"userno"},
				   success: function(msg){
				     if("1"==msg || 1==msg){
				    	$("#userno_tip").html("");
					 	$("#span_userno").attr("style","color:#ff0000");
					 	$("#span_userno").html("工号["+this_val+"]已经存在");
					 }else{
						$("#userno_tip").html("");
					 	$("#span_userno").attr("style","color:#00ff00");
					 	$("#span_userno").html("工号["+this_val+"]可以使用");
					 }
				   }
				}); 
			}
		});
		
		
		/** 验证用户名 **/
		//get the username_tip content
		username_tip_content=$("#username_tip").html();
		$("input[name=username]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#username_tip").html(username_tip_content);
				$("#span_username").html("");
			}else{
				if(this_val.length<=USERNAME_LENGTH){
					$("#username_tip").html("");
					$("#span_username").attr("style","color:#ff0000");
					$("#span_username").html("用户名长度必须大于"+USERNAME_LENGTH);
					return;
				}
				$.ajax({
				   type: "POST",
				   url: "ajax.do?action=checkUser",
				   data: {val:$(this).val(),t:rnd(),cw:"username"},
				   success: function(msg){
				     if("1"==msg || 1==msg){
				    	$("#username_tip").html("");
					 	$("#span_username").attr("style","color:#ff0000");
					 	$("#span_username").html("用户名["+this_val+"]已经存在");
					 }else{
						$("#username_tip").html("");
					 	$("#span_username").attr("style","color:#00ff00");
					 	$("#span_username").html("用户名["+this_val+"]可以使用");
					 }
				   }
				}); 
			}
		});
		
	
		/** 验证身份证**/
		//get the sfzhm_tip content
		sfzhm_tip_content=$("#sfzhm_tip").html();
		$("input[name=sfzhm]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#sfzhm_tip").html(sfzhm_tip_content);
				$("#span_sfzhm").html("");
			}else{
				if(this_val.length<=SFZHM_LENGTH){
					$("#sfzhm_tip").html("");
					$("#span_sfzhm").attr("style","color:#ff0000");
					$("#span_sfzhm").html("用户名长度必须大于"+SFZHM_LENGTH);
					return;
				}
				$.ajax({
				   type: "POST",
				   url: "ajax.do?action=checkUser",
				   data: {val:$(this).val(),t:rnd(),cw:"sfzhm"},
				   success: function(msg){
				     if("1"==msg || 1==msg){
				    	$("#sfzhm_tip").html("");
					 	$("#span_sfzhm").attr("style","color:#ff0000");
					 	$("#span_sfzhm").html("身份证号码["+this_val+"]已经存在");
					 }else{
						$("#sfzhm_tip").html("");
					 	$("#span_sfzhm").attr("style","color:#00ff00");
					 	$("#span_sfzhm").html("身份证号码["+this_val+"]可以使用");
					 }
				   }
				}); 
			}
		});
		
		/** 验证密码**/
		//get the userpass_tip content
		userpass_tip_content=$("#userpass_tip").html();
		$("input[name=userpass]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#userpass_tip").html(userpass_tip_content);
				$("#span_userpass").html("");
			}else{
				if(this_val.length<=USERPASS_LENGTH){
					$("#userpass_tip").html("");
					$("#span_userpass").attr("style","color:#ff0000");
					$("#span_userpass").html("密码长度必须大于"+USERPASS_LENGTH);
					return;
				}
				$.ajax({
				   success: function(msg){
				     if("1"==msg || 1==msg){
				    	$("#userpass_tip").html("");
					 	$("#span_userpass").attr("style","color:#ff0000");
					 	$("#span_userpass").html("密码["+this_val+"]不能使用");
					 }else{
						$("#userpass_tip").html("");
					 	$("#span_userpass").attr("style","color:#00ff00");
					 	$("#span_userpass").html("密码可以使用");
					 }
				   }
				}); 
			}
		});	
		
		/** 验证重复密码**/
		//get the userpass2_tip content
		userpass2_tip_content=$("#userpass2_tip").html();
		$("input[name=userpass2]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#userpass2_tip").html(userpass2_tip_content);
				$("#span_userpass2").html("");
			}else{
				if(this_val.length<=USERPASS_LENGTH){
					$("#userpass2_tip").html("");
					$("#span_userpass2").attr("style","color:#ff0000");
					$("#span_userpass2").html("密码长度必须大于"+USERPASS_LENGTH);
					return;
				}
				
				if($("#userpass2").val()!=$("#userpass").val()){
					$("#userpass2_tip").html("");
					$("#span_userpass2").attr("style","color:#ff0000");
					$("#span_userpass2").html("确认密码不匹配");
					return;
				}
				$.ajax({
				   success: function(msg){
				     if("1"==msg || 1==msg){
				    	$("#userpass2_tip").html("");
					 	$("#span_userpass2").attr("style","color:#ff0000");
					 	$("#span_userpass2").html("密码不能使用");
					 }else{
						$("#userpass2_tip").html("");
					 	$("#span_userpass2").attr("style","color:#00ff00");
					 	$("#span_userpass2").html("确认密码相同");
					 }
				   }
				}); 
			}
		});	
		
		
		/** 验证真实姓名**/
		//get the realname_tip content
		realname_tip_content=$("#realname_tip").html();
		$("input[name=realname]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#realname_tip").html(realname_tip_content);
				$("#span_realname").html("");
			}else{
				if(this_val.length<=REALNAME_LENGTH){
					$("#realname_tip").html("");
					$("#span_realname").attr("style","color:#ff0000");
					$("#span_realname").html("真实姓名长度必须大于"+REALNAME_LENGTH);
					return;
				}
				
				$.ajax({
				   success: function(msg){
				     if("1"==msg || 1==msg){
				    	$("#realname_tip").html("");
					 	$("#span_realname").attr("style","color:#ff0000");
					 	$("#span_realname").html("真实姓名不能使用");
					 }else{
						$("#realname_tip").html("");
					 	$("#span_realname").attr("style","color:#00ff00");
					 	$("#span_realname").html("真实姓名可以使用");
					 }
				   }
				}); 
			}
		});	
		
		
		/** 验证邮箱**/
		//get the email_tip content
		email_tip_content=$("#email_tip").html();
		$("input[name=email]").blur(function(){
			var this_val = $(this).val();
			if(this_val==null || ""==this_val){
				$("#email_tip").html("");
				$("#span_email").html("");
			}else{
				if(!isEmail(this_val)){
					$("#email_tip").html("");
					$("#span_email").attr("style","color:#ff0000");
					$("#span_email").html("邮箱地址不正确，请填写正确邮箱或保持为空");
					return;
				}
				
				$.ajax({
					   type: "POST",
					   url: "ajax.do?action=checkUser",
					   data: {val:$(this).val(),t:rnd(),cw:"email"},
					   success: function(msg){
					     if("1"==msg || 1==msg){
					    	$("#email_tip").html("");
						 	$("#span_email").attr("style","color:#ff0000");
						 	$("#span_email").html("Email地址["+this_val+"]已经存在");
						 }else{
							$("#email_tip").html("");
						 	$("#span_email").attr("style","color:#00ff00");
						 	$("#span_email").html("Email地址["+this_val+"]可以使用");
						 }
					   }
					}); 
			}
		});	
		
		/** 提交 **/
		$("#btnsubmit").click(function(){
			if(FormValidator()){
				Register();
			}
		});
		
		
	});
	
	
	
	/** 注册 **/
	function Register(){
		
		var userno = encodeURI(encodeURI($("#userno").val()));
		var username = encodeURI(encodeURI($("#username").val()));
		var userpass = $("#userpass").val();
		var sfzhm = encodeURI(encodeURI($("#sfzhm").val()));
		var realname = encodeURI(encodeURI($("#realname").val()));
		var gid = $("#gid").val();
		var email = $("#email").val();
		var mobi = $("#mobi").val();

//		alert(userno+","+username+","+userpass+","+sfzhm+","+realname+","+email+","+mobi+","+gid);
		
		$.ajax({
			type: "POST",
			url: "ajax.do?action=register",
			data: "userno="+userno+"&username="+username+"&userpass="+userpass+"&sfzhm="+sfzhm+"&realname="+realname+"&email="+email+"&mobi="+mobi+"&gid="+gid+"&t="+rnd(),
			//data: {action:"register",username:username,userpass:userpass,userno:userno,realname:realname,email:email,mobi:mobi,gid:gid,t:rnd()},
			success: function(msg){
				if("1"==msg || 1==msg){
					alert("注册成功，请登陆");
				}else if("9"==msg || 9==msg){
					alert("注册失败，用户名已经存在。");
					return false;
				}else if("8"==msg || 8==msg){
					alert("注册失败，工号已经存在。");
					return false;
				}else if("7"==msg || 7==msg){
					alert("注册失败，身份证号码已经存在。");
					return false;
				}else if("6"==msg || 6==msg){
					alert("注册失败，请联系管理员。" + msg);
					return false;
				}else if("99"==msg || 99==msg){
					alert("已经达到该版本的用户最大限制数，请联系管理员。");
					return false;
				}else{
					alert("注册失败，请联系管理员。"+msg);
					return false;
				}
				top.location.href = "login.jsp";
			}
		});
		
	}
	
	
	
	
	/** 获取用户分组 **/
	function GroupList(){
		$.getJSON("ajax.do?action=getUserGroups", {t:rnd()}, function(data){
			var html = "";
			for(var i=0;i<data.datalist.length;i++){
				var gname = "" + data.datalist[i].GROUPNAME;
				var id = data.datalist[i].ID;
				html += "<option value='"+id+"'>"+gname+"</option>";
			}
			$("#gid").html(html);
		});
	}
	
	
	
	
	/** 表单校验 **/
	function FormValidator(){
		$("#userno_tip").html("");
		$("#username_tip").html("");
		$("#userpass_tip").html("");
		$("#userpass2_tip").html("");
		$("#sfzhm_tip").html("");
		$("#realname_tip").html("");
		$("#gid_tip").html("");

		if(IsNull($("#userno").val())){
			$("#span_userno").css("color","#ff0000");
			$("#span_userno").html("个人工号不能为空");
		}
		
		if(IsNull($("#username").val())){
			$("#span_username").css("color","#ff0000");
			$("#span_username").html("用户名不能为空");
		}
		
		if(IsNull($("#userpass").val())){
			$("#span_userpass").css("color","#ff0000");
			$("#span_userpass").html("密码不能为空");
		}
		
		if(IsNull($("#userpass2").val())){
			$("#span_userpass2").css("color","#ff0000");
			$("#span_userpass2").html("确认密码不能为空");
		}
		
		if($("#userpass2").val()!=$("#userpass").val()){
			$("#span_userpass2").css("color","#ff0000");
			$("#span_userpass2").html("确认密码不匹配");
		}
		
		if(IsNull($("#sfzhm").val())){
			$("#span_sfzhm").css("color","#ff0000");
			$("#span_sfzhm").html("身份证号码不能为空");
		}
		
		if(IsNull($("#realname").val())){
			$("#span_realname").css("color","#ff0000");
			$("#span_realname").html("真实姓名不能为空");
		}

		if(IsNull($("#gid").val())){
			$("#span_gid").css("color","#ff0000");
			$("#span_gid").html("所属分组不能为空");
		}
		
		if(!IsNull($("#email").val())){
			if(!isEmail($("#email").val())){
				$("#span_email").css("color","#ff0000");
				$("#span_email").html("邮箱格式不正确");
			}
		}


		if(IsNull($("#userno").val())){
			return false;
		} else if($("#userno").val().length <= USERNO_LENGTH) {
			return false;
		} else if(!checkNumber($("#userno").val())) {
			return false;
		}
		
		if(IsNull($("#username").val())){
			return false;
		} else if($("#username").val().length <= USERNAME_LENGTH) {
			return false;
		}
		
		if(IsNull($("#userpass").val())){
			return false;
		} else if($("#userpass").val().length <= USERPASS_LENGTH) {
			return false;
		}
		
		if($("#userpass2").val()!=$("#userpass").val()){
			return false;
		} else if($("#userpass2").val().length <= USERPASS_LENGTH) {
			return false;
		}
		
		if(IsNull($("#sfzhm").val())){
			return false;
		} else if($("#sfzhm").val().length <= SFZHM_LENGTH) {
			return false;
		}
		
		if(IsNull($("#realname").val())){
			return false;
		} else if($("#realname").val().length <= REALNAME_LENGTH) {
			return false;
		}

		if(IsNull($("#gid").val())){
			return false;
		} 
		
		if(!IsNull($("#email").val())){
			if(!isEmail($("#email").val())){
				return false;
			}
		}

		return true;
	}
	
	
	/** 空值检查 **/
	function IsNull(s){
		if(s==null || s==""){
			return true;
		}else{
			return false;
		}
	}
	
	
	/** EMAIL检查 **/
	function isEmail(str){
		res = /^[0-9a-zA-Z_\-\.]+@[0-9a-zA-Z_\-]+(\.[0-9a-zA-Z_\-]+)*$/;
		var re = new RegExp(res);
		return !(str.match(re) == null);
	}
	
	
