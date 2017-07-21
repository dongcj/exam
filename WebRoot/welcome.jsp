<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.Map,com.tom.cache.ConfigCache" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>HCF exam</title>
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/nav.css" />

	<style>
		h3{ font-size:14px; margin:0px; border-bottom:solid 2px #cde; margin-top:20px; color:#006}
		.ilist{ margin:0px; list-style:none; margin-bottom:10px}
		.ilist li{ padding:5px 5px 5px 10px; border-bottom: dotted 1px #cde }
		.ilist li em{ margin-left:10px; color:#888}
		.ilist li span{ margin:0 5px; padding:5px}
	</style>
	<script src="inc/util.js"></script>
	<script src="inc/jquery.js"></script>
	<script src="inc/welcome.js"></script>
</head>
<body class="body">

	<ul id="breadcrumb">
        <li><a href="user/paper.do?action=list"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>欢迎页</li>
    </ul>
	
	<h3>新闻公告</h3>
	<ul class="ilist" id="welcome_newslist">
	</ul>
	
	
	<h3>进行中的考试</h3>
	<ul class="ilist" id="ul_currentexam"></ul>
	
	
	<%
	String TomUserType = (String) session.getAttribute("TomUserType");
	if ("1".equals(TomUserType)) {
	float fFreeMemory=(float)Runtime.getRuntime().freeMemory();
	float fTotalMemory=(float)Runtime.getRuntime().totalMemory();
	float fUsedMemory = fTotalMemory - fFreeMemory;
	float fPercent=fFreeMemory/fTotalMemory*100;
	%>
	<h3>系统状态</h3>
	<ul class="ilist">
		<li>服务器名：<%= request.getServerName() %>(<%=request.getRemoteAddr()%>)</li>
		<li>
			内存消耗：<%=fUsedMemory/1024/1024%>M / <%=fTotalMemory/1024/1024%>M 
			<div style="width:200px; height:10px; background:#f00; font-size:1px">
				<div style="float:right; background:#0f0; width:<%=(int)(fPercent*2)%>px; font-size:1px; height:10px"></div>
			</div>
		</li>
		<li>操作系统：<%=System.getProperty("os.name") %></li>
		<li>JDK版本：<%=System.getProperty("java.version") %></li>
	</ul>
	<%}%>
	
	<h3>版本信息</h3>
	<ul class="ilist">
		<li>版本：<%=ConfigCache.getConfigByKey("sys_sitename") %></li>
		<li>
			<a href="mailto:huangqiao@szhcf.com.cn">联系人力资源部</a>
			-
			<a href="http://www.szhcf.com.cn" target="_blank">官方网站</a>
			-
			<!-- <a href="http://t.sina.com.cn/hcfexam" target="_blank">官方微博</a> -->
			-
			<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=85509336&site=qq&menu=yes">技术支持</a>
		</li>
	</ul>
	
	


</body>
</html>


