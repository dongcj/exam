<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,com.tom.util.Util"  %>
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
	<script src="inc/system/user.js" type="text/javascript"></script>
	<title>HCF exam</title>
	<script>
		function batchopchange(obj){
			$("#batch_span").empty();
			if(obj.value=="3" || obj.value==3){
				$("select[name=s_gid]").clone().prependTo("#batch_span"); 
				$("#batch_span select").attr("class","validate[required]");
				$("#batch_span select").attr("name","s_gidx");
			}else if(obj.value=="2" || obj.value==2){
				$("select[name=s_status]").clone().prependTo("#batch_span");
				$("#batch_span select").attr("class","validate[required]");
				$("#batch_span select").attr("name","s_statusx");
			}
		}
	</script>

</head>
<body class="body">

	
	<% 
	if("add".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>增加用户</li>
    </ul>
    
    <br />
	填写下列基本信息，增加用户。<br/>
	<div class="buttons">
		<a href="system/user.do?action=add" class="on">增加用户</a>
		<a href="system/user.do?action=list">管理用户</a>
	</div>
    
    <br /><br />
    <form action="system/user.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">工号</td>
    		<td><input type="text" class="validate[required] txt" name="userno" maxlength="20" /> <span id="span_userno"></span></td>
    	</tr>
		<tr>
			<td class="thx">用户名</td>
			<td><input type="text" class="validate[required] txt" name="username" maxlength="20"  /> <span id="span_username"></span></td>
		</tr>
		<tr>
			<td class="thx">密码</td>
			<td><input type="text" class="validate[required] txt" name="userpass" maxlength="20"  /> </td>
		</tr>
    	<tr>
			<td class="thx">身份证号码</td>
			<td><input type="text" class="validate[required] txt" name="sfzhm" maxlength="20"  /> <span id="span_sfzhm"></span></td>
		</tr>
		<tr>
			<td class="thx">真实姓名</td>
			<td><input type="text" class="validate[required] txt" name="realname" maxlength="20"  /> </td>
		</tr>
		<tr>
			<td class="thx">形象照片</td>
			<td>
				<input type="hidden" class="txt" name="photo" size="30" id="photo"  />
				<img src="" alt="" style="display:none;width:100px" id="img_photo" /> 
				<iframe id="d_file" frameborder=0 src="inc/upload/postfile.html" width="260"  height="22" scrolling="no"></iframe>
				<a href="javascript:;" onclick="$get('photo').value='';$get('img_photo').style.display='none';" ><u>清除图像</u></a>
			</td>
		</tr>
		<tr>
			<td class="thx">状态</td>
			<td> 
				<select name="status">
					<option value="1">正常</option>
					<option value="0">待审核</option>
					<option value="-1">锁定</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">用户分组</td>
			<td>
				<select name="gid" class="validate[required]">
					<option value="">--选择分组--</option>
					<% 
					@SuppressWarnings("unchecked")
					List<Map> GROUPS = (List) request.getAttribute("GROUPS");
					if(GROUPS!=null && GROUPS.size()>0){
						for(Map<String,Object> m : GROUPS){
							%>
							<option value="<%=m.get("ID") %>"><%=m.get("GROUPNAME") %></option>
							<%
						}
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">邮箱</td>
			<td><input type="text" class="txt" name="email" maxlength="20"  /> </td>
		</tr>
		<tr>
			<td class="thx">联系电话</td>
			<td><input type="text" class="txt" name="mobi" maxlength="20"  /> </td>
		</tr>
		<tr>
			<td class="thx">备注信息</td>
			<td><input type="text" class="txt" name="remark" maxlength="20"  /> </td>
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
    <br/><br/>
    <% 
    }
    %>
    
    
    
    <% 
	if("load".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("user");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改用户信息</li>
    </ul>
    
    <br />
	<font color="red"><b>修改用户信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/user.do?action=add">增加用户</a>
		<a href="system/user.do?action=list">管理用户</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/user.do?action=update&id=<%=id %>" method="post">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">工号</td>
    		<td><input type="text" class="validate[required] txt readonly"value="<%=map.get("USERNO") %>" maxlength="20" name="userno" />  </td>
    	</tr>
		<tr>
			<td class="thx">用户名</td>
			<td><input type="text" class="validate[required] txt readonly" name="username" value="<%=map.get("USERNAME") %>" maxlength="20"  /> </td>
		</tr>
    	<tr>
			<td class="thx">身份证号码</td>
			<td><input type="text" class="validate[required] txt readonly" name="sfzhm" maxlength="20" value="<%=map.get("SFZHM") %>"/> <span id="span_sfzhm"></span></td>
		</tr>
		<tr>
			<td class="thx">密码</td>
			<td><input type="text" class="txt" name="userpass" id="userpass" maxlength="20"  />  不修改请留空 </td>
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
				<select name="status">
					<option value="1">正常</option>
					<option value="0">待审核</option>
					<option value="-1">锁定</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">用户分组</td>
			<td>
				<select name="gid" class="validate[required]">
					<option value="">--选择分组--</option>
					<% 
					@SuppressWarnings("unchecked")
					List<Map> GROUPS = (List) request.getAttribute("GROUPS");
					if(GROUPS!=null && GROUPS.size()>0){
						for(Map<String,Object> m : GROUPS){
							%>
							<option value="<%=m.get("ID") %>"><%=m.get("GROUPNAME") %></option>
							<%
						}
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">真实姓名</td>
			<td><input type="text" class="validate[required] txt" name="realname" maxlength="20" value="<%=map.get("REALNAME") %>"  /> </td>
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
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
			</td>
		</tr>
    </table>
    </form>
    <script>
    	var _status = "<%=map.get("STATUS") %>";
    	var _gid = "<%=map.get("GID") %>";
    </script>
    <br/><br/>
    <% 
    }
    }
    %>
	
	
	
	<% 
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>用户管理</li>
    </ul>
    
    <br />
	用户管理，选择用户查看信息，进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/user.do?action=add">增加用户</a>
		<a href="system/user.do?action=list" class="on">管理用户</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<td>
				<form action="system/user.do" method="get">
					<select name="s_gid" style="width:100px">
						<option value="">=选择分组=</option>
						<% 
						@SuppressWarnings("unchecked")
						List<Map> GROUPS = (List) request.getAttribute("GROUPS");
						if(GROUPS!=null && GROUPS.size()>0){
							for(Map<String,Object> m : GROUPS){
								%>
								<option value="<%=m.get("ID") %>"><%=m.get("GROUPNAME") %></option>
								<%
							}
						}
						%>
					</select>
					&nbsp;
					<select name="s_status" style="width:80px">
						<option value="">=状态=</option>
						<option value="1">正常</option>
						<option value="0">待审核</option>
						<option value="-1">锁定</option>
					</select>
					&nbsp;
					工号：<input type="text" class="txtfree" size="15" name="s_userno" />
					&nbsp;
					<!-- 用户名：<input type="text" class="txtfree" size="10" name="s_username" /> -->
					身份证号码：<input type="text" class="txtfree" size="10" name="s_sfzhm" />
					&nbsp;
					姓名：<input type="text" class="txtfree" size="10" name="s_realname" />
					<input type="hidden" name="action" value="list" />
					<input type="submit" value="搜索" style="padding:2px 5px" class="btn"  />
					<script>
						var _s_gid = "<%=request.getAttribute("s_gid") %>";
						var _s_userno = unescape("<%=request.getAttribute("s_userno") %>");
						var _s_username = unescape("<%=request.getAttribute("s_username") %>");
						var _s_realname = unescape("<%=request.getAttribute("s_realname") %>");
						var _s_status = "<%=request.getAttribute("s_status") %>";
						var _s_sfzhm = "<%=request.getAttribute("s_sfzhm") %>";
						
					</script>
				</form>
			</td>
		</tr>
	</table>
	

	<form action="system/user.do?action=batch" method="post" name="bf" onsubmit="return window.confirm('批量操作不可还原，您确定要执行批量操作吗？');">
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25"><input type="checkbox" name="mycheck" id="mycheck" onclick="selcheck(this)" /></th>
			<th>身份证号码</th>
			<!--<th>用户名</th>-->
			<th>分组</th>
			<th>真实姓名</th>
			<th>形象照片</th>
			<th>工号</th>
			<th>状态</th>
			<th>登陆</th>
			<th width="150">操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><input type="checkbox" name="usercheckbox" id="usercheckbox" value="<%=map.get("ID") %>" /></td>
				<td><%=map.get("SFZHM") %></td>
				<!--<td><%=map.get("USERNAME") %></td>-->
				<td><%=map.get("GROUPNAME") %></td>
				<td><%=map.get("REALNAME") %></td>
				<td>
					<%
					String photo = (String) map.get("PHOTO");
					if(photo!=null && photo.length()>5){ %>
						<a href="<%=photo %>" class="tooltips" target="_blank"><img src="<%=photo %>" height="25" border="0" /><span><img src="<%=photo %>" height="200" border="0" /></span></a>
					<%}%>
				</td>
				<td><%=map.get("USERNO") %></td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"<font color='green'>正常</font>":"-1".equals(_STATUS)?"<font color='red'>锁定</font>":"0".equals(_STATUS)?"<font color='orange'>待审核</font>":"<b>未知</b>");
					%>
				</td>
				<td>
					<%=map.get("LOGINTIMES") %>次
					/
					<%=map.get("LASTLOGIN")==null?"未登录过":""+map.get("LASTLOGIN") %>
				</td>
				<td>
					<a href="system/user.do?action=load&id=<%=map.get("ID") %>" title="修改用户"><img src="skins/images/icons/user_mod.png" border="0" align="absmiddle" /></a>
					
					<a href="system/user.do?action=examlist&uid=<%=map.get("ID") %>" title="考试记录"><img src="skins/images/icons/page_data.png" border="0" align="absmiddle" /></a>
					
					<a href="system/user.do?action=delete&id=<%=map.get("ID") %>" title="删除用户" onclick="return window.confirm('确定要删除用户吗？请谨慎操作。');"><img src="skins/images/icons/user_del.png" border="0" align="absmiddle" /></a> 
				</td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="9"><%=request.getAttribute("foot") %></td>
		</tr>
		<tr>
			<td class="thx" style="text-align:left" colspan="9">
				<select name="batchop" class="validate[required]" onchange="batchopchange(this)">
					<option value="">=批量操作=</option>
					<option value="1">批量删除</option>
					<option value="2">批量审核</option>
					<option value="3">批量移动</option>
				</select><span id="batch_span"></span>
				<input type="submit" class="btn" value="操作" />
				<input type="button" onclick="submitPrint()" class="btn" value="打印" />
			</td>
		</tr>
	</table>
	</form>

	<br/>

	

	<% 
	}
	
	
	
	if("examlist".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="system/user.do?action=list">用户管理</a></li>
		<li>用户考试记录</li>
    </ul>
    
    <br />
	用户考试记录。<br/>
	<div class="buttons">
		<a href="system/user.do?action=list">返回用户管理</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">姓名</th>
			<th>得分</th>
			<th>考试时间</th>
			<th>耗时</th>
			<th>来源</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("REALNAME") %> <font color="gray"><i>(<%=map.get("USERNO") %>)</i></font></td>
				<td><span class="label"><%=map.get("SCORE") %></span>分</td>
				<td><%=map.get("SDATE") %> <b>到</b> <%=map.get("EDATE") %></td>
				<td><span class="label"><%=Util.dateDiff(map.get("SDATE"),map.get("EDATE")) %></span>分钟</td>
				<td><%=map.get("IP") %></td>
				<td>
					<a href="system/paperexam.do?action=detail&pid=<%=map.get("PID") %>&uid=<%=map.get("UID") %>">考试详情</a>
					<a href="system/paperexam.do?action=delete_detail&pid=<%=map.get("PID") %>&uid=<%=map.get("UID") %>" onclick="return window.confirm('确定要删除考试记录吗？\n即将删除用户的考试记录，且无法恢复，请谨慎操作。');">删除</a>
				</td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="7"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	<%
	} 
	%>
	
	
	

</body>
</html>


