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
	<script src="inc/system/paper.js"></script>
	
	<script type="text/javascript" src="inc/impromptu.js"></script>
	<link rel="stylesheet" href="inc/impromptu.css" type="text/css" />
	
	<title>HCF exam</title>
	
	<style>
		div.jqi{ width:530px}
	</style>
	
</head>
<body class="body">

	
	<% 
	if("add".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>创建试卷</li>
    </ul>
    
    <br />
	填写下列试卷基本信息，创建试卷。<br/>
	<div class="buttons">
		<a href="system/paper.do?action=add" class="on">创建试卷</a>
		<a href="system/paper.do?action=list">管理试卷</a>
		<a href="system/paper.do?action=addrand">快速创建试卷</a>
	</div>
    
    <br /><br />
    <form action="system/paper.do?action=save" method="post" >
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
				总时间：<input type="text" class="validate[required] txt readonly" style="width:50px" name="paper_minute" id="paper_minute" value="0" /> 分钟
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
		<tr>
			<td class="thx"></td>
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
    
    
    
    
    
	if("load".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("paper");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="system/paper.do?action=list">管理试卷</a></li>
		<li>修改试卷信息</li>
    </ul>
    
    <br />
	<font color="red"><b>修改试卷信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/paper.do?action=add">创建试卷</a>
		<a href="system/paper.do?action=list">管理试卷</a>
		<a href="system/paper.do?action=addrand">快速创建试卷</a>
		
		<a href="javascript:;" onclick="show_section(<%=id %>)" style="float:right">设置章节</a>
		<!--
		<a href="system/paper.do?action=delete&id=<%=id %>" onclick="return window.confirm('【系统提示】\n确定要删除吗？\n该操作将逻辑删除试卷，请谨慎操作。')" style="float:right">删除试卷</a>
		-->
		<a href="system/paper.do?action=delete&id=<%=id %>&phy=yes" onclick="return window.confirm('【系统提示】\n不推荐进行该操作，该操作将彻底删除试卷，且无法恢复，请谨慎操作。\n如果确实要删除，请先清空该试卷的考试明细。')" style="float:right">删除试卷</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/paper.do?action=update&id=<%=id %>" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">试卷名称</td>
    		<td><input type="text" class="validate[required,length[2,50]] txt" maxlength="50" style="width:330px" name="paper_name" value="<%=map.get("PAPER_NAME") %>" />  </td>
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
				总时间：<input type="text" class="validate[required] txt" style="width:50px" name="paper_minute" id="paper_minute" value="0" /> 分钟
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
			<td><textarea rows="5" cols="40" name="remark" class="txt"><%=map.get("REMARK") %></textarea> </td>
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
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" value="<%=map.get("ID") %>" name="adminid" />
				<input type="hidden" value="0" name="total_score" />
			</td>
		</tr>
    </table>
    </form>
    <script>
    	var _status = "<%=map.get("STATUS") %>";
    	var _starttime = "<%=map.get("STARTTIME") %>";
    	var _endtime = "<%=map.get("ENDTIME") %>";
    	var _paper_minute = "<%=map.get("PAPER_MINUTE") %>";
    	var _show_score = "<%=map.get("SHOW_SCORE") %>";
    	var _qorder = "<%=map.get("QORDER") %>";
    	var _usergroupids = "<%=request.getAttribute("USERGROUPIDS") %>";
    </script>
    <% 
    }
    }
    
    
    
    
    
    
     
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>管理试卷</li>
    </ul>
    
    <br />
	管理试卷，选择试卷查看详情、修改、删除。<br/>
	<div class="buttons">
		<a href="system/paper.do?action=add">创建试卷</a>
		<a href="system/paper.do?action=list" class="on">管理试卷</a>
		<a href="system/paper.do?action=addrand">快速创建试卷</a>
	</div>
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">试卷名称</th>
			<th>创建人</th>
			<th>时间</th>
			<th>总时长</th>
			<th>状态</th>
			<th>总分</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td>
					<font style="font-weight:bold;font-size:10pt"><%=map.get("PAPER_NAME") %></font>
				</td>
				<td><%=map.get("USERNAME") %></td>
				<td><%=map.get("STARTTIME") %> <b>到</b> <%=map.get("ENDTIME") %></td>
				<td><span class="label"><%=map.get("PAPER_MINUTE") %></span>分钟</td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"开放":"-1".equals(_STATUS)?"<font color='red'>不开放</font>":"未知状态");
					%>
				</td>
				<td><span class="label"><%=map.get("TOTAL_SCORE") %></span>分</td>
				<td>
					<a href="system/paper.do?action=detail&id=<%=map.get("ID") %>" title="试题设置"><img src="skins/images/icons/page_question.png" border="0" align="absmiddle" /></a>
					<a href="system/paper.do?action=load&id=<%=map.get("ID") %>" title="试卷基本设置"><img src="skins/images/icons/page_config.png" border="0" align="absmiddle" /></a>
					<a href="page?action=download_paper&pid=<%=map.get("ID") %>" target="_blank" title="导出到Word文档"><img src="skins/images/icons/page_word.png" border="0" align="absmiddle" /></a>
					<a href="system/paperexam.do?action=list&id=<%=map.get("ID") %>" title="考试详细记录"><img src="skins/images/icons/page_data.png" border="0" align="absmiddle" /></a>
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
	
	
	
	
	
	
	if("examlist".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>考试管理</li>
    </ul>
    
    <br />
	管理正在进行中的考试。
	
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<td>
			<% 
			@SuppressWarnings("unchecked")
			List<Map> list = (List)request.getAttribute("list");
			@SuppressWarnings("unchecked")
			Map<String,String> mo = (Map)request.getAttribute("online");
			if(list!=null && list.size()>0){
				for(Map<String,Object> map : list){
			%>
				<table class="epaper">
					<tr>
						<td class="epaper_head">
							<img src="skins/images/page.png" alt="试卷" align="absmiddle" /> 
							<a href="system/paperexam.do?action=list&id=<%=map.get("ID") %>" title="试卷详情"><%=map.get("PAPER_NAME") %></a>
						</td>
					</tr>
					<tr>
						<td><b>从:</b> <%=map.get("STARTTIME") %> <br/><b>到:</b> <%=map.get("ENDTIME") %></td>
					</tr>
					<tr>
						<td>
							<img src="skins/images/clock.png" alt="时长" align="absmiddle" /> <span class="labela"><%=map.get("PAPER_MINUTE") %></span>分钟  
							
							<img src="skins/images/medal.png" alt="总分" align="absmiddle" /> <span class="labela"><%=map.get("TOTAL_SCORE") %></span>分
						</td>
					</tr>
					<tr>
						<td style="border-bottom:none;">
							<% 
							String on_line = "0";
							if(mo!=null){
								on_line = "" + mo.get((String)map.get("ID"));
								if(null==on_line || "null".equals(on_line)){
									on_line = "0";
								}
							}
							%>
							<img src="skins/images/user.png" alt="参加人数" align="absmiddle" /> 
							<a href="javascript:;" onclick="show_online(<%=map.get("ID") %>)" title="参加人列表"><span class="labela"><u><%=on_line %></u></span></a> 人正在考试 ...
						</td>
					</tr>
				</table>
			<% 
				}
			}
			%>
			</td>
		</tr>
		<tr>
			<td><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	
	<script type="text/javascript">
		show_online = function(pid){
			var surl = "system/paper.do?action=exam_online&pid=" + pid;
			$.prompt('<iframe frameBorder="0" id="xwind" name="xwind" scrolling="yes" src="'+surl+'" style="HEIGHT:350px; VISIBILITY: inherit; WIDTH:510px; Z-INDEX:100"></iframe>');
			//$(".jqi").css("width","600px");
		}
	</script>
	
	<% 
	}
	
	
	
	
	
	
	if("exam_online".equals(action)){
	@SuppressWarnings("unchecked")
	List<Map> list = (List)request.getAttribute("online_list");
	%>
	当前试卷在线用户列表 (共<%
		if(list!=null && list.size()>0){
			out.print(list.size());
		}else{
			out.print("0");
		}
	 %>人)。
	 
	<a href="javascript:location.reload();" style="position:absolute;top:10px;right:10px"><img src="skins/images/refresh.png" border="0" align="absmiddle" /> 刷新</a>
	<br /><br />
	<table width="100%" align="center">
		<tr>
			<td>
			<% 
			if(list!=null && list.size()>0){
				for(Map<String,Object> map : list){
			%>
				<table class="usericon">
					<tr><td>
					<%
					String photo = (String) map.get("PHOTO");
					if(photo!=null && photo.length()>5){ %>
						<img src="<%=photo %>" />
					<%}else{%>
						<img src="skins/images/user_big.png" />
					<%} %>
					</td></tr>
					<tr>
						<td>
						<%=map.get("REALNAME") %>
						<br/>
						<a href="javascript:;" onclick="force_post_paper(<%=map.get("UID") %>,<%=request.getParameter("pid") %>);">收卷</a>
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
	
	<script type="text/javascript">
		force_post_paper = function(uid,pid){
			if(window.confirm("确定要收卷吗？该操作不可撤销，请慎重。")){
				$.ajax({
					type: "POST",
					url: "ajax.do?action=sendCommand",
					data: {scmd:"postpaper", uid:uid ,t:rnd()},
					success: function(msg){
						if("1"==msg || 1==msg){
							alert("收卷命令发送成功。");
						}else{
							alert("收卷命令发送失败。");
						}
					}
				}); 
			}
		}
	</script>
	<% 
	}
	
	
	
	
	
	
	
	if("section".equals(action)){
		String pid = (String) request.getParameter("pid");
		String op = (String) request.getParameter("op");
		String sid = (String) request.getParameter("sid");
	%>
	
	<%if("load".equals(op)){ %>
		试卷章节设置。<font color="red"><b>修改章节信息。</b></font><br/>
		<% 
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("section");
		String SECTION_NAME = (String) map.get("SECTION_NAME");
		String PER_SCORE = (String) map.get("PER_SCORE");
		String REMARK = (String) map.get("REMARK");
		%>
		<form action="system/paper.do?action=section&op=update&pid=<%=pid %>&sid=<%=sid %>" method="post" >
	    <table class="stable" width="100%" align="center">
	    	<tr>
	    		<td class="thx">章节名称</td>
	    		<td><input type="text" class="validate[required] txt" maxlength="50" name="section_name" value="<%=SECTION_NAME %>" />  </td>
	    		<td class="thx">备注</td>
	    		<td><input type="text" class="txt" maxlength="50" name="remark" value="<%=REMARK %>" />  </td>
	    	</tr>
	    	<tr>
	    		<td colspan="4" style="text-align:center">
	    			<input type="submit" value=" 修 改 " class="btn" />
	    			<input type="reset" value=" 重 置 " class="btn" />
	    		</td>
	    	</tr>
	    </table>
	    </form>
    <%}else{ %>
		试卷章节设置。新增章节。<br/>
	    <form action="system/paper.do?action=section&op=add&pid=<%=pid %>" method="post" >
	    <table class="stable" width="100%" align="center">
	    	<tr>
	    		<td class="thx">章节名称</td>
	    		<td><input type="text" class="validate[required] txt" maxlength="50" name="section_name" value="" />  </td>
	    		<td class="thx">备注</td>
	    		<td><input type="text" class="txt" maxlength="50" name="remark" value="" />  </td>
	    	</tr>
	    	<tr>
	    		<td colspan="4" style="text-align:center">
	    			<input type="submit" value=" 新 增" class="btn" />
	    			<input type="reset" value=" 重 置 " class="btn" />
	    		</td>
	    	</tr>
	    </table>
	    </form>
    <%} %>
    <br/>
	
	
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="20">章节名称</th>
			<th>备注</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
			String msid = "" + map.get("ID");
			boolean this_line = false;
			if("load".equals(op) && msid.equals(sid)){
				this_line = true;
			}
		%>
			<tr <%=this_line?"style=\"background:#ffd\"":"" %>>
				<td><%=map.get("SECTION_NAME") %></td>
				<td><%=map.get("REMARK") %></td>
				<td>
					<a href="system/paper.do?action=section&op=load&sid=<%=map.get("ID") %>&pid=<%=pid %>">修改</a>
					-
					<a href="system/paper.do?action=section&op=delete&sid=<%=map.get("ID") %>&pid=<%=pid %>" onclick="return window.confirm('确定要删除吗？\n这将影响到章节下的试题，且不可恢复。\n请谨慎操作。');">删除</a>
				</td>
			</tr>
		<% 
			}
		}
		%>
	</table>
	
	
	<% 
	}
	%>
	



	<script type="text/javascript">
		show_section = function(pid){
			var surl = "system/paper.do?action=section&pid=" + pid;
			$.prompt('<iframe frameBorder="0" id="xwind" name="xwind" scrolling="yes" src="'+surl+'" style="HEIGHT:350px; VISIBILITY: inherit; WIDTH:510px; Z-INDEX:100"></iframe>');
		}
	</script>
	
	

	
</body>
</html>


