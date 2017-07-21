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
		<li>创建题库</li>
    </ul>
    
    <br />
	填写下列基本信息，创建题库。<br/>
	<div class="buttons">
		<a href="system/db.do?action=add" class="on">创建题库</a>
		<a href="system/db.do?action=list">管理题库</a>
	</div>
    
    <br /><br />
    <form action="system/db.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">题库名称</td>
    		<td><input type="text" class="validate[required] txt" maxlength="20" name="dname" />  </td>
    	</tr>
		<tr>
			<td class="thx">题库状态</td>
			<td>
				<select name="status">
					<option value="1">正常</option>
					<option value="-1">锁定</option>
				</select>
			</td>
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
				<input type="hidden" value="<%=session.getAttribute("TomUserId") %>" name="adminid" />
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
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("db");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改题库信息</li>
    </ul>
    
    <br />
	<font color="red"><b>修改题库信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/db.do?action=add">创建题库</a>
		<a href="system/db.do?action=list">管理题库</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/db.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">题库名称</td>
    		<td><input type="text" class="validate[required] txt" maxlength="20" name="dname" value="<%=map.get("DNAME") %>" />  </td>
    	</tr>
		<tr>
			<td class="thx">题库状态</td>
			<td>
				<select name="status">
					<% 
					String STATUS = "" + map.get("STATUS");
					%>
					<option value="1" <%="1".equals(STATUS)?"selected":"" %>>正常</option>
					<option value="-1" <%="-1".equals(STATUS)?"selected":"" %>>锁定</option>
				</select>
			</td>
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
				<input type="hidden" value="<%=map.get("ADMINID") %>" name="adminid" />
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
		<li>管理题库</li>
    </ul>
    
    <br />
	管理题库，选择题库进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/db.do?action=add">创建题库</a>
		<a href="system/db.do?action=list" class="on">管理题库</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">题库名称</th>
			<th>创建人</th>
			<th>试题数量</th>
			<th>状态</th>
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
				<td><%=map.get("DNAME") %></td>
				<td><%=map.get("USERNAME") %></td>
				<td><%=map.get("QUESTION_NUMS") %></td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"正常":"-1".equals(_STATUS)?"<font color='red'>锁定</font>":"未知状态");
					%>
				</td>
				<td><%=map.get("CDATE") %></td>
				<td>
					<a href="system/db.do?action=load&id=<%=map.get("ID") %>" title="修改题库"><img src="skins/images/icons/db_mod.png" border="0" align="absmiddle" /></a>
					&nbsp;
					<a href="system/db.do?action=delete&id=<%=map.get("ID") %>" title="删除题库" 
					onclick="return window.confirm('您即将要删除题库，这会影响到题库中的试题与相关联的试卷。\n而且，删除操作无法恢复，确定要删除吗?');"><img src="skins/images/icons/db_delete.png" border="0" align="absmiddle" /></a> 
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


