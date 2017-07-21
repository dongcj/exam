<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,com.tom.util.Util"  %>
<%@ page import="com.tom.vo.*"  %>
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
	<script src="inc/system/examinfo.js" type="text/javascript"></script>
	<title>HCF exam</title>
</head>
<body class="body">

	<% 
	VOPaper PAPER = (VOPaper)request.getAttribute("PAPER");
	
	
	
	
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="system/paper.do?action=list">管理试卷</a></li>
		<li>考试详情</li>
    </ul>
    
    <br />
	<b style="font-size:10pt">试卷基本信息</b><br/>
	<%if(PAPER!=null){ %>
	<table class="stable" width="500" >
		<tr>
			<th>试卷名称</th>
			<td><%=PAPER.getPaperName() %></td>
		</tr>
		<tr>
			<th>考试时间</th>
			<td>
				<%=PAPER.getPaperStart() %> - <%=PAPER.getPaperEnd() %> 
				&nbsp;
				<span class="label"><%=PAPER.getPaperMinute() %></span>分钟
			</td>
		</tr>
		<tr>
			<th>卷面总分</th>
			<td><span class="label"><%=PAPER.getPaperTotalScore() %></span>分</td>
		</tr>
	</table>
	<%} %>
	
	<br /><br />
	<div>
		<span style="font-size:10pt;font-weight:bold;float:left;padding:5px">考试详情，选择用户查看答卷详情</span>
		<span style="float:right;padding:5px">
			<a href="page?action=download_examlist&pid=<%=request.getParameter("id") %>" target="_blank">
			<img src="skins/images/icons/excel.png" align="absmiddle" border="0" />导出数据</a>
			&nbsp;
			<a href="system/paperexam.do?action=delete_detail_all&pid=<%=request.getParameter("id") %>"  
			onclick="return window.confirm('确定要清空考试记录吗？\n即将删除用户的考试记录，且无法恢复，请谨慎操作。');">
			<img src="skins/images/ico_del.png" align="absmiddle" border="0" />清空考试记录</a>
		</span>
		
	</div>
	
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
					<a href="system/paperexam.do?action=detail&pid=<%=request.getParameter("id") %>&uid=<%=map.get("UID") %>">考试详情</a>
					<a href="system/paperexam.do?action=delete_detail&pid=<%=request.getParameter("id") %>&uid=<%=map.get("UID") %>" onclick="return window.confirm('确定要删除考试记录吗？\n即将删除用户的考试记录，且无法恢复，请谨慎操作。');">删除</a>
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
	
	
	
	
	
	
	
	<% 
	if("detail".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="system/paper.do?action=list">管理试卷</a></li>
		<li><a href="system/paperexam.do?action=list&id=<%=request.getParameter("pid") %>">考试详情</a></li>
		<li>考试详情查看</li>
    </ul>
    
	<br /><br />
		<% 
		@SuppressWarnings("unchecked")
		Map<String,Object> EXAM_DETAIL = (Map) request.getAttribute("EXAM_DETAIL");
		@SuppressWarnings("unchecked")
		Map<String,Object> EXAM_INFO = (Map) request.getAttribute("EXAM_INFO");
		
		int rownbr = 0;
		if(PAPER != null){
		%>
			<div style="width:70%;text-align:center;padding:10px 0;line-height:150%">
				<h2><%=PAPER.getPaperTitle() %></h2>
				开始时间：<%=PAPER.getPaperStart() %> &nbsp; 结束时间：<%=PAPER.getPaperEnd() %> <br/>
				总分：<span class="label"><%=PAPER.getPaperTotalScore() %></span> 分 &nbsp;  &nbsp; 
				得分：<span class="label"><u id="u_total_score"><%=EXAM_INFO.get("SCORE") %></u></span> 分&nbsp;  &nbsp; 
				时长：<span class="label"><%=PAPER.getPaperMinute() %></span> 分钟 <br/>
				考试时间：<%=EXAM_INFO.get("SDATE") %> &nbsp; 交卷时间：<%=EXAM_INFO.get("EDATE") %> <br/>
				
			</div>
		<%
		List<VOSection> LIST_SECTIONS = PAPER.getPaperSections();
		if(LIST_SECTIONS!=null && LIST_SECTIONS.size()>0){
			for(VOSection section : LIST_SECTIONS){
		%>
		<table class="stable2 mtop20" width="90%" cellpadding="5px">
			<tr><th colspan="2"><%=section.getSectionName() %> &nbsp;<font color="gray">(<%-- <%=section.getSectionRemark() %> --%> 共<%=section.getSectionQuestions().size() %>题)</font></th></tr>
			<% 
			List<VOQuestion> LIST_QUESTIONS  = section.getSectionQuestions();
			if(LIST_QUESTIONS!=null && LIST_QUESTIONS.size()>0){
			for(VOQuestion question : LIST_QUESTIONS){
				String qid = "" + question.getQuestionId();
				String qtype = question.getQuestionType();
				rownbr ++;
				String did = "";
				
				Map mp = (Map)EXAM_DETAIL.get(String.valueOf(question.getQuestionId()));
				String user_answer = (String) mp.get("USER_ANSWER");
				String user_score = (String) mp.get("SCORE");
			%>
			<tr>
				<td>
					<div class="qinfo">
						<b>第<%=rownbr %>题 <font color="gray">(分值：<%=question.getQuestionScore() %>分)</font></b>
						<% 
						if("4".equals(qtype)){
							String content = Util.FormatBlankQuestions(question.getQuestionContent(),"____");
							out.print(content);
						}else{
							out.print(question.getQuestionContent());
						}
						%>
					</div>
					<div class="qoptions">
					<% 
					if("1".equals(qtype)){//单选题
						List<VOOption> LIST_OPTIONS = question.getQuestionOptions();
						if(LIST_OPTIONS!=null && LIST_OPTIONS.size()>0){
						for(VOOption option : LIST_OPTIONS){
					%>
						<label for="question_<%=qid %>_<%=option.getOptionAlisa() %>"><%=option.getOptionAlisa() %>：<%=option.getOptionContent() %></label><br/>
					<%
						}
						}
					}else if("2".equals(qtype)){//多选题
						List<VOOption> LIST_OPTIONS = question.getQuestionOptions();
						if(LIST_OPTIONS!=null && LIST_OPTIONS.size()>0){
						for(VOOption option : LIST_OPTIONS){
					%>
						<label for="question_<%=qid %>_<%=option.getOptionAlisa() %>"><%=option.getOptionAlisa() %>：<%=option.getOptionContent() %></label><br/>
					<%
						}
						}
					}else if("3".equals(qtype)){
					%>
						正确 &nbsp; &nbsp;
						错误
					<%
					}else if("4".equals(qtype)){
						%>
						<script>
							document.writeln("<div style='padding:5px'>");
							$(eval('<%=user_answer %>')).each(function(){
								document.writeln(this.VAL + "、");
							});
							document.writeln("</div>");
							document.writeln("<div style='padding:5px; background:#fafafa;color:#aaa'>答案：");
							$(eval('<%=question.getQuestionKey() %>')).each(function(){
								if(this.ID != null && this.ID != ""){
									document.writeln(this.VAL + "、");
								}
							});
							document.writeln("</div>");
						</script>
						<%
					}else if("5".equals(qtype)){
						out.print("<div style='padding:5px'>"+user_answer+"</div>");
						out.print("<div style='padding:5px; background:#fafafa;color:#aaa'>答案：<br/>"+question.getQuestionKey()+"</div>");
					}
					%>
						
					</div>
					<input type="hidden" id="question_<%=qid %>_key" value="" />
				</td>
				
				
				<% 
				if(mp != null) did = String.valueOf(mp.get("ID"));
				String img_shk = question.getQuestionKey().equals(user_answer)?"true":"err";
				%>
				<td width="100" valign="bottom" class="qks" qid="<%=qid %>" did="<%=did %>" qtype="<%=qtype %>" qscore="<%=question.getQuestionScore() %>">
					<% 
					if("1".equals(qtype) || "2".equals(qtype)){
					%>
						<b>答案：</b><%=question.getQuestionKey() %><br/>
						<b>选择：</b><%=user_answer %><br/>
						<img src="skins/images/<%=img_shk %>.png" width='35' /><br/>
						<b>得分：</b><span class="label"><%=user_score %></span>分 
					<% 
					}else if("3".equals(qtype)){
					%>
						<b>答案：</b><%="YES".equals(question.getQuestionKey())?"正确":"NO".equals(question.getQuestionKey())?"错误":"<font color='red'>未知</font>" %><br/>
						<b>选择：</b><%="YES".equals(user_answer)?"正确":"NO".equals(user_answer)?"错误":"<font color='red'>未知</font>" %><br/>
						<img src="skins/images/<%=img_shk %>.png" width='35' /><br/>
						<b>得分：</b><span class="label"><%=user_score %></span>分 
					<% 
					}else{
						%>
						<img src="skins/images/qes.png" width='35' /><br/>
						<b>得分</b>：<span class="label"><%=user_score %></span>分 
						<%
					}
					%>
				</td>
			</tr>
			
			<% 
			}//循环试题
			}//判断试题是否为空
			%>
		</table>
		
		<% 
			}//循环章节结束
		}//判断章节列表是否为空
		}
		%>
		
		
		<table class="mtop5" width="70%" cellpadding="5px" border="0">
			<tr>
				<td style="text-align:center;height:60px">
					<input type="button" value="打印试卷" class="btn" onclick="window.print();"  />
					<input type="button" value="返回" class="btn" onclick="history.go(-1);" />
				</td>
			</tr>
		</table>
	
	
		<script>
			var _pid = '<%=request.getParameter("pid") %>';
			var _uid = '<%=request.getParameter("uid") %>';
			var _iid = '<%=EXAM_INFO.get("ID") %>';
		</script>
	
	
	
	<% 
	}
	%>
	
	
	
	<div id="divsetter"></div>
	
	
</body>
</html>


