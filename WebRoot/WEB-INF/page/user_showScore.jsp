<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map"  %>
<%@ page import="com.tom.vo.*"  %>
<%@ page import="com.tom.util.Util"  %>
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
	<link rel="stylesheet" type="text/css" href="inc/impromptu.css" />
	
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/impromptu.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/user/qc.js" type="text/javascript"></script>
	<script src="inc/user/examdetail.js" type="text/javascript"></script>
	
	<title>HCF exam</title>
	
</head>
<body class="body">
	<center>
		<% 
		@SuppressWarnings("unchecked")
		Map<String,Object> EXAM_DETAIL = (Map) request.getAttribute("EXAM_DETAIL");
		@SuppressWarnings("unchecked")
		Map<String,Object> EXAM_INFO = (Map) request.getAttribute("EXAM_INFO");
		
		int rownbr = 0;
		VOPaper PAPER = (VOPaper)request.getAttribute("PAPER");
		if(PAPER != null){
		%>
			<div style="width:70%;text-align:center;padding:10px 0;line-height:150%">
				<h2><%=PAPER.getPaperTitle() %></h2>
				总分：<span class="label"><%=PAPER.getPaperTotalScore() %></span> 分 &nbsp;  &nbsp; 
				得分：<span class="label"><u><%=Util.isShowScore(PAPER.getShowScore())?EXAM_INFO.get("SCORE"):"暂无" %></u></span> 分&nbsp;  &nbsp; 
				时长：<span class="label"><%=PAPER.getPaperMinute() %></span> 分钟 <br/>
				开始时间：<%=PAPER.getPaperStart() %> &nbsp; 结束时间：<%=PAPER.getPaperEnd() %> <br/>
				考试时间：<%=EXAM_INFO.get("SDATE") %> &nbsp; 交卷时间：<%=EXAM_INFO.get("EDATE") %> <br/>
			</div>
		<%
		}
		%>
		<a href="user/paper.do?action=list">【返回】</a>
		
	</center>
</body>
</html>


