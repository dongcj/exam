
$(document).ready(function(){
	$("#btnsubmit").click(function(){
		
		$get("loginform").action = "process.do?action=login3";
		
		var sfzhm = $get("sfzhm").value;
		var userpass = $get("userpass").value;
//		var usertype = $get("usertype").value;
		
		/* 暂时取消验证码功能
		var tvery = $get("tvery").value;
		*/
		
		if(sfzhm==null || ""==sfzhm){
			alert("身份证号码不能为空");
			return;
		}
		
		if(userpass==null || ""==userpass){
			alert("密码不能为空");
			return;
		}
		
		/* 暂时取消验证码功能
		if(tvery==null || ""==tvery){
			alert("验证码不能为空");
			return;
		};
		*/
		
		$get("loginform").submit();
		
	}); 
}); 




