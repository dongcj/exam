<%@ page language="java" import="java.util.List,java.util.Map,com.tom.cache.ConfigCache" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=ConfigCache.getConfigByKey("sys_sitename") %> - 系统登陆</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<script src="inc/jquery.js"></script>
	<script src="inc/util.js"></script>
	<script src="inc/login.js"></script>
	<style>
		.userselect{width:80px; border:solid 1px #666; border-right:solid 1px #ccc; border-bottom:solid 1px #ccc;padding:1px 2px 2px 2px}
	</style>
</head>
<body onkeydown="keys()">

	<div class="login">
		<div class="loginform">
			<form action="" method="post" id="loginform">
			<input type="hidden" name="usertype" value="1"/>
			用户名：<input type="text" class="txt" name="username" id="username" value="" style="width:120px" />&nbsp; 
			密码：<input type="password" class="txt" name="userpass" id="userpass" value="" style="width:120px" />&nbsp; 
			&nbsp;
			<input type="button" id="btnsubmit" class="btn" value="登陆" style="width:50px" />
			</form>
		</div>
		
		<div class="logininfo">
			Copyright &copy; <b>HCF exam</b>.com All Right Reserved 2009-2011
		</div>
	</div>
	
	<% 
		String loginmsg = (String)request.getSession().getAttribute("loginmsg");
		if(loginmsg!=null){
			%>
			<script>alert('<%=loginmsg %>');</script>
			<%
			request.getSession().removeAttribute("loginmsg");
		}
	%>

</body>
</html>


