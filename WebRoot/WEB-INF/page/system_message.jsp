<%@ page language="java" import="java.util.*,com.tom.util.SystemCode" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String key = (String) request.getAttribute("smsg");
	String surl = (String) request.getAttribute("surl");
	String usertype = (String) session.getAttribute("TomUserType");
	String aurl = "1".equals(usertype)?"system":"user";
	%>
	<base href="<%=basePath%>" />
    <title>系统提示</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<script src="inc/util.js" type="text/javascript"></script>

    <%if(!"NO_PRIVELEGE".equals(key) && !"NO_COPYRIGHT".equals(key) && !"SY_AUTHOVER".equals(key)){ %>
	<meta http-equiv="refresh" content="5;URL=<%=surl %>" />
	<%} %>

	<style>
		*{font-size:12px;}
		input.btn{border:solid 1px #666; border-left:solid 1px #ccc; 
			  border-top:solid 1px #ccc; background:#ddd; padding:2px 10px; cursor:hand; height:25px}
		.btn{
			display:block; float:left; margin:0 7px 0 0; background-color:#eee;
			border:1px solid #aaa; border-top:1px solid #eee; border-left:1px solid #eee;color:#565656;
			padding:3px 10px;text-decoration:none
		}
	</style>
	<% 
	
	%>
	
  </head>
  <body>
    	<br/><br/><br/>
    	<table border="0" cellpadding="5" cellspacing="1" width="400" align="center" class="stable">
    		<tr>
    			<th colspan="2">系统提示</th>
    		</tr>
    		<tr>
    			<td width="30%" style="background:#ffffff;text-align:right"><img src="skins/images/info.png" style="margin-right:20px"></td>
    			<td style="height:200px;text-align:left;font-size:14px;line-height:150%">
    				<%
    				out.println(SystemCode.getSystemInfo(key));
					%>
    				<br/><br/>
    				<%if(!"NO_PRIVELEGE".equals(key) && !"NO_COPYRIGHT".equals(key) && !"SY_AUTHOVER".equals(key)){ %>
					<div style="clear:both"><a href="<%=aurl+"/"+surl %>" class="btn">立即跳转</a></div>
					<%}else{ %>
					<div style="clear:both"><a href="javascript:;" onclick="history.go(-1);" class="btn">立即跳转</a></div>
					<%} %>
					<div style="clear:both">3秒后自动跳转</div>
    				
    			</td>
    		</tr>
    	</table>
    	
    
  </body>
</html>
