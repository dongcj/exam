<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,net.fckeditor.*"  %>
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
	<script src="fckeditor/fckeditor.js"></script>
	<%
		FCKeditor fckEditor = new FCKeditor(request, "content");
	%>
	<title>HCF exam</title>
</head>
<body class="body">

	
	<% 
	if("add".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>创建文章</li>
    </ul>
    
    <br />
	填写下列基本信息，创建文章。<br/>
	<div class="buttons">
		<a href="system/news.do?action=add" class="on">创建文章</a>
		<a href="system/news.do?action=list">管理文章</a>
	</div>
    
    <br /><br />
    <form action="system/news.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
			<td width="100" class="thx">标题</td>
			<td class="aleft">
				<input type="text" class="validate[required] txt" maxlength="100" size="90" name="title" style="width:350px"  />
				&nbsp;
				标题颜色：
				<select name="title_color" id="title_color" style="width:70px">
					<% 
					Map<String,String> mc = com.tom.util.SystemCode.COLORS;
					%>
					<%for(Object o : mc.keySet()){ %>
					<option value="<%=mc.get(o) %>" style="color:#<%=mc.get(o) %>" <%="000000".equals(mc.get(o))?"selected":"" %>><%=o %></option>
					<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">所在栏目</td>
			<td>
			<select name="classid" class="validate[required]">
			<% 
			@SuppressWarnings("unchecked")
			List<Map<String,Object>> list = (List) request.getAttribute("CLIST");
			if(list!=null && list.size()>0){
			for(Map<String,Object> m : list){
			%>
	             <option value="<%=m.get("ID") %>"><%=m.get("CNAME") %></option>
	        <% 
	        }}
	        %>
	        </select>
			</td>
		</tr>
		<tr>
			<td class="thx">
				缩略图
			</td>
			<td>
				<input type="hidden" class="txt" name="photo" size="30" id="photo"  />
				<img src="" alt="" style="display:none;width:100px" id="img_photo" /> 
				<iframe id="d_file" frameborder=0 src="inc/upload/postfile.html" width="260"  height="22" scrolling="no"></iframe>
				<a href="javascript:;" onclick="$get('photo').value='';$get('img_photo').style.display='none';" ><u>清除图像</u></a>
			</td>
		</tr>
		<tr>
			<td class="thx">外部链接</td>
			<td>
				<input name="outlink" type="text" class="txt" size="80" style="width:505px" />
			</td>
		</tr>
		<tr>
			<td class="thx">文章概要</td>
			<td> <textarea name="summary" rows="3" cols="40" style="height:60px;width:500px"></textarea></td>
		</tr>
		<tr>
			<td class="thx">文章内容</td>
			<td>
				<%
					fckEditor.setValue("<p></p>");
					fckEditor.setWidth("800px");
					fckEditor.setHeight("400px");
					out.println(fckEditor);
				%>
			</td>
		</tr>
		<tr>
			<td class="thx">相关属性</td>
			<td>
				<select name="status">
					<option value="1">=审核通过=</option>
					<option value="0">=待审核=</option>
				</select>
				<select name="totop">
					<option value="0">=不置顶=</option>
					<option value="1">=置顶=</option>
				</select>
				访问量 <input name="visit" type="text" class="validate[custom[onlyNumber]] txtfree" size="2" value="0" />
				作者 <input name="author" type="text" class="txtfree" size="5" value="本站" />
				来源 <input name="newsfrom" type="text" class="txtfree" size="5" value="本站" />
	            <input type="hidden" value="<%=session.getAttribute("TomUserId") %>" name="adminid" />
			</td>
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
    <br/><br/><br/>
    <% 
    }
    %>
    
    
    
    <% 
	if("load".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("news");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改文章</li>
    </ul>
    
    <br />
	<font color="red"><b>修改文章内容，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/news.do?action=add">创建文章</a>
		<a href="system/news.do?action=list">管理文章</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/news.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
			<td width="100" class="thx">标题</td>
			<td class="aleft">
				<input type="text" class="validate[required] txt" maxlength="100" value="<%=map.get("TITLE") %>" size="90" name="title" style="width:350px"  />
				&nbsp;
				标题颜色：
				<select name="title_color" id="title_color" style="width:70px">
					<% 
					Map<String,String> mc = com.tom.util.SystemCode.COLORS;
					%>
					<%for(Object o : mc.keySet()){ %>
					<option value="<%=mc.get(o) %>" style="color:#<%=mc.get(o) %>"><%=o %></option>
					<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">所在栏目</td>
			<td>
			<select name="classid" id="classid" class="validate[required]">
			<% 
			@SuppressWarnings("unchecked")
			List<Map<String,Object>> list = (List) request.getAttribute("CLIST");
			if(list!=null && list.size()>0){
			for(Map<String,Object> m : list){
			%>
	             <option value="<%=m.get("ID") %>"><%=m.get("CNAME") %></option>
	        <% 
	        }}
	        %>
	        </select>
			</td>
		</tr>
		<tr>
			<td class="thx">
				缩略图
			</td>
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
			<td class="thx">外部链接</td>
			<td>
				<input name="outlink" type="text" class="txt" size="80" style="width:505px"  value="<%=map.get("OUTLINK") %>"/>
			</td>
		</tr>
		<tr>
			<td class="thx">文章概要</td>
			<td> <textarea name="summary" rows="3" cols="40" style="height:60px;width:500px"><%=map.get("SUMMARY") %></textarea></td>
		</tr>
		<tr>
			<td class="thx">文章内容</td>
			<td>
				<%
					fckEditor.setValue(""+map.get("CONTENT"));
					fckEditor.setWidth("800px");
					fckEditor.setHeight("400px");
					out.println(fckEditor);
				%>
			</td>
		</tr>
		<tr>
			<td class="thx">相关属性</td>
			<td>
				<select name="status" id="status">
					<option value="1">=审核通过=</option>
					<option value="0">=待审核=</option>
				</select>
				<select name="totop" id="totop">
					<option value="0">=不置顶=</option>
					<option value="1">=置顶=</option>
				</select>
				访问量 <input name="visit" type="text" class="validate[custom[onlyNumber]] txtfree" size="2" value="<%=map.get("VISIT") %>" />
				作者 <input name="author" type="text" class="txtfree" size="5" value="<%=map.get("AUTHOR") %>" />
				来源 <input name="newsfrom" type="text" class="txtfree" size="5" value="<%=map.get("NEWSFROM") %>" />
	            <input type="hidden" value="<%=map.get("ADMINID") %>" name="adminid" />
			</td>
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
    	$("#classid").val('<%=map.get("CLASSID") %>');
    	$("#status").val('<%=map.get("STATUS") %>');
    	$("#totop").val('<%=map.get("TOTOP") %>');
    	$("#title_color").val('<%=map.get("TITLE_COLOR") %>');
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
		<li>文章管理</li>
    </ul>
    
    <br />
	文章管理，选择文章进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/news.do?action=add">创建文章</a>
		<a href="system/news.do?action=list" class="on">管理文章</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">ID</th>
			<th>标题</th>
			<th>缩略图</th>
			<th>栏目</th>
			<th>作者</th>
			<th>人气</th>
			<th>发布时间</th>
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
				<td><%=map.get("TITLE") %></td>
				<td>
					<%
					String photo = (String) map.get("PHOTO");
					if(photo!=null && photo.length()>5){ %>
						<a href="<%=photo %>" class="tooltips" target="_blank"><img src="<%=photo %>" height="25" border="0" /><span><img src="<%=photo %>" height="200" border="0" /></span></a>
					<%}%>
				</td>
				<td><%=map.get("CNAME") %></td>
				<td><%=map.get("AUTHOR") %></td>
				<td><%=map.get("VISIT") %></td>
				<td><%=map.get("POSTDATE") %></td>
				<td>
					<a href="system/news.do?action=load&id=<%=map.get("ID") %>" title="修改文章"><img src="skins/images/icons/news_mod.png" border="0" align="absmiddle" /></a>
					&nbsp;
					<a href="system/news.do?action=delete&id=<%=map.get("ID") %>" title="删除文章" onclick="return window.confirm('确定要删除吗?');"><img src="skins/images/icons/news_delete.png" border="0" align="absmiddle" /></a> 
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


