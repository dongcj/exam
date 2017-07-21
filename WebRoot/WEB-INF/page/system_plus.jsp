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
		<li>增加插件</li>
    </ul>
    
    <br />
	插件是将第三方模块加入系统的一种方式，如万年历插件，填写下列基本信息，增加插件。<br/>
	<div class="buttons">
		<a href="system/plus.do?action=add" class="on">增加插件</a>
		<a href="system/plus.do?action=list">管理插件</a>
	</div>
    
    <br /><br />
    <form action="system/plus.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">插件名称</td>
    		<td><input type="text" class="validate[required] txtfree" size="50" maxlength="40" name="pname" />  </td>
    	</tr>
		<tr>
			<td class="thx">插件状态</td>
			<td>
				<select name="status">
					<option value="1">正常</option>
					<option value="-1">锁定</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">插件描述</td>
			<td><textarea rows="5" cols="40" name="pdesc" class="txt"></textarea> </td>
		</tr>
		<tr>
			<td class="thx">插件图标</td>
			<td>
				<input type="hidden" class="txt" name="photo" size="30" id="photo"  />
				<img src="" alt="" style="display:none;width:100px" id="img_photo" /> 
				<iframe id="d_file" frameborder=0 src="inc/upload/postfile.html" width="260"  height="22" scrolling="no"></iframe>
				<a href="javascript:;" onclick="$get('photo').value='';$get('img_photo').style.display='none';" ><u>清除图像</u></a>
			</td>
		</tr>
		<tr>
			<td class="thx">访问地址</td>
			<td><input type="text" class="validate[required] txtfree" size="50" maxlength="100" name="vurl" /> 如：plug-ins/calendar/calendar.html</td>
		</tr>
		<tr>
			<td class="thx">插件路径</td>
			<td><input type="text" class="validate[required] txtfree" size="50" maxlength="100" name="purl" /> 如：plug-ins/calendar/</td>
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
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("plus");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改模块信息</li>
    </ul>
    
    <br />
	<font color="red"><b>修改模块信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/plus.do?action=add">增加插件</a>
		<a href="system/plus.do?action=list">管理插件</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/plus.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">插件名称</td>
    		<td><input type="text" class="validate[required] txtfree" size="50" maxlength="40" name="pname" value="<%=map.get("PNAME") %>" />  </td>
    	</tr>
		<tr>
			<td class="thx">插件状态</td>
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
			<td class="thx">插件描述</td>
			<td><textarea rows="5" cols="40" name="pdesc" class="txt"><%=map.get("PDESC") %></textarea> </td>
		</tr>
		<tr>
			<td class="thx">插件图标</td>
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
				<iframe id="d_file" frameborder=0 src="inc/upload/postfile.html" width="260"  height="22" scrolling="no"></iframe>
				<a href="javascript:;" onclick="$get('photo').value='';$get('img_photo').style.display='none';" ><u>清除图像</u></a>
			</td>
		</tr>
		<tr>
			<td class="thx">访问地址</td>
			<td><input type="text" class="validate[required] txtfree" size="50" maxlength="100" name="vurl" value="<%=map.get("VURL") %>" /> 如：plug-ins/calendar/calendar.html</td>
		</tr>
		<tr>
			<td class="thx">插件路径</td>
			<td><input type="text" class="validate[required] txtfree" size="50" maxlength="100" name="purl" value="<%=map.get("PURL") %>" /> 如：plug-ins/calendar/</td>
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
		<li>管理插件</li>
    </ul>
    
    <br />
	管理插件，选择插件进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/plus.do?action=add">增加插件</a>
		<a href="system/plus.do?action=list" class="on">管理插件</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">插件名称</th>
			<th>缩略图</th>
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
				<td><%=map.get("PNAME") %></td>
				<td>
					<%
					String photo = (String) map.get("PHOTO");
					if(photo!=null && photo.length()>5){ %>
						<a href="<%=photo %>" class="tooltips" target="_blank"><img src="<%=photo %>" height="25" border="0" /><span><img src="<%=photo %>" height="200" border="0" /></span></a>
					<%}%>
				</td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"正常":"-1".equals(_STATUS)?"<font color='red'>锁定</font>":"未知状态");
					%>
				</td>
				<td><%=map.get("CDATE") %></td>
				<td>
					<a href="system/plus.do?action=load&id=<%=map.get("ID") %>" title="修改插件"><img src="skins/images/icons/plus_mod.png" border="0" align="absmiddle" /></a>
					&nbsp;
					<a href="system/plus.do?action=delete&id=<%=map.get("ID") %>" title="删除插件" onclick="return window.confirm('删除操作无法恢复，您即将要删除插件吗？');"><img src="skins/images/icons/plus_delete.png" border="0" align="absmiddle" /></a> 
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


