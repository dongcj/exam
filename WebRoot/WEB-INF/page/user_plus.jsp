<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map"  %>
<%@ page import="com.tom.util.Util"  %>
<%@ page import="com.tom.util.SystemCode"  %>
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
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<style>
		.plus{ width:200px; float:left; margin:0 10px 10px 0;}
		.plus tr th {background:#fff;width:50px;}
		.plus tr th a img{border:solid 1px #fff; padding:2px; height:40px; width:40px}
		.plus tr th a:hover img{border:solid 1px #ddd;}
		.plus tr td{height:60px}
		.plus tr td b{font-size:10pt;}
		.plus tr td div{}
	</style>
	<title>HCF exam</title>
</head>
<body class="body">
	
	
	
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>应用大厅</li>
    </ul>
    
    <br />
	
	<% 
	
	%>
	<table class="stable2 mtop20" width="100%" cellpadding="5px">
		<tr>
			<td>
				<%
				@SuppressWarnings("unchecked")
				List<Map> list = (List) request.getAttribute("list");
				if(list!=null && list.size()>0){
					for(Map<String,Object> map : list){

						String photo = (String) map.get("PHOTO");
						if(photo==null || photo.length()<5) photo = "skins/images/fav.png";
						String pdesc = (String) map.get("PDESC");
						String pname = (String) map.get("PNAME");
				%>
				<table class="stable plus">
					<tr>
						<th><a href="<%=map.get("VURL") %>"><img src="<%=photo %>" /></a></th>
						<td valign="top">
							<b><a href="<%=map.get("VURL") %>"><%=Util.splitString(pname,8) %></a></b><br/>
							<div><%=Util.splitString(pdesc,18) %>..</div>
						</td>
					</tr>
				</table>
				<%
					} 
				}
				%>
			</td>
		</tr>
	</table>
	
	
	
	<table class="stable2" width="100%" cellpadding="5px">
		<tr>
			<td style="padding:5px 0px"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	
	<br/><br/>
	
	
</body>
</html>


