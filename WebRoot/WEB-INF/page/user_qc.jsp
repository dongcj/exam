<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map"  %>
<%@ page import="com.tom.vo.*"  %>
<%@ page import="com.tom.cache.QuestionCache"  %>
<%@ page import="com.tom.util.Util"  %>
<%@ page import="com.tom.util.SystemCode"  %>
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
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/user/qc.js" type="text/javascript"></script>
	<style>
		.divkey{padding:5px; background:#fafafa;color:#aaa}
	</style>
	<title>HCF exam</title>
</head>
<body class="body">
	
	
	
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>错题集</li>
    </ul>
    
    <br />
	我的错题集。
	<br />
	
	<% 
	@SuppressWarnings("unchecked")
	List<Map> list = (List) request.getAttribute("list");
	if(list!=null && list.size()>0){
		for(Map<String,Object> map : list){
			int qid = com.tom.util.Util.StringToInt(""+map.get("QID"));
			VOQuestion question = QuestionCache.getQuestionById(qid);
			if(question!=null){
				String qtype = question.getQuestionType();
	%>
	<table class="stable2 mtop20" width="80%" cellpadding="5px">
		<tr>
			<td style="padding:0px">
				<div class="qinfo">
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
						out.print("<div class='divkey'>答案："+question.getQuestionKey()+"</div>");
					}else if("2".equals(qtype)){//多选题
						List<VOOption> LIST_OPTIONS = question.getQuestionOptions();
						if(LIST_OPTIONS!=null && LIST_OPTIONS.size()>0){
						for(VOOption option : LIST_OPTIONS){
					%>
						<label for="question_<%=qid %>_<%=option.getOptionAlisa() %>"><%=option.getOptionAlisa() %>：<%=option.getOptionContent() %></label><br/>
					<%
						}
						}
						out.print("<div class='divkey'>答案："+question.getQuestionKey()+"</div>");
					}else if("3".equals(qtype)){
						out.print("<div class='divkey'>答案："+("YES".equals(question.getQuestionKey())?"正确":"NO".equals(question.getQuestionKey())?"错误":"<font color='red'>未知</font>")+"</div>");
					}else if("4".equals(qtype)){
					%>
						<script>
							document.writeln("<div class='divkey'>答案：");
							$(eval('<%=question.getQuestionKey() %>')).each(function(){
								if(this.ID != null && this.ID != ""){
									document.writeln(this.VAL + "、");
								}
							});
							document.writeln("</div>");
						</script>
					<%
					}else if("5".equals(qtype)){
						out.print("<div class='divkey'>答案："+question.getQuestionKey()+"</div>");
					}
					%>
				</div>
			</td>
			<td width="30" valign="top">
				<a href="javascript:;" class="lnkdel" id="<%=map.get("ID") %>">删除</a>
			</td>
		</tr>
	</table>
	<%
			}
		} 
	}
	%>
	
	
	<table class="stable2" width="100%" cellpadding="5px">
		<tr>
			<td style="padding:5px 0px"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	
	<br/><br/>
	
	
</body>
</html>


