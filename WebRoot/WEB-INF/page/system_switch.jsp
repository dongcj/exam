<%@ page language="java" pageEncoding="utf-8"%>
<html>
<head>
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String TomUserType = (String) session.getAttribute("TomUserType");
	%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>HCF exam</title>
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<style>
		html{overflow-x:hidden;}
		a:hover{text-decoration:none}
		.aswitch1{background:url('skins/images/switch.png') no-repeat;width:8px; height:50px; margin-left:1px; display:block;text-decoration:none}
		.aswitch2{background:url('skins/images/switch.png') no-repeat;width:8px; height:50px; margin-left:1px; display:block; background-position:right;text-decoration:none}
	</style>
	<script src="inc/util.js"></script>
	<script>
	
		function switchbar(){
			var mainframe = parent.document.getElementById("mainframe");
			var aswitcher = document.getElementById("aswitcher");
			var cols = "" + mainframe.cols;
			if("200,10,*" == cols){
				mainframe.cols = "0,10,*";
				aswitcher.className = "aswitch2";
			}else{
				mainframe.cols = "200,10,*";
				aswitcher.className = "aswitch1";
			}
		}
		
		var tomuserType = <%=TomUserType %>
		
		// 3为普通考生  隐藏左边菜单直接显示考生试卷
		function load(){
			var mainframe = parent.document.getElementById("mainframe");
			var main = parent.document.getElementById("main");
			if(tomuserType == "3"){
				mainframe.cols = "0,10,*";
				main.src = "user/paper.do?action=list";
			}
		}
		
		
	</script>
</head>
<body class="menubody" onload="load()">

	<% 
	// 2为普通考生  当为考生登陆时则不显示切换功能 	
	if (!"3".equals(TomUserType)) { 
	%>
	<table border="0" cellpadding="0" cellspacing="0" height="100%">
		<tr>
			<td valign="middle">
				<a href="javascript:" onclick="switchbar()" id="aswitcher" class="aswitch1" title="切换">&nbsp;</a>
			</td>
		</tr>
	</table>
	<%} %>
	

</body>
</html>


