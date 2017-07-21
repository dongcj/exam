<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map"  %>
<%@ page import="com.tom.util.Html2Text"  %>
<%@ page import="com.tom.util.Util"  %>
<%@ page import="net.sf.json.JSONArray"  %>
<% 
String action = (String) request.getParameter("action");
String id = (String) request.getParameter("id");
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
	<script src="inc/jquery.js" type="text/javascript"></script>
	
	<script src="inc/validationEngine.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="skins/default/validationEngine.css" />
	
	<script type="text/javascript" src="inc/impromptu.js"></script>
	<link rel="stylesheet" href="inc/impromptu.css" type="text/css" />
	
	<script src="inc/util.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="inc/pagination.js"></script>
	<link rel="stylesheet" href="inc/pagination.css" type="text/css" />
	
	<script src="inc/system/paperdetail.js" type="text/javascript"></script>
	
	<title>HCF exam</title>
	<style>
		.title{font-size:20px;font-weight:bold;padding:10px;}
		#div_question_list{position:absolute; left:555px; top:100px; width:450px; height:auto}
		#listnav{ float:left; margin-top:10px; width:100%; text-align:center}
		#question_detail{position:absolute; left:590px; top:100px; width:350px; height:200px; display:none; padding:5px; border:solid 1px #999;
		background:#eee;OVERFLOW-y:auto}
		#question_detail_left{position:absolute; left:260px; top:100px; width:350px; height:200px; display:none; padding:5px; border:solid 1px #999;
		background:#eee;OVERFLOW-y:auto}
		div.jqi{ width:530px}
	</style>
	
</head>
<body class="body">

	
	
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="system/paper.do?action=list">管理试卷</a></li>
		<li>试题设置</li>
    </ul>
    
    <br/>
    <table width="550" align="left" class="rmx">
    	<tr>
    		<td valign="top">
    		
    			<!-- 试卷基本信息 -->
    			<%if(request.getAttribute("PAPER")!=null){ %>
    			<% 
    			@SuppressWarnings("unchecked")
    			Map<String,Object> paper = (Map<String,Object>)request.getAttribute("PAPER");
    			%>
				<table class="stable" width="98%" cellpadding="5px">
					<caption class="title"><%=paper.get("PAPER_NAME") %></caption>
					<tr>
						<td style="line-height:20px">
							<b>创建时间</b>： <%=paper.get("POSTDATE") %> &nbsp; 
							<% 
							String STATUS = "" + paper.get("STATUS");
							String _STATUS = "1".equals(STATUS)?"开放":"-1".equals(STATUS)?"<font color='red'>不开放</font>":"未知状态";
							%>
							<b>试卷状态</b>：<%=_STATUS %>
							<br/>
							<b>考试开始</b>：<%=paper.get("STARTTIME") %> &nbsp; 
							<b>考试结束</b>：<%=paper.get("ENDTIME") %> &nbsp; 
							<b>考试时长</b>：<%=paper.get("PAPER_MINUTE") %>分钟
						</td>
					</tr>
				</table>
				<%}else{
					out.println("数据不存在");
				}%>
				
				
				
				<form action="system/paper.do?action=updateDetail&paperid=<%=request.getParameter("id") %>" method="post">
				<!-- 试卷章节 -->
				<% 
				@SuppressWarnings("unchecked")
				List<Map> SECTION_LIST = (List)request.getAttribute("SECTION_LIST");
				if(null!=SECTION_LIST && SECTION_LIST.size()>0){
					for(Map<String,Object> section : SECTION_LIST){
				%>
				<table class="stable" width="98%" cellpadding="5px" style="margin-top:10px" id="SECTION_<%=section.get("ID") %>">
					<tr>
						<th class="section_th"><span style="float:left"><%=section.get("SECTION_NAME") %> &nbsp; (<%=section.get("REMARK") %>)</span></th>
					</tr>
					<% 
					@SuppressWarnings("unchecked")
					List<Map> QUESTION_LIST = (List)request.getAttribute("QUESTIONS_OF_"+section.get("ID"));
					if(null!=QUESTION_LIST && QUESTION_LIST.size()>0){
						for(Map<String,Object> question : QUESTION_LIST){
					%>
					<tr id="QUESTION_<%=question.get("ID") %>">
						<td>
							编号：[<%=question.get("ID") %>] &nbsp; 
							分值：<input type="text" class="validate[required,custom[onlyNumber]] txtfree" size="2" value="<%=question.get("SCORE") %>" name="qscore" />&nbsp;
							<a href="javascript:;" onclick="removeQuestion('<%=question.get("ID") %>');"><u>移除</u></a> |
							<a href="javascript:;" onclick="moveQuestion('<%=question.get("ID") %>','up');"><u>上移</u></a> |
							<a href="javascript:;" onclick="moveQuestion('<%=question.get("ID") %>','down');"><u>下移</u></a> |
							<a href="javascript:;" onmouseover="viewQuestionLeft(<%=question.get("ID") %>,this)" 
							 onclick="viewQuestionLeft(<%=question.get("ID") %>,this)"><u>详情</u></a>
							<br/>
							<%=Util.splitString(Html2Text.Html2TextFormate((String)question.get("CONTENT")),20) %>
							<input type="hidden" value="<%=section.get("ID") %>" name="sid" />
							<input type="hidden" value="<%=question.get("ID") %>" name="qid" />
						</td>
					</tr>
					<% 
						}
					}
					%>
					
				</table>
				<% 
					}
				}
				%>
				<script>
					var SECTION_LIST = <%=JSONArray.fromObject(SECTION_LIST) %>;
				</script>
				
				
				<table class="stable" width="98%" cellpadding="5px" style="margin-top:10px">
					<tr>
						<td style="text-align:center;height:70px">
							<input type="submit" value="提交操作"  class="btn" />
							<input type="button" value="返回" onclick="history.go(-1);" class="btn" />
						</td>
					</tr>
				</table>
				<p></p><p></p><p></p>
				</form>
				
				
				
    		</td>
    	</tr>
    </table>
    
	
	
	
	
	<!-- QuestionsFromDatabase -->
	<div id="div_question_list">
		<table class="stable" width="98%" cellpadding="5px">
			<tr>
				<td>
					<!-- start -->
					<select name="s_dbid" id="s_dbid">
						<option value="">=选择题库=</option>
						<% 
						@SuppressWarnings("unchecked")
						List<Map> dblist = (List)request.getAttribute("DBLIST");
						if(dblist!=null && dblist.size()>0){
							for(Map<String,Object> qdb : dblist){
							%>
							<option value="<%=qdb.get("ID") %>" ><%=qdb.get("DNAME") %></option>
							<%
							}
						}
						%>
					</select>
					&nbsp; 
					<select name="s_qtype" id="s_qtype">
						<option value="">=选择题型=</option>
						<option value="1" >单选题</option>
						<option value="2" >多选题</option>
						<option value="3" >判断题</option>
						<option value="4" >填空题</option>
						<option value="5" >问答题</option>
					</select>
					&nbsp;
					<input type="text" id="s_keywords" name="s_keywords" value="" size="20" class="txt" />
					&nbsp;
					<!-- <input type="button" value="搜索" style="padding:2px 5px" class="btn" onclick="setParams();list(1)" /> -->
					<a href="javascript:setParams();list(1)" style="border: 1px solid black;">立即搜索</a>
					<!-- end -->
				</td>
			</tr>
		</table>
		<table id="questionlist" class="stable" width="98%" cellpadding="5px"></table>
		<div id="listnav"></div>
		
	</div>
	
	
	<div id="question_detail_left"></div>
	<div id="question_detail"></div>
	

</body>
</html>


