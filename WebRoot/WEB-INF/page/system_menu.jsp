<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://"
				+ request.getServerName() + ":" + request.getServerPort()
				+ path + "/";
	%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>HCF exam</title>
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<script src="inc/jquery.js"></script>
	<script src="inc/util.js"></script>
	<style>
		html{overflow-x:hidden;}
		.menu_body a img{border:none;margin-right:5px}
	</style>
</head>
<body class="menubody">

	<%
	String TomUserType = (String) session.getAttribute("TomUserType");
	String pannel = (String) request.getParameter("pannel");
	

	if ("1".equals(TomUserType)) {
		out.println(request.getAttribute("sysmenu"));
		if(pannel==null){%>
		<script>
			$(".menu_body").hide(); $("#menu1").fadeIn("fast");	$("#menu2").fadeIn("fast");	$("#menu5").fadeIn("fast");	
		</script>	
		<%}
	}else if ("2".equals(TomUserType)) { %>

	<div class="menu">
		<div class="menu_title"><a href="javascript:void(0);" onclick="$('#menu11').slideToggle('fast'); ">我的试卷</a></div>
		<div class="menu_body" id="menu11" style="display:block">
			<a href="user/paper.do?action=list" target="main"><img src="skins/images/icons/mypage.png" align="absmiddle" />我的试卷</a>
			<a href="user/paper.do?action=history" target="main"><img src="skins/images/icons/page_save.png" align="absmiddle" />考试记录</a>
		</div>
	</div>

	<div class="menu">
		<div class="menu_title"><a href="javascript:void(0);" onclick="$('#menu12').slideToggle('fast'); ">自我检测</a></div>
		<div class="menu_body" id="menu12" style="display:block">
			<a href="user/selfpaper.do?action=setting" target="main"><img src="skins/images/icons/page_go.png" align="absmiddle" />自我检测</a>
		</div>
	</div>
	
	<div class="menu">
		<div class="menu_title"><a href="javascript:void(0);" onclick="$('#menu13').slideToggle('fast'); ">个人管理</a></div>
		<div class="menu_body" id="menu13" style="display:block">
			<a href="user/my.do?action=profile" target="main"><img src="skins/images/icons/user.png" align="absmiddle" />个人资料</a>
			<a href="user/qc.do?action=list" target="main"><img src="skins/images/icons/emoticon_unhappy.png" align="absmiddle" />错题集</a>
		</div>
	</div>

	<div class="menu">
		<div class="menu_title"><a href="javascript:void(0);" onclick="$('#menu14').slideToggle('fast'); ">其他</a></div>
		<div class="menu_body" id="menu14" style="display:block">
			<a href="page.do?action=comm_news&act=catelist" target="main"><img src="skins/images/icons/news_center.png" align="absmiddle" />新闻中心</a>
			<a href="page.do?action=plus" target="main"><img src="skins/images/icons/plus.png" align="absmiddle" />应用大厅</a>
		</div>
	</div>

	
	<%} %>


</body>
</html>


