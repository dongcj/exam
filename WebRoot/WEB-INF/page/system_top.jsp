<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<title>HCF exam</title>
	<script src="inc/jquery.js"></script>
	<script src="inc/util.js"></script>
	<script>
		$(document).ready(
			function() {
				$(".topa").bind("click", function(){
					$(".topa").attr("class","topa");
					$(this).attr("class","topa topa_hover");
				}); 
			}
		); 
		
		
		function setstyle(s){
			setCookie('styleid', s);
			top.location.reload();
		}

		function menuto(lf,ma){
			$("#left",parent.document.body).attr("src",lf);
			$("#main",parent.document.body).attr("src",ma);
		}
		
	</script>
	
	
	
	<style>
		#styleswitcher{
			float:right;
			margin-top:30px;
			margin-right:10px
		}
		#styleswitcher ul{
			list-style:none;
			line-height:10px;
		}
		#styleswitcher li{
			height:12px;
			display:inline;
		}
		#footer ul {
			list-style:none;
		}
		#footer li {
			display:inline;
		}

		a#defswitch {
			width:15px;
			height:10px;
			margin: 3px 0 3px 0;
			background-color:#33CCFF;
			font-size: 8px;
			color:#33CCFF;
			display:inline-block;
		}
		a#grayswitch {
			width:15px;
			height:10px;
			margin: 3px 0 3px 0;
			background-color:#ddd;
			font-size: 8px;
			color:#ddd;
			display:inline-block;
		}
		a#greenswitch {
			width:15px;
			height:10px;
			margin: 3px 0 3px 0;
			background-color:#0f0;
			font-size: 8px;
			color:#0f0;
			display:inline-block;
		}
		a#orangeswitch {
			width:15px;
			height:10px;
			margin: 3px 0 3px 0;
			background-color:#FF9900;
			font-size: 8px;
			color:#FF9900;
			display:inline-block;
		}

		a#redswitch {
			width:15px;
			height:10px;
			margin: 3px 0 3px 0;
			background-color:#f00;
			font-size: 8px;
			color:#f00;
			display:inline-block;
		}
		
		#credits{
		clear:both;
			width:200px;
			float:left;
		}
	</style>

	<script language="javascript">
		function getCurDate(){
			var d = new Date();
			var week;
			switch (d.getDay()){
				case 1: week="星期一"; break;
				case 2: week="星期二"; break;
				case 3: week="星期三"; break;
				case 4: week="星期四"; break;
				case 5: week="星期五"; break;
				case 6: week="星期六"; break;
				default: week="星期天";
			}

			var years = d.getFullYear();
			var month = add_zero(d.getMonth()+1);
			var days = add_zero(d.getDate());
			var hours = add_zero(d.getHours());
			var minutes = add_zero(d.getMinutes());
			var seconds=add_zero(d.getSeconds());
			//var ndate = years+"年"+month+"月"+days+"日 "+hours+":"+minutes+":"+seconds+" "+week;
			var ndate = years+"年"+month+"月"+days+"日 "+week;
			//divT.innerHTML= ndate;
			return ndate;
		}

		function add_zero(temp){
			if(temp<10) return "0"+temp;
			else return temp;
		}

	</script>

</head>
<body class="topbody">

	<div class="logo"><img src="skins/images/logos.png" /></div>
	<% 
	String TomUserType = (String)session.getAttribute("TomUserType");
	String username = "";
	String usertp = "";
	@SuppressWarnings("unchecked")
	Map<String,Object> umap = (Map) session.getAttribute("TomUser");
	if("1".equals(TomUserType)){
		usertp = "系统用户";
	}else{
		usertp = "普通用户";
	}
	if(umap != null){
		username = (String) umap.get("REALNAME");
	}
	%>
	
	<div class="topmenubar">
		<%if("1".equals(TomUserType)){ %>
		<a href="javascript:;" onclick="menuto('page.do?action=system_menu','welcome.jsp');" class="topa topa_hover">系统首页</a>
		<!--
		<a href="javascript:;" onclick="menuto('page.do?action=system_menu','page.do?action=comm_news&act=catelist');" class="topa">新闻中心</a>
		-->
		<a href="javascript:;" onclick="menuto('page.do?action=system_menu&pannel=exam_system','system/paper.do?action=list');" class="topa">考试系统</a>
		<a href="javascript:;" onclick="menuto('page.do?action=system_menu&pannel=analysis_system','system/analysis.do?action=chengji');" class="topa">分析系统</a>
		<a href="javascript:;" onclick="menuto('page.do?action=system_menu&pannel=system_manage','system/config.do?action=list');" class="topa">系统管理</a>
		<a href="javascript:;" onclick="menuto('page.do?action=system_menu&pannel=others','system/news.do?action=add');" class="topa">综合管理</a>
		<%}else{ %>
		
		<%} %>
		
	</div>

	<div class="fasts">
		欢迎：<%=username %> [<%=usertp %>]
		&nbsp;&nbsp; 
		<img src="skins/images/calendar.png" align="absmiddle" border="0" />
		<script>document.write("<a href=\"javascript:;\" onclick=\"show_calendar();\">"+getCurDate()+"</a>");</script>

		&nbsp;&nbsp; 
		<img src="skins/images/user.png" align="absmiddle" border="0" />
		<%if("1".equals(TomUserType)){ %>
		<a href="system/admin.do?action=profile" target="main">个人资料</a> 
		<%}else{ %>
		<a href="user/my.do?action=profile" target="main">个人资料</a> 
		<%} %>
		&nbsp;

		<img src="skins/images/exclamation.png" align="absmiddle" border="0" />
		<a href="process.do?action=logout" onclick="return window.confirm('确定要退出吗？')" target="_top">退出系统</a>
	</div>
	

	<div id="styleswitcher">
		<ul>
			<li><a href="javascript:void(0);" onclick="setstyle('default');" title="默认蓝色" id="defswitch">d</a></li>
			<li><a href="javascript:void(0);" onclick="setstyle('gray');" title="灰色" 	id="grayswitch">b</a></li>
			<li><a href="javascript:void(0);" onclick="setstyle('green');" title="绿色" 	id="greenswitch">g</a></li>
			<li><a href="javascript:void(0);" onclick="setstyle('orange');" title="橙色" 	id="orangeswitch">b</a></li>
			<li><a href="javascript:void(0);" onclick="setstyle('red');" title="红色" 	id="redswitch">b</a></li>
		</ul>
	</div>

	<script>
		function show_calendar(){
			var surl = "plug-ins/calendar/calendar.html";
			showWindow(surl,750,400);
		}
	</script>

	<iframe frameborder="0" scrolling="no" src="inc/test.jsp" style="width:1px; height:1px; display:none;"></iframe>

</body>
</html>


