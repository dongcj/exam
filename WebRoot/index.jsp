<%@ page language="java" import="java.util.List,java.util.Map,com.tom.cache.ConfigCache" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=ConfigCache.getConfigByKey("sys_sitename") %> - 首页</title>
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<script type="text/javascript" src="inc/jquery.js"></script>
	<link rel="shortcut icon" href="favicon.ico" />
	<!-- if the page not start in main, refresh the window -->

</head>


<frameset rows="50,*" name="pframe" id="pframe" frameborder="no" border="0" framespacing="0">
  <frame src="page.do?action=system_top" noresize="noresize" frameborder="no" name="top" scrolling="no" marginwidth="0" marginheight="0" target="main" />
  <frameset cols="200,10,*" id="mainframe">
    <frame src="page.do?action=system_menu" name="left" id="left" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="main" />
	<frame src="page.do?action=system_switch" name="mid" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" />
    <frame src="welcome.jsp" name="main" id="main" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="_self" />
  </frameset>
</frameset>

<noframes>
	<body>您的浏览器不支持框架。</body>
</noframes>


</html>


