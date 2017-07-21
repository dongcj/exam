<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,com.tom.cache.ConfigCache"  %>
<% 
String action = (String) request.getParameter("action");
%>
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
	<link rel="stylesheet" type="text/css" href="skins/default/nav.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/validationEngine.css" />
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/validationEngine.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<title>HCF exam</title>
</head>
<body class="body">
	
	
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>系统参数管理</li>
    </ul>
    
    <br />
	系统参数管理，选择参数进行设置，请谨慎操作。
	
	<br /><br />

	
	<table class="stable" width="100%" align="center">

		<form action="system/config.do?action=update&key=sys_sitename" method="post">
			<tr>
				<th style="width:150px">系统名称</th>
				<td>
					<input type="text" name="sys_sitename"  class="validate[required] txtfree" value="<%=ConfigCache.getConfigByKey("sys_sitename") %>" size="50" maxlength="50" />
				</td>
				<td><input type="submit" value=" 提 交 " class="btn" /></td>
			</tr>
		</form>

		<form action="system/config.do?action=update&key=sys_register" method="post">
			<tr>
				<th>开放注册</th>
				<td>
					<select name="sys_register">
						<option value="on" style="background:#0f0">开放注册</option>
						<option value="off" style="background:#f00">关闭注册</option>
					</select>
					(是否允许用户注册)
				</td>
				<td><input type="submit" value=" 提 交 " class="btn" /></td>
			</tr>
		</form>

		<form action="system/config.do?action=update&key=sys_userlogin" method="post">
			<tr>
				<th>开放普通用户登陆</th>
				<td>
					<select name="sys_userlogin">
						<option value="on" style="background:#0f0">开放登陆</option>
						<option value="off" style="background:#f00">关闭登陆</option>
					</select>
					(是否允许普通用户登陆)
				</td>
				<td><input type="submit" value=" 提 交 " class="btn" /></td>
			</tr>
		</form>

		<form action="system/config.do?action=update&key=sys_uncheckuser_exam" method="post">
			<tr>
				<th>开放待审核用户答卷</th>
				<td>
					<select name="sys_uncheckuser_exam">
						<option value="on" style="background:#0f0">允许</option>
						<option value="off" style="background:#f00">不允许</option>
					</select>
					(是否允许待审核用户答卷)
				</td>
				<td><input type="submit" value=" 提 交 " class="btn" /></td>
			</tr>
		</form>

		<form action="system/config.do?action=update&key=sys_communication_rate" method="post">
			<tr>
				<th>通讯频率</th>
				<td>
					<input type="text" name="sys_communication_rate"  class="validate[required,custom[onlyNumber]] txtfree"
					value="<%=ConfigCache.getConfigByKey("sys_communication_rate") %>" size="2" maxlength="2" /> 分钟
					(设置过小可能影响系统性能，建议3分钟)
				</td>
				<td><input type="submit" value=" 提 交 " class="btn" /></td>
			</tr>
		</form>

		<form action="system/config.do?action=update&key=sys_sncode" onsubmit="return window.confirm('确定要注册码修改吗？建议对旧注册码做好备份工作。');" method="post">
			<tr>
				<th>注册码</th>
				<td>
					<input type="text" name="sys_sncode"  class="validate[required] txtfree"
					value="<%=ConfigCache.getConfigByKey("sys_sncode") %>" size="50" maxlength="50" /> (请输入正版注册码，<font color="red">请谨慎修改</font>)
					
				</td>
				<td><input type="submit" value=" 提 交 " class="btn" /></td>
			</tr>
		</form>

	</table>
	
	
	
	<script>
		$(function(){
			$("select[name=sys_register]").val('<%=ConfigCache.getConfigByKey("sys_register") %>');
			$("select[name=sys_userlogin]").val('<%=ConfigCache.getConfigByKey("sys_userlogin") %>');
			$("select[name=sys_uncheckuser_exam]").val('<%=ConfigCache.getConfigByKey("sys_uncheckuser_exam") %>');
		});
	</script>
	

</body>
</html>


