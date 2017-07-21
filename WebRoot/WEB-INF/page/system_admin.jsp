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
		<li>创建管理员</li>
    </ul>
    
    <br />
	填写下列基本信息，创建系统管理员。<br/>
	<div class="buttons">
		<a href="system/admin.do?action=add" class="on">创建管理员</a>
		<a href="system/admin.do?action=list">管理管理员</a>
	</div>
    
    <br /><br />
    <form action="system/admin.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">用户名</td>
    		<td><input type="text" class="validate[required,length[3,20]] txt" maxlength="20" name="username" />  </td>
    	</tr>
    	<tr>
			<td class="thx">密码</td>
			<td><input type="password" class="validate[required] txt" name="userpass" id="userpass" maxlength="30" /> </td>
		</tr>
		<tr>
			<td class="thx">确认密码</td>
			<td><input type="password" class="validate[required,confirm[userpass]] txt" name="userpass2" maxlength="30" /> </td>
		</tr>
		<tr>
			<td class="thx">管理员角色</td>
			<td>
				<select name="roleid" class="validate[required]">
					<option value="">--选择角色--</option>
					<% 
					@SuppressWarnings("unchecked")
					List<Map> ADMIN_ROLES = (List) request.getAttribute("ADMIN_ROLES");
					if(ADMIN_ROLES!=null && ADMIN_ROLES.size()>0){
						for(Map<String,Object> map : ADMIN_ROLES){
					%>
					<option value="<%=map.get("ID") %>"><%=map.get("ROLENAME") %></option>
					<% 
						}
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">用户状态</td>
			<td>
				<select name="status">
					<option value="1">正常</option>
					<option value="-1">锁定</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">真实姓名</td>
			<td><input type="text" class="validate[required] txt" name="realname" maxlength="10"  /> </td>
		</tr>
		<tr>
			<td class="thx">联系电话</td>
			<td><input type="text" class="txt" name="mobi" maxlength="20"  /> </td>
		</tr>
		<tr>
			<td class="thx">备注</td>
			<td><textarea rows="5" cols="40" name="remark" class="txt"></textarea> </td>
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
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("admin");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改管理员</li>
    </ul>
    
    <br />
	<font color="red"><b>修改管理员信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/admin.do?action=add">创建管理员</a>
		<a href="system/admin.do?action=list">管理管理员</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/admin.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">用户名</td>
    		<td><input type="text" class="validate[required,length[3,20]] txt readonly" readonly="readonly" maxlength="20" name="username" value="<%=map.get("USERNAME") %>" />  </td>
    	</tr>
    	<tr>
			<td class="thx">密码</td>
			<td><input type="password" class="txt" name="userpass" id="userpass" maxlength="30" /> 不修改请留空 </td>
		</tr>
		<tr>
			<td class="thx">确认密码</td>
			<td><input type="password" class="validate[confirm[userpass]] txt" name="userpass2" maxlength="30" /> </td>
		</tr>
		<tr>
			<td class="thx">管理员角色</td>
			<td>
				<select name="roleid" class="validate[required]">
					<option value="">--选择角色--</option>
					<% 
					String ROLEID = "" + map.get("ROLEID");
					@SuppressWarnings("unchecked")
					List<Map> ADMIN_ROLES = (List) request.getAttribute("ADMIN_ROLES");
					if(ADMIN_ROLES!=null && ADMIN_ROLES.size()>0){
						for(Map<String,Object> m : ADMIN_ROLES){
							String rid = "" + m.get("ID");
					%>
					<option value="<%=m.get("ID") %>" <%=ROLEID.equals(rid)?"selected":"" %>><%=m.get("ROLENAME") %></option>
					<% 
						}
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">用户状态</td>
			<td>
				<% 
				String STATUS = "" + map.get("STATUS");
				%>
				<select name="status">
					<option value="1" <%="1".equals(STATUS)?"selected":"" %>>正常</option>
					<option value="-1" <%="-1".equals(STATUS)?"selected":"" %>>锁定</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">真实姓名</td>
			<td><input type="text" class="validate[required] txt" name="realname" maxlength="10" value="<%=map.get("REALNAME") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">联系电话</td>
			<td><input type="text" class="txt" name="mobi" maxlength="20" value="<%=map.get("MOBI") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">备注</td>
			<td><textarea rows="5" cols="40" name="remark" class="txt"><%=map.get("REMARK") %></textarea> </td>
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
		<li>管理员</li>
    </ul>
    
    <br />
	系统管理员管理，选择管理员进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/admin.do?action=add">创建管理员</a>
		<a href="system/admin.do?action=list" class="on">管理管理员</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">用户名</th>
			<th>姓名</th>
			<th>角色</th>
			<th>状态</th>
			<th>联系电话</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><b><%=map.get("USERNAME") %></b></td>
				<td><i><%=map.get("REALNAME") %></i></td>
				<td><%=map.get("ROLENAME")!=null?map.get("ROLENAME"):"<font color='red'>角色丢失</font>" %></td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"正常":"-1".equals(_STATUS)?"<font color='red'>锁定</font>":"未知状态");
					%>
				</td>
				<td><%=map.get("MOBI") %></td>
				<td>
					<a href="system/admin.do?action=load&id=<%=map.get("ID") %>" title="修改管理员"><img src="skins/images/icons/admin_mod.png" border="0" align="absmiddle" /></a>
					&nbsp;
					<a href="system/admin.do?action=delete&id=<%=map.get("ID") %>" title="删除管理员" onclick="return window.confirm('确定要删除吗?');"><img src="skins/images/icons/admin_del.png" border="0" align="absmiddle" /></a> 
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
	
	
	
	<% 
	if("profile".equals(action)){
		String id = (String) session.getAttribute("TomUserId");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("profile");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>更新个人资料</li>
    </ul>
    
    <br />
	<font color="red"><b>更新个人资料，操作不可还原，请谨慎操作。</b></font>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/admin.do?action=update&id=<%=id %>&op=profile" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">用户名</td>
    		<td><input type="text" class="validate[required,length[3,20]] txt readonly" readonly="readonly" maxlength="20" name="username" value="<%=map.get("USERNAME") %>" />  </td>
    	</tr>
    	<tr>
			<td class="thx">密码</td>
			<td><input type="password" class="txt" name="userpass" id="userpass" maxlength="30" /> 不修改请留空 </td>
		</tr>
		<tr>
			<td class="thx">确认密码</td>
			<td><input type="password" class="validate[confirm[userpass]] txt" name="userpass2" maxlength="30" /> </td>
		</tr>
		<tr>
			<td class="thx">管理员角色</td>
			<td>
				<%=request.getAttribute("ROLENAME") %>
			</td>
		</tr>
		<tr>
			<td class="thx">用户状态</td>
			<td>
				<% 
				String _STATUS = "" + map.get("STATUS");
				out.println("1".equals(_STATUS)?"正常":"-1".equals(_STATUS)?"<font color='red'>锁定</font>":"未知状态");
				%>
			</td>
		</tr>
		<tr>
			<td class="thx">真实姓名</td>
			<td><input type="text" class="validate[required] txt" name="realname" maxlength="10" value="<%=map.get("REALNAME") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">联系电话</td>
			<td><input type="text" class="txt" name="mobi" maxlength="20" value="<%=map.get("MOBI") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">备注</td>
			<td><textarea rows="5" cols="40" name="remark" class="txt"><%=map.get("REMARK") %></textarea> </td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" name="status" value="<%=map.get("STATUS") %>" />
				<input type="hidden" name="roleid" value="<%=map.get("ROLEID") %>" />
			</td>
		</tr>
    </table>
    </form>
    <% 
    }
    }
    %>
    
    
    
    
	
	
	
	

</body>
</html>


