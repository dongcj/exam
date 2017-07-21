<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map"  %>
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

	
	<% 
	if("add".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>创建用户分组</li>
    </ul>
    
    <br />
	填写下列基本信息，创建用户分组。<br/>
	<div class="buttons">
		<a href="system/usergroups.do?action=add" class="on">创建用户分组</a>
		<a href="system/usergroups.do?action=list">管理用户分组</a>
	</div>
    
    <br /><br />
    <form action="system/usergroups.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">分组名称</td>
    		<td><input type="text" class="validate[required] txt" maxlength="20" name="groupname" />  </td>
    	</tr>
    	<tr>
			<td class="thx">分组备注</td>
			<td><input type="text" class="txt" name="remark" maxlength="20"  /> </td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
			</td>
		</tr>
    </table>
    </form>
    <% 
    }
    %>
    
    
    
    <% 
	if("load".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("usergroup");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改用户分组</li>
    </ul>
    
    <br />
	<font color="red"><b>修改用户分组，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/usergroups.do?action=add">创建用户分组</a>
		<a href="system/usergroups.do?action=list">管理用户分组</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/usergroups.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">分组名称</td>
    		<td><input type="text" class="validate[required] txt" maxlength="20" name="groupname" value="<%=map.get("GROUPNAME") %>" />  </td>
    	</tr>
    	<tr>
			<td class="thx">分组备注</td>
			<td><input type="text" class="txt" name="remark" maxlength="20" value="<%=map.get("REMARK") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
			</td>
		</tr>
    </table>
    </form>
    <% 
    }
    }
    %>
	
	
	
	<% 
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>用户分组管理</li>
    </ul>
    
    <br />
	用户分组管理，选择用户分组进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/usergroups.do?action=add">创建用户分组</a>
		<a href="system/usergroups.do?action=list" class="on">管理用户分组</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">分组名称</th>
			<th>备注</th>
			<th width="70">操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("GROUPNAME") %></td>
				<td><%=map.get("REMARK") %></td>
				<td>
					<a href="system/usergroups.do?action=load&id=<%=map.get("ID") %>">修改</a>
					-
					<a href="system/usergroups.do?action=delete&id=<%=map.get("ID") %>" onclick="return window.confirm('删除分组会影响到分组下用户的使用。\n且删除操作无法恢复，请谨慎操作。\n\n确定要删除吗?');">删除</a> 
				</td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="3"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	
	<% 
	}
	%>
	
	
	
	
	
	

</body>
</html>


