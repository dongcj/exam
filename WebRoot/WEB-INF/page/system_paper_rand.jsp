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
	<script src="inc/wdatepicker/WdatePicker.js"></script>
	<script src="inc/system/rand_paper.js"></script>
	
	<script type="text/javascript" src="inc/impromptu.js"></script>
	<link rel="stylesheet" href="inc/impromptu.css" type="text/css" />
	
	<title>HCF exam</title>
	
	<style>
		div.jqi{ width:530px}
	</style>
	
</head>
<body class="body">

	
	<% 
	if("addrand".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>快速创建试卷</li>
    </ul>
    
    <br />
	填写下列试卷基本信息，快速创建试卷。<br/>
	<div class="buttons">
		<a href="system/paper.do?action=add">创建试卷</a>
		<a href="system/paper.do?action=list">管理试卷</a>
		<a href="system/paper.do?action=addrand" class="on">快速创建试卷</a>
	</div>
    
    <br /><br />
    <form action="system/paper.do?action=saverand" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">试卷名称</td>
    		<td><input type="text" class="validate[required,length[2,50]] txt" maxlength="50" style="width:330px" name="paper_name" />  </td>
    	</tr>
    	<tr>
			<td class="thx">试卷状态</td>
			<td>
				<select name="status">
					<option value="1">开放</option>
					<option value="-1">不开放</option>
				</select>
			</td>
		</tr>
    	<tr>
			<td class="thx">时间设置</td>
			<td>
				开始时间：<input type="text" class="validate[required] txt readonly" style="width:100px" readonly="readonly" name="starttime" id="starttime" onclick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})" /> &nbsp; 
				结束时间：<input type="text" class="validate[required] txt readonly" style="width:100px" readonly="readonly" name="endtime" id="endtime" onclick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})" /> &nbsp;  
				总时间：<input type="text" class="validate[required] txt readonly" style="width:50px" readonly="readonly" name="paper_minute" id="paper_minute" value="0" /> 分钟
			</td>
		</tr>
		<tr>
			<td class="thx">成绩公布时间</td>
			<td><input type="text" class="txt" onclick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})" name="show_score" maxlength="20"  /> 设置成绩公布的时间，立即公布成绩请留空</td>
		</tr>
		<tr>
			<td class="thx">试题排序</td>
			<td>
				<input type="radio" class="validate[required]" name="qorder" value="0"  /> 试卷自身顺序
				&nbsp;
				<input type="radio" class="validate[required]" name="qorder" value="1"  /> 随机排序
			</td>
		</tr>
		<tr>
			<td class="thx">备注</td>
			<td><textarea rows="5" cols="40" name="remark" class="txt"></textarea> </td>
		</tr>
		<tr>
			<td class="thx">目标用户组</td>
			<td>
				<% 
				@SuppressWarnings("unchecked")
				List<Map> GROUPS = (List) request.getAttribute("GROUPS");
				if(GROUPS!=null && GROUPS.size()>0){
					for(Map<String,Object> m : GROUPS){
						String groupid = (String) m.get("ID");
						%>
						<input type="checkbox" name="groupids" value="<%=groupid %>" id="group_<%=groupid %>" />
						<label for="group_<%=groupid %>"><%=m.get("GROUPNAME") %></label>
						<%
					}
				}
				%>
			</td>
		</tr>
	</table>
		
	<br/>
	
	<table class="stable" width="100%" align="center">
		<tr>
			<td class="thx" style="text-align:left">设置章节并配置试题。</td>
		</tr>

		<tr>
			<td style="text-align:left">
				章节名称：<input type="text" class="validate[required] txtfree" name="rand_cname" />
				<select name="rand_dbid" class="validate[required]">
    				<option value="">--请选择所属题库--</option>
    				<% 
    				List<Map<String,Object>> dblist = (List)request.getAttribute("DBLIST");
    				for(Map<String,Object> map : dblist){
    				%>
					<option value="<%=map.get("ID") %>"><%=map.get("DNAME") %></option>
					<% }%>
				</select>

				<select name="rand_qtype" style="width:100px">
					<option value="">--选择题型--</option>
					<option value="1">单选题</option>
					<option value="2">多选题</option>
					<option value="3">判断题</option>
					<option value="4">填空题</option>
					<option value="5">问答题</option>
				</select>

				<select name="rand_qlevel" style="width:100px">
					<option value="">--选择难度--</option>
					<option value="3" style="color:#00ff00">很容易</option>
					<option value="4" style="color:#00aa00">较容易</option>
					<option value="5" selected="selected">一般</option>
					<option value="6" style="color:#ff9900">较难</option>
					<option value="7" style="color:#ff0000">非常难</option>
				</select>

				试题数量：<input type="text" class="validate[custom[onlyNumber],required] txtfree" size="3" name="rand_nums" />
				每题分值：<input type="text" class="validate[custom[onlyNumber],required] txtfree" size="3" name="rand_perscore" />
				
				&nbsp; 
				<a href="javascript:;" onclick="add_row(this)"><img src="skins/images/ico_add.png" border="0"/></a>
				<a href="javascript:;" onclick="del_row(this)"><img src="skins/images/ico_del.png" border="0"/></a>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" value="<%=session.getAttribute("TomUserId") %>" name="adminid" />
				<input type="hidden" value="0" name="total_score" />
			</td>
		</tr>

    </table>
    </form>
    <% 
    }
    %>
	
	
	<br/><br/>
	
</body>
</html>


