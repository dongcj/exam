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
	if("add_newstype".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>创建文章分类</li>
    </ul>
    
    <br />
	填写下列基本信息，创建文章分类。<br/>
	<div class="buttons">
		<a href="system/news.do?action=add_newstype" class="on">创建分类</a>
		<a href="system/news.do?action=list_newstype">管理分类</a>
	</div>
    
    <br /><br />
    <form action="system/news.do?action=save_newstype" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
			<td width="80" class="thx">分类名称</td>
			<td class="aleft">
				<input type="text" class="validate[required] txt" maxlength="20" size="90" name="cname" style="width:300px"  />
			</td>
		</tr>
		<tr>
			<td class="thx">备注</td>
			<td class="aleft">
				<input type="text" class="txt" maxlength="20" size="90" name="remark" style="width:300px"  />
			</td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" value="<%=session.getAttribute("TomUserId") %>" name="adminid" />
				<input type="hidden" value="0" name="parentid" />
				<input type="hidden" value="0" name="adminid" />
				<input type="hidden" value="0" name="orderid" />
			</td>
		</tr>
    </table>
    </form>
    <br/><br/><br/>
    <% 
    }
    %>
    
    
    
    <% 
	if("load_newstype".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("newstype");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改文章分类</li>
    </ul>
    
    <br />
	<font color="red"><b>修改文章分类，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/news.do?action=add_newstype">创建分类</a>
		<a href="system/news.do?action=list_newstype">管理分类</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/news.do?action=update_newstype&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
			<td width="80" class="thx">分类名称</td>
			<td class="aleft">
				<input type="text" class="validate[required] txt" maxlength="20" value="<%=map.get("CNAME") %>" name="cname" style="width:300px"  />
			</td>
		</tr>
		<tr>
			<td class="thx">备注</td>
			<td class="aleft">
				<input type="text" class="txt" maxlength="20" value="<%=map.get("REMARK") %>" name="remark" style="width:300px"  />
			</td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" value="<%=session.getAttribute("TomUserId") %>" name="adminid" />
				<input type="hidden" value="0" name="parentid" />
				<input type="hidden" value="0" name="adminid" />
				<input type="hidden" value="0" name="orderid" />
			</td>
		</tr>
    </table>
    </form>
    <% 
    }
    }
    %>
	
	
	
	<% 
	if("list_newstype".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>文章分类管理</li>
    </ul>
    
    <br />
	文章分类管理，选择分类进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/news.do?action=add_newstype">创建分类</a>
		<a href="system/news.do?action=list_newstype" class="on">管理分类</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">ID</th>
			<th>分类名称</th>
			<th>备注</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("ID") %></td>
				<td><%=map.get("CNAME") %></td>
				<td><%=map.get("REMARK") %></td>
				<td>
					<a href="system/news.do?action=load_newstype&id=<%=map.get("ID") %>">修改</a>
					-
					<a href="system/news.do?action=delete_newstype&id=<%=map.get("ID") %>" onclick="return window.confirm('确定要删除吗?');">删除</a> 
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


