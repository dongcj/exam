<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,com.tom.util.Util"  %>
<%@ page import="com.tom.vo.*"  %>
<% 
String action = (String) request.getParameter("action");
String pid = (String) request.getParameter("pid");
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
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/nav.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/validationEngine.css" />
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/validationEngine.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>

	<script type="text/javascript" src="inc/impromptu.js"></script>
	<link rel="stylesheet" href="inc/impromptu.css" type="text/css" />

	<script type="text/javascript" src="inc/system/analysis.js"></script>

	<style>
		.divkey{padding:5px; background:#fafafa;color:#aaa}
		div.jqi{ width:600px}
	</style>
	<title>HCF exam</title>
</head>
<body class="body">
	

	<% if("chengji".equals(action)){%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>试卷分析</li>
    </ul>
    
	<br />
	设置下列分析条件，进行成绩分析。<br/>
	<div class="buttons">
		<a href="system/analysis.do?action=chengji" class="on">试卷分析</a>
		<a href="system/analysis.do?action=shijuan">成绩分析</a>
		<a href="system/analysis.do?action=kaoshi">考试分析</a>
	</div>
    
    <br /><br />
    <table class="stable" width="100%" align="center">
		<tr>
			<th height="25">试卷名称</th>
			<th>参考人数</th>
			<th>及格数</th>
			<th>不及格数</th>
			<th>最高分</th>
			<th>最低分</th>
			<th>平均分</th>
			<th>及格分</th>
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
				<td><a href="system/paperexam.do?action=list&id=<%=map.get("ID") %>"><%=map.get("PAPER_NAME") %></a></td>
				<td><%=map.get("TOTAL_PEOPLE") %></td>
				<td><%=map.get("PASS_NUM") %></td>
				<td><%=map.get("NOT_PASS_NUM") %></td>
				<td><%=map.get("MAX_SCORE")==null?"0":map.get("MAX_SCORE") %></td>
				<td><%=map.get("MIN_SCORE")==null?"0":map.get("MIN_SCORE") %></td>
				<td><%=map.get("AVG_SCORE")==null?"0":map.get("AVG_SCORE") %></td>
				<td><%=map.get("PASS_SCORE") %></td>
				<td><%=map.get("TOTAL_SCORE") %>分</td>
				<td>
					<a href="javascript:;" onclick="chengji_detail('<%=map.get("ID") %>')">详情</a>
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
	<%} %>


	
	<% if("chengji_detail".equals(action)){%>
	<b>试卷分析详情</b>
    <br />
	<% if(pid!=null && !"".equals(pid)){
		Map data = (Map)request.getAttribute("data");
		if(data!=null){
	%>
		<table class="stable" width="100%" align="center">
			<tr>
				<th width="15%">试卷名称</th>
				<td width="35%"><%=data.get("PAPER_NAME") %></td>
				<th width="15%">参考人数</th>
				<td width="35%"><span class="label"><%=data.get("TOTAL_PEOPLE") %></span> 人</td>
			</tr>
			<tr>
				<th>及格数</th>
				<td><span class="label" style="color:#090"><%=data.get("PASS_NUM") %></span> 人</td>
				<th>不及格数</th>
				<td><span class="label" style="color:#f00"><%=data.get("NOT_PASS_NUM") %></span> 人</td>
			</tr>
			<tr>
				<th>最高分</th>
				<td><span class="label" style="color:#090"><%=data.get("MAX_SCORE")==null?"0":data.get("MAX_SCORE") %></span> 分</td>
				<th>最低分</th>
				<td><span class="label" style="color:#f00"><%=data.get("MIN_SCORE")==null?"0":data.get("MIN_SCORE") %></span> 分</td>
			</tr>
			<tr>
				<th>平均分</th>
				<td><span class="label" style="color:#090"><%=data.get("AVG_SCORE")==null?"0":data.get("AVG_SCORE") %></span> 分</td>
				<th>及格分</th>
				<td><span class="label" style="color:#f00"><%=data.get("PASS_SCORE")==null?"0":data.get("PASS_SCORE") %></span> 分 (60%)</td>
			</tr>
			<tr>
				<th>总分</th>
				<td><span class="label"><%=data.get("TOTAL_SCORE") %></span> 分</td>
				<th></th>
				<td></td>
			</tr>
		</table>

	<%	}}
	} 
	%>
	
	
	
	
	<% if("shijuan".equals(action)){%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>成绩分析</li>
    </ul>
    
	<br />
	设置下列分析条件，进行成绩分析。<br/>
	<div class="buttons">
		<a href="system/analysis.do?action=chengji">试卷分析</a>
		<a href="system/analysis.do?action=shijuan" class="on">成绩分析</a>
		<a href="system/analysis.do?action=kaoshi">考试分析</a>
	</div>
    
    <br /><br />
	<form action="system/analysis.do?action=shijuan_chart" method="post" target="xchart">
    <table class="stable" width="100%" align="center">
    	<tr>
    		<td width="80" class="thx">
				条件
				<a href="javascript:;" onclick="addrow()"><img src="skins/images/ico_add.png" align="absmiddle" border="0" /></a>
			</td>
    		<td>

				<table class="stable" width="100%" align="center" id="table_condition">
					<tr>
						<td>
							从(≥) <input type="text" class="validate[required,,custom[onlyNumber]] txtfree" name="tfrom" size="5" /> 分 &nbsp;
							到(<) <input type="text" class="validate[required,,custom[onlyNumber]] txtfree" name="tto" size="5" /> 分 
						</td>
					</tr>
				</table>
				
			</td>
    	</tr>
		<tr>
			<td class="thx">试卷</td>
			<td>
				<input type="text" name="rpaper_name" class="validate[required] txt readonly" readonly id="rpaper_name" />
				<a href="javascript:;" onclick="show_papers()"><img src="skins/images/find.png" border="0" /></a>
				<input type="hidden" name="pid" id="pid" />
			</td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td>
				<input type="submit" value=" 分 析 " class="btn" />
			</td>
		</tr>
	</table>
	</form>
	
	<br/>
	<table class="stable" width="100%" align="center">
		<tr>
			<td><iframe frameBorder="0" id="xchart" name="xchart" scrolling="no" src="" style="HEIGHT:350px; VISIBILITY: inherit; WIDTH:100%; Z-INDEX:100"></iframe></td>
		</tr>
	</table>
	<%} %>

	
	<% if("shijuan_chart".equals(action)){%>
		<%
		List<Map> list = (List)request.getAttribute("data");
		if(list!=null && list.size()>0){
			%>
			<table class="stable" width="100%" align="center">
			<%
			for(Map<String,Object> map : list){
				String total = "" + map.get("TOTAL");
				%>
				<tr>
					<td class="thx" width="100"><%=map.get("TFROM") %> 到 <%=map.get("TTO") %> 分 </td>
					<td>
						<span class="label"><%=total %></span>人
						<div style="width:<%=Util.StringToInt(total)*10 %>px; background:#0b0;font-size:1px; height:10px"></div>
					</td>
				</tr>
				<%
			}%>
			</table>
			<%
		}
		%>
	<%} %>

	
	
	
	
	
	<% if("kaoshi".equals(action)){%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>考试分析</li>
    </ul>
    
	<br />
	设置下列分析条件，进行考试分析。<br/>
	<div class="buttons">
		<a href="system/analysis.do?action=chengji">试卷分析</a>
		<a href="system/analysis.do?action=shijuan">成绩分析</a>
		<a href="system/analysis.do?action=kaoshi" class="on">考试分析</a>
	</div>
    
    <br /><br />
    <table class="stable" width="100%" align="center">
		<tr>
			<th height="25">试卷名称</th>
			<th>创建人</th>
			<th>时间</th>
			<th>总时长</th>
			<th>参考人数</th>
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
				<td><a href="system/paperexam.do?action=list&id=<%=map.get("ID") %>"><%=map.get("PAPER_NAME") %></a></td>
				<td><%=map.get("USERNAME") %></td>
				<td><%=map.get("STARTTIME") %> <b>到</b> <%=map.get("ENDTIME") %></td>
				<td><span class="label"><%=map.get("PAPER_MINUTE") %></span>分钟</td>
				<td><%=map.get("TOTAL_PEOPLE") %></td>
				<td><%=map.get("TOTAL_SCORE") %>分</td>
				<td>
					<a href="javascript:;" onclick="kaoshi_detail(<%=map.get("ID") %>)">考试分析</a>
					<a href="system/analysis.do?action=kaoshi_detail&pid=<%=map.get("ID") %>" target="_blank"><img src="skins/images/new_win.png" border="0" align="absmiddle" /></a>
					
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
	<%} %>
	

	
	<% 
	if("kaoshi_detail".equals(action)){
	%>
		<% 
		VOPaper PAPER = (VOPaper)request.getAttribute("PAPER");
		int rownbr = 0;
		if(PAPER != null){
		%>
			<div style="width:100%;text-align:center;padding:10px 0;line-height:150%">
				<h2><%=PAPER.getPaperTitle() %></h2>
				开始时间：<%=PAPER.getPaperStart() %> &nbsp; 结束时间：<%=PAPER.getPaperEnd() %> <br/>
				总分：<span class="label"><%=PAPER.getPaperTotalScore() %></span> 分 &nbsp;  &nbsp; 
				时长：<span class="label"><%=PAPER.getPaperMinute() %></span> 分钟
			</div>
		<%
		List<VOSection> LIST_SECTIONS = PAPER.getPaperSections();
		if(LIST_SECTIONS!=null && LIST_SECTIONS.size()>0){
			for(VOSection section : LIST_SECTIONS){
		%>
		<table class="stable2 mtop20" width="100%" cellpadding="5px">
			<tr><th colspan="2"><%=section.getSectionName() %> &nbsp;<font color="gray">(<%=section.getSectionRemark() %> 共<%=section.getSectionQuestions().size() %>题)</font></th></tr>
			<% 
			List<VOQuestion> LIST_QUESTIONS  = section.getSectionQuestions();
			if(LIST_QUESTIONS!=null && LIST_QUESTIONS.size()>0){
			for(VOQuestion question : LIST_QUESTIONS){
				String qid = "" + question.getQuestionId();
				String qtype = question.getQuestionType();
				rownbr ++;
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
						}}
					}else if("2".equals(qtype)){//多选题
						List<VOOption> LIST_OPTIONS = question.getQuestionOptions();
						if(LIST_OPTIONS!=null && LIST_OPTIONS.size()>0){
						for(VOOption option : LIST_OPTIONS){
					%>
						<label for="question_<%=qid %>_<%=option.getOptionAlisa() %>"><%=option.getOptionAlisa() %>：<%=option.getOptionContent() %></label><br/>
					<%
						}}
					}
					%>
					</div>
				</td>
				
				
				
				<td width="50" valign="top" >
					<% 
					Map data = (Map)request.getAttribute("data");
					if(data!=null){
						String zql = (String)data.get(qid);
						if(zql==null || "null".equals(zql)){
							zql = "0";
						}
						out.print("正确率：<br/>"+zql+"%");
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
					<input type="button" value="关闭" class="btn" onclick="window.close()" />
				</td>
			</tr>
		</table>
	
	
	<% 
	}
	%>




	
	
	
	<% if("show_papers".equals(action)){%>
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">试卷名称</th>
			<th>创建人</th>
			<th>时间</th>
			<th>总时长</th>
			<th>总分</th>
			<th>选择</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td><%=map.get("PAPER_NAME") %></td>
				<td><%=map.get("USERNAME") %></td>
				<td><%=map.get("STARTTIME") %> <b><br/></b> <%=map.get("ENDTIME") %></td>
				<td><%=map.get("PAPER_MINUTE") %>分钟</td>
				<td><%=map.get("TOTAL_SCORE") %>分</td>
				<td><a href="javascript:;" onclick="parentSetter('<%=map.get("ID") %>','<%=map.get("PAPER_NAME") %>')">选择</a></td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="7"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	
	
	<script>
		parentSetter = function(id,nm){
			parent.document.getElementById("pid").value = "" + id;
			parent.document.getElementById("rpaper_name").value = "" + nm;
			parent.$.prompt.close();
		}
	</script>
	
	<%} %>
	
	
	<br/><br/>
	<script type="text/javascript">
		show_papers = function(){
			var surl = "system/analysis.do?action=show_papers";
			$.prompt('<iframe frameBorder="0" id="xwind" name="xwind" scrolling="yes" src="'+surl+'" style="HEIGHT:350px; VISIBILITY: inherit; WIDTH:580px; Z-INDEX:100"></iframe>',{buttons: { ok: 'true' }});
		}
		
		
		chengji_detail = function(pid){
			var surl = "system/analysis.do?action=chengji_detail&pid="+pid;
			$.prompt('<iframe frameBorder="0" id="xwind" name="xwind" scrolling="no" src="'+surl+'" style="HEIGHT:350px; VISIBILITY: inherit; WIDTH:580px; Z-INDEX:100"></iframe>',{buttons: { ok: 'true' }});
		}

		kaoshi_detail = function(pid){
			var surl = "system/analysis.do?action=kaoshi_detail&pid="+pid;
			$.prompt('<iframe frameBorder="0" id="xwind" name="xwind" scrolling="yes" src="'+surl+'" style="HEIGHT:500px; VISIBILITY: inherit; WIDTH:680px; Z-INDEX:100"></iframe>',{buttons: { ok: 'true' }});
			$(".jqi").css("width","700px");
			$(".jqi").css("top","10px");
		}
	</script>
	
	
	
	
	
</body>
</html>


