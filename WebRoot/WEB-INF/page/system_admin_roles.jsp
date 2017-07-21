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
		<li>创建管理员角色</li>
    </ul>
    
    <br />
	填写下列基本信息，创建系统管理员角色。<br/>
	<div class="buttons">
		<a href="system/adminrole.do?action=add" class="on">创建管理员角色</a>
		<a href="system/adminrole.do?action=list">管理管理员角色</a>
	</div>
    
    <br /><br />
    <form action="system/adminrole.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">角色名称</td>
    		<td><input type="text" class="validate[required] txt" maxlength="20" name="rolename" />  </td>
    	</tr>
    	<tr>
			<td class="thx">角色备注</td>
			<td><input type="text" class="txt" name="remark" maxlength="20"  /> </td>
		</tr>
		<tr>
			<td class="thx">角色权限</td>
			<td>
				<% 
				@SuppressWarnings("unchecked")
				List<Map> menu = (List) request.getAttribute("menu");
				@SuppressWarnings("unchecked")
				List<Map> list = (List) request.getAttribute("list");
				
				if(menu!=null){
					for(Map<String,String> m : menu){
						String id = (String) m.get("ID");
				%>
				<fieldset>
					<legend>
						<input type="checkbox" name="roleprivelege" class="ptitle" value="<%=m.get("PCODE") %>" /><%=m.get("PNAME") %>
					</legend>
					<%
					if(list!=null){ 
					for(Map<String,String> mp : list){
						String ptype = (String) mp.get("PTYPE");
						if(ptype.equals(id)){
					%>
					<input type="checkbox" name="roleprivelege" value="<%=mp.get("PCODE") %>" /><%=mp.get("PNAME") %>
					&nbsp;
					<% 
						}
					}}
					%>
				</fieldset>
				<% 
					}
				}
				%>
				
			</td>
		</tr>
		<tr>
			<td class="thx">操作</td>
			<td><input type="checkbox" name="mycheck" onclick="selcheck('mycheck')" /> 全/反选</td>
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

	<script>
    	$(function(){
    		$("input[name=roleprivelege]").click(function(){
				if($(this).attr("checked")){
					$(this).siblings("legend").children(".ptitle").attr("checked",true);
				}
			});
    	});
    </script>

    <% 
    }
    %>
    
    
    
    <% 
	if("load".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("adminrole");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改管理员角色信息</li>
    </ul>
    
    <br />
	<font color="red"><b>修改管理员角色信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/adminrole.do?action=add">创建管理员角色</a>
		<a href="system/adminrole.do?action=list">管理管理员角色</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/adminrole.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">用户名</td>
    		<td><input type="text" class="validate[required] txt readonly" maxlength="20" name="rolename" value="<%=map.get("ROLENAME") %>" />  </td>
    	</tr>
    	<tr>
			<td class="thx">角色备注</td>
			<td><input type="text" class="txt" name="remark" maxlength="20" value="<%=map.get("REMARK") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">角色权限</td>
			<td>
				<% 
				@SuppressWarnings("unchecked")
				List<Map> menu = (List) request.getAttribute("menu");
				@SuppressWarnings("unchecked")
				List<Map> list = (List) request.getAttribute("list");
				
				if(menu!=null){
					for(Map<String,String> m : menu){
						String mid = (String) m.get("ID");
				%>
				<fieldset>
					<legend>
						<input type="checkbox" name="roleprivelege" class="ptitle" value="<%=m.get("PCODE") %>" /><%=m.get("PNAME") %>
					</legend>
					<%
					if(list!=null){ 
					for(Map<String,String> mp : list){
						String ptype = (String) mp.get("PTYPE");
						if(ptype.equals(mid)){
					%>
					<input type="checkbox" name="roleprivelege" value="<%=mp.get("PCODE") %>" /><%=mp.get("PNAME") %>
					&nbsp;
					<% 
						}
					}}
					%>
				</fieldset>
				<% 
					}
				}
				%>
			</td>
		</tr>
		<tr>
			<td class="thx">操作</td>
			<td><input type="checkbox" name="mycheck" onclick="selcheck('mycheck')" /> 全/反选</td>
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
    <script>
    	var prs = '<%=map.get("ROLEPRIVELEGE") %>';
    	$(function(){
    		$("input[name=roleprivelege]").val(prs.split("#"));

			$("input[name=roleprivelege]").click(function(){
				if($(this).attr("checked")){
					$(this).siblings("legend").children(".ptitle").attr("checked",true);
				}
			});
    	});
    </script>
    <% 
    }
    }
    %>
	
	
	
	<% 
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>角色管理</li>
    </ul>
    
    <br />
	系统角色管理，选择角色进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/adminrole.do?action=add">创建管理员角色</a>
		<a href="system/adminrole.do?action=list" class="on">管理管理员角色</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">角色名称</th>
			<th>备注信息</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("ROLENAME") %></td>
				<td><%=map.get("REMARK") %></td>
				<td><%=map.get("CDATE") %></td>
				<td>
					<a href="system/adminrole.do?action=load&id=<%=map.get("ID") %>" title="修改角色"><img src="skins/images/icons/role_mod.png" border="0" align="absmiddle" /></a>
					&nbsp;
					<a href="system/adminrole.do?action=delete&id=<%=map.get("ID") %>" title="删除角色" onclick="return window.confirm('删除角色会影响该角色管理员的系统使用\n且删除操作无法恢复，请谨慎操作。\n\n确定要删除吗?');"><img src="skins/images/icons/role_del.png" border="0" align="absmiddle" /></a> 
				</td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="6"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	
	<% 
	}
	%>
	
	
	
	
	
	

</body>
</html>


