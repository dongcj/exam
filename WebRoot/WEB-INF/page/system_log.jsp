<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,com.tom.util.SystemCode"  %>
<% 
String action = (String) request.getParameter("action");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String ss_logtime = (String)request.getParameter("s_logtime");
	ss_logtime = ss_logtime == null ? "" : ss_logtime;
	%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/nav.css" />
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/wdatepicker/WdatePicker.js"></script>
	<title>HCF exam</title>
	<script>
		$(function(){
			$("select[name=s_logtype]").val('<%=request.getParameter("s_logtype") %>');
			$("input[name=s_logtime]").val('<%=ss_logtime %>');
		});
	</script>
</head>
<body class="body">

	
	<% 
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>系统日志</li>
    </ul>
    
	<br />
	<table class="stable" width="100%" align="center">
		<tr>
			<td>
				<form action="system/log.do" method="get">
					
					日志类型：<select name="s_logtype" style="width:100px">
						<option value="">=日志类型=</option>
						<option value="1">登陆日志</option>
					</select>

					日志时间：<input type="text" class="txt readonly" style="width:100px" readonly="readonly" name="s_logtime" id="s_logtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />

					<input type="submit" value="搜索" class="btn" />
					<input type="hidden" name="action" value="list" />
				</form>
			</td>
		</tr>
	</table>
	
	
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">编号</th>
			<th>日志类型</th>
			<th>用户</th>
			<th>日志时间</th>
			<th>IP</th>
			<th>备注</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("ID") %></td>
				<td><%=SystemCode.getLogType(String.valueOf(map.get("LOGTYPE"))) %></td>
				<td><%=map.get("USERNAME") %></td>
				<td><%=map.get("LOGTIME") %></td>
				<td><%=map.get("IP") %></td>
				<td><%=map.get("REMARK") %></td>
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


