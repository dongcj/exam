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
	<title>HCF Exam</title>
</head>
<body class="body">

	
    <% 
	if("profile".equals(action)){
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("user");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改个人信息</li>
    </ul>
    
    <br />
	<font color="red">修改个人信息，该操作不可还原，且用户状态会 <b><u>重置为“待审核”</u></b>，请谨慎操作。</font><br/>
    
    <% 
    if( map != null ){
    %>
    <br />
    <form action="user/my.do?action=update" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">工号</td>
    		<td><input type="text" class="validate[required] txt readonly" readonly="readonly" value="<%=map.get("USERNO") %>" maxlength="20" name="userno" />  </td>
    	</tr>
		<tr>
			<td class="thx">身份证号码</td>
			<td><input type="text" class="validate[required] txt readonly" readonly="readonly" name="sfzhm" value="<%=map.get("SFZHM") %>" maxlength="20"  /> </td>
		</tr>
    	<tr>
    		<td width="80" class="thx">用户名</td>
    		<td><input type="text" class="validate[required] txt readonly" readonly="readonly" value="<%=map.get("USERNAME") %>" maxlength="20" name="username" />  </td>
    	</tr>
		<tr>
			<td class="thx">密码</td>
			<td><input type="password" class="txt" name="userpass" id="userpass" maxlength="20"  />  不修改请留空 </td>
		</tr>
		<tr>
			<td class="thx">确认密码</td>
			<td><input type="password" class="validate[confirm[userpass]] txt" name="userpass2" maxlength="30" /> </td>
		</tr>
		<tr>
			<td class="thx">形象照片</td>
			<td>
				<% 
				String photo = (String) map.get("PHOTO");
				%>
				<input type="hidden" class="txt" name="photo" size="30" id="photo" value="<%=photo %>"  />
				<% if(photo!=null && !"null".equals(photo) && photo.length()>5){ %>
					<img src="<%=photo %>" alt="" style="width:100px" id="img_photo" /> 
				<%}else{%>
					<img src="" alt="" style="display:none;width:100px" id="img_photo" /> 
				<%} %>
				<br/>
				<iframe id="d_file" frameborder=0 src="inc/upload/postfile.html" width="260"  height="22" scrolling="no"></iframe>
				<a href="javascript:;" onclick="$get('photo').value='';$get('img_photo').style.display='none';" ><u>清除图像</u></a>
				
			</td>
		</tr>
		<tr>
			<td class="thx">状态</td>
			<td> 
				<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"正常":"-1".equals(_STATUS)?"<font color='red'>锁定</font>":"0".equals(_STATUS)?"<b>待审核</b>":"<b>未知</b>");
				%>
				<input type="hidden" name="status" value="0" />
			</td>
		</tr>
		<tr>
			<td class="thx">用户分组</td>
			<td><%=map.get("GROUPNAME") %><input type="hidden" name="gid" value="<%=map.get("GID") %>" /></td>
		</tr>
		<tr>
			<td class="thx">真实姓名</td>
			<td><input type="text" class="txt" name="realname" maxlength="20" value="<%=map.get("REALNAME") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">邮箱</td>
			<td><input type="text" class="txt" name="email" maxlength="20" value="<%=map.get("EMAIL") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">联系电话</td>
			<td><input type="text" class="txt" name="mobi" maxlength="20" value="<%=map.get("MOBI") %>"  /> </td>
		</tr>
		<tr>
			<td class="thx">备注信息</td>
			<td><input type="text" class="txt" name="remark" maxlength="20" value="<%=map.get("REMARK") %>" /> </td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" onclick="return window.confirm('您确定要修改个人资料吗？该操作可能需要重新审核您的信息。');" />
				<input type="reset" value=" 重 置 " class="btn" />
			</td>
		</tr>
    </table>
    </form>
    <br/><br/>
    <% 
    }
    }
    %>
	
	
	
	

</body>
</html>


