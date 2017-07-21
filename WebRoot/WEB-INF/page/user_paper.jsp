<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,com.tom.util.SystemCode" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat" %>
<%@ page import="com.tom.vo.*" %>
<%@ page import="com.tom.util.Util" %>
<% 
String action = (String) request.getParameter("action");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	int rownbr = 0;
	%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/nav.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/validationEngine.css" />
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/validationEngine.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/user/userpaper.js" type="text/javascript"></script>
	<script src="inc/validator.js" type="text/javascript"></script>
	<script src="inc/user/syncserver.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="inc/impromptu.js"></script>
	<link rel="stylesheet" href="inc/impromptu.css" type="text/css" />
	
	<title>HCF exam</title>
	
	
</head>
<body class="body">
	
	
	<% 
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /> </a></li>
		<li>我的试卷</li>
    </ul>
    
    <br />
	我的试卷，选择试卷参加考试，或者查看考试详情。
	<br /><br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">试卷名称</th>
			<th>状态</th>
			<th>考试时间</th>
			<th>卷面总分</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("PAPER_NAME") %></td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"开放":"-1".equals(_STATUS)?"<font color='red'>不开放</font>":"未知状态");
					%>
				</td>
				<td>
					<b><%=map.get("PAPER_MINUTE") %></b>分钟<br/>
					<%=map.get("STARTTIME") %> <b>到</b> <%=map.get("ENDTIME") %>
				</td>
				<td>总分<%=map.get("TOTAL_SCORE") %>分</td>
				<td>
					<!-- add by dongcj -->
					<% 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
					if(new Date().before(sdf.parse(map.get("ENDTIME").toString()))) {
					 %>
						<input type="button" class="btn" value="进入考试" onclick="show_confirm('<%=map.get("ID") %>','<%=map.get("PAPER_NAME") %>','<%=map.get("TOTAL_SCORE") %>','<%=map.get("PAPER_MINUTE") %>')" style="width:80px" />
					<% } else { %>
						<a href="javascript:;" class="btn" onclick="show_confirm('<%=map.get("ID") %>','<%=map.get("PAPER_NAME") %>','<%=map.get("TOTAL_SCORE") %>','<%=map.get("PAPER_MINUTE") %>')">该考试已结束</a>
					<% } %>
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
	<br/>
	查看【<a href="user/paper.do?action=history">考试记录</a>】
	
	<% 
	}else if("detail".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="user/paper.do?action=list">我的试卷</a></li>
		<li>试卷详情 </li>
    </ul>
    
	<br /><br />
	
	
	
	<form action="#" method="post" id="userpaperform" pid="<%=request.getParameter("id") %>">
		<% 
		
		VOPaper PAPER = (VOPaper)request.getAttribute("PAPER");
		if(PAPER != null){
		%>
			<div style="width:70%;text-align:center;padding:10px 0;">
				<h2><%=PAPER.getPaperTitle() %></h2>
				<img src="skins/images/clock.png" align="absmiddle" /> 开始时间：<%=PAPER.getPaperStart() %> &nbsp; 结束时间：<%=PAPER.getPaperEnd() %> <br/>
				总分：<span class="label"><%=PAPER.getPaperTotalScore() %></span> 分 &nbsp;  &nbsp; 
				时长：<span class="label"><%=PAPER.getPaperMinute() %></span> 分钟
			</div>
		<%
		List<VOSection> LIST_SECTIONS = PAPER.getPaperSections();
		if(LIST_SECTIONS!=null && LIST_SECTIONS.size()>0){
			for(VOSection section : LIST_SECTIONS){
		%>
		
		<table class="stable2 mtop20" width="70%" cellpadding="5px">
			<!-- <tr><th colspan="2"><%=section.getSectionName() %> &nbsp;<font color="gray">(<%=section.getSectionRemark() %> 共<%=section.getSectionQuestions().size() %>题)</font></th></tr> -->
			<% 
			List<VOQuestion> LIST_QUESTIONS  = section.getSectionQuestions();
			if(LIST_QUESTIONS!=null && LIST_QUESTIONS.size()>0){
			
			//要随机排序
			if("1".equals(PAPER.getQorder())){
				java.util.Collections.shuffle(LIST_QUESTIONS);
			}
			
			for(VOQuestion question : LIST_QUESTIONS){
				String qid = "" + question.getQuestionId();
				String qtype = question.getQuestionType();
				rownbr ++;
			%>
			
			<tr id="question<%=rownbr %>" style="display: none;">
				<td>
					<div class="qinfo">
						<b>第<%=rownbr %>题 <font color="gray">(分值：<%=question.getQuestionScore() %>分)</font></b>
						<% 
						if("4".equals(qtype)){
							String content = Util.FormatBlankQuestions(question.getQuestionContent(),
							"<input type=\"text\" class=\"qclazz\" maxlength=\"50\" name=\"question_"+qid+"\" dataType=\"Require\" msg=\"必填\" />");
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
						<input type="radio" id="question_<%=qid %>_<%=option.getOptionAlisa() %>" name="question_<%=qid %>" value="<%=option.getOptionAlisa() %>" class="qclazz" />
						<label for="question_<%=qid %>_<%=option.getOptionAlisa() %>"><%=option.getOptionAlisa() %>：<%=option.getOptionContent() %></label><br/>
					<%
						}
						}
					}else if("2".equals(qtype)){//多选题
						List<VOOption> LIST_OPTIONS = question.getQuestionOptions();
						if(LIST_OPTIONS!=null && LIST_OPTIONS.size()>0){
						for(VOOption option : LIST_OPTIONS){
					%>
						<input type="checkbox" id="question_<%=qid %>_<%=option.getOptionAlisa() %>" name="question_<%=qid %>" value="<%=option.getOptionAlisa() %>" class="qclazz" />
						<label for="question_<%=qid %>_<%=option.getOptionAlisa() %>"><%=option.getOptionAlisa() %>：<%=option.getOptionContent() %></label><br/>
					<%
						}
						}
					}else if("3".equals(qtype)){
					%>
						<input type="radio" id="question_<%=qid %>_T" name="question_<%=qid %>" value="YES" class="qclazz" />
						<label for="question_<%=qid %>_T">正确</label> &nbsp; &nbsp;
						<input type="radio" id="question_<%=qid %>_F" name="question_<%=qid %>" value="NO" class="qclazz" />
						<label for="question_<%=qid %>_F">错误</label><br/>
					<%
					}else if("4".equals(qtype)){
					%>
						
					<%
					}else if("5".equals(qtype)){
					%>
						<textarea rows="5" cols="50" id="question_<%=qid %>" name="question_<%=qid %>" class="qclazz"></textarea>
					<%
					}
					%>
						
					</div>
					<input type="hidden" id="question_<%=qid %>_key" value="" />
					<span class="qk" id="qes<%=qid %>td"></span>
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
					<input type="button" value="下一题" class="btn" onclick="nextQuestion(total);"  />
					<input type="button" value="上一题" class="btn" onclick="backQuestion(total);"  />
					<input type="button" value="提交试卷" class="btn" onclick="checkPaper();"  />
					<!-- <input type="button" value="打印试卷" class="btn" onclick="window.print();"  /> -->
					<!-- <input type="button" value="返回" class="btn" onclick="history.go(-1);" /> -->
				</td>
			</tr>
		</table>
		
	</form>
	
	
	
	
	<script>
		var iuid = "<%=session.getAttribute("TomUserId") %>";
		var ipid = "<%=request.getParameter("id") %>";
		var sys_communication_rate = <%=SystemCode.getCommunicationRate() %>;
	</script>
	
	<!-- 倒计时时钟 -->
	<div id="div_processor">
		<div id="div_processor_fastto"></div>
		<div id="div_processor_timer"></div>
		<div id="div_processor_ops"></div>
	</div>
	
	<%
	} 
	%>
	
	<script type="text/javascript">
		total = <%=rownbr %>;
		$("#question1").show();
	</script>	
</body>
</html>


