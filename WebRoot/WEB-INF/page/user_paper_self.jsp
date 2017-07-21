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
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/validator.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/user/paper.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="skins/default/validationEngine.css" />
	<script src="inc/validationEngine.js" type="text/javascript"></script>
	<title>HCF exam</title>
</head>
<body class="body">
	<% 
	if("create".equals(action)){
		
		@SuppressWarnings("unchecked")
		List<Map> LISTA = (List)request.getAttribute("LISTA");
		@SuppressWarnings("unchecked")
		List<Map> LISTB = (List)request.getAttribute("LISTB");
		@SuppressWarnings("unchecked")
		List<Map> LISTC = (List)request.getAttribute("LISTC");
		
		@SuppressWarnings("unchecked")
		List<Map> LISTOPTIONS = (List)request.getAttribute("LISTOPTIONS");
		
		int rownbr = 0;
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>自我检测</li>
    </ul>
    
    <br />
	试卷生成完毕。请开始自测。
	<br /><br />
		
		<form action="#" method="post" id="selfform">
		<%if(LISTA!=null && LISTA.size()>0){ %>
		<table class="stable2 mtop20" width="70%" cellpadding="5px">
			<tr><th colspan="2">单选题 <font color="gray">(<%=request.getParameter("numa") %>题)</font></th></tr>
			<% for(Map<String,Object> map : LISTA){ 
				String id = "" + map.get("ID");
				rownbr++;
			%>
			<tr>
				<td>
					<div class="qinfo"><b>第<%=rownbr %>题</b><%=map.get("CONTENT") %></div>
					<div class="qoptions">
						<% 
						if(LISTOPTIONS!=null && LISTOPTIONS.size()>0){
							for(Map<String,Object> m : LISTOPTIONS){
							String qid = "" + m.get("QID");
							String salisa = "" + m.get("SALISA");
							String input_id = "question_" + qid + "_" + salisa;
							String input_name = "question_" + qid;
							if(id.equals(qid)){
						%>
						<input type="radio" id="<%=input_id %>" name="<%=input_name %>" value="<%=salisa %>" class="qclazz" />
						<label for="<%=input_id %>"><%=salisa %>：<%=m.get("SOPTION") %></label><br/>
						<% 
							}
							}
						}
						%>
						<input type="hidden" id="question_<%=id %>_key" value="<%=map.get("SKEY") %>" />
					</div>
				</td>
				<td width="100" class="qk" id="qes<%=map.get("ID") %>td"></td>
			</tr>
			<% }%>
		</table>
		<%} %>
		
		
		<%if(LISTB!=null && LISTB.size()>0){%>
		<table class="stable2 mtop20" width="70%" cellpadding="5px">
			<tr><th colspan="2">多选题 <font color="gray">(<%=request.getParameter("numb") %>题)</font></th></tr>
			<% for(Map<String,Object> map : LISTB){ 
				String id = "" + map.get("ID");
				rownbr++;
			%>
			<tr>
				<td>
					<div class="qinfo"><b>第<%=rownbr %>题</b><%=map.get("CONTENT") %></div>
					<div class="qoptions">
						<% 
						if(LISTOPTIONS!=null && LISTOPTIONS.size()>0){
							for(Map<String,Object> m : LISTOPTIONS){
							String qid = "" + m.get("QID");
							String salisa = "" + m.get("SALISA");
							String input_id = "question_" + qid + "_" + salisa;
							String input_name = "question_" + qid;
							if(id.equals(qid)){
						%>
						<input type="checkbox" id="<%=input_id %>" name="<%=input_name %>" value="<%=salisa %>" class="qclazz" />
						<label for="<%=input_id %>"><%=salisa %>：<%=m.get("SOPTION") %></label><br/>
						<% 
							}
							}
						}
						%>
						<input type="hidden" id="question_<%=id %>_key" value="<%=map.get("SKEY") %>" />
					</div>
				</td>
				<td width="100" class="qk" id="qes<%=map.get("ID") %>td"></td>
			</tr>
			<% }%>
		</table>
		<%} %>
		
		
		<%if(LISTC!=null && LISTC.size()>0){ %>
		<table class="stable2 mtop20" width="70%" cellpadding="5px">
			<tr><th colspan="2">判断题 <font color="gray">(<%=request.getParameter("numc") %>题)</font></th></tr>
			<% for(Map<String,Object> map : LISTC){ 
				String id = "" + map.get("ID");
				rownbr++;
			%>
			<tr>
				<td>
					<div class="qinfo"><b>第<%=rownbr %>题</b><%=map.get("CONTENT") %></div>
					<div class="qoptions">
						<input type="radio" id="question_<%=map.get("ID") %>_T" name="question_<%=map.get("ID") %>" value="YES" class="qclazz" />
						<label for="question_<%=map.get("ID") %>_T">正确</label> &nbsp; &nbsp;
						<input type="radio" id="question_<%=map.get("ID") %>_F" name="question_<%=map.get("ID") %>" value="NO" class="qclazz" />
						<label for="question_<%=map.get("ID") %>_F">错误</label><br/>
					</div>
					<input type="hidden" id="question_<%=id %>_key" value="<%=map.get("SKEY") %>" />
				</td>
				<td width="100" class="qk" id="qes<%=map.get("ID") %>td"></td>
			</tr>
			<% }%>
		</table>
		<%} %>
		
		
		<table class="mtop5" width="70%" cellpadding="5px" border="0">
			<tr>
				<td style="text-align:center;height:60px">
					<input type="button" value="提交试卷" class="btn" onclick="checkPaper();"  />
					<input type="button" value="打印试卷" class="btn" onclick="window.print();"  />
					<input type="button" value="返回" class="btn" onclick="history.go(-1);" />
				</td>
			</tr>
		</table>
		</form>
		
		
		<!-- 倒计时时钟 -->
		<div id="div_processor">
			<div id="div_processor_fastto"></div>
			<div id="div_processor_timer"></div>
			<div id="div_processor_ops"></div>
		</div>
	
	<% 
	}else{
	%>
	
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="user/selfpaper.do?action=setting">自我检测</a></li>
    </ul>

	<br/>
	设置查询条件，从题库中筛选题目进行自我检测。
	<br /><br />
	
	<form action="user/selfpaper.do?action=create" method="post" >
	<table class="stable" width="100%" align="center">
		
		<tr>
			<th width="100">选择题库</th>
			<td>
				<select name="dbid" class="validate[required]">
    				<option value="">--请选择所属题库--</option>
    				<% 
    				@SuppressWarnings("unchecked")
    				List<Map<String,Object>> dblist = (List)request.getAttribute("DBLIST");
    				if(dblist!=null && dblist.size()>0){
    					for(Map<String,Object> map : dblist){
    				%>
					<option value="<%=map.get("ID") %>"><%=map.get("DNAME") %></option>
					<% 
						}
					}
					%>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>单选题设置</th>
			<td>
				<select name="numa">
					<option value="0">0条</option>
					<option value="5">5条</option>
					<option value="10">10条</option>
					<option value="15">15条</option>
				</select>
				
				<select name="qlevel_a" style="width:80px">
    				<option value="3" style="color:#00ff00">很容易</option>
					<option value="4" style="color:#00aa00">较容易</option>
					<option value="5" selected="selected">一般</option>
					<option value="6" style="color:#ff9900">较难</option>
					<option value="7" style="color:#ff0000">非常难</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>多选题设置</th>
			<td>
				<select name="numb">
					<option value="0">0条</option>
					<option value="5">5条</option>
					<option value="10">10条</option>
					<option value="15">15条</option>
				</select>
				
				<select name="qlevel_b" style="width:80px">
    				<option value="3" style="color:#00ff00">很容易</option>
					<option value="4" style="color:#00aa00">较容易</option>
					<option value="5" selected="selected">一般</option>
					<option value="6" style="color:#ff9900">较难</option>
					<option value="7" style="color:#ff0000">非常难</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>判断题设置</th>
			<td>
				<select name="numc">
					<option value="0">0条</option>
					<option value="5">5条</option>
					<option value="10">10条</option>
					<option value="15">15条</option>
				</select>
				
				<select name="qlevel_c" style="width:80px">
    				<option value="3" style="color:#00ff00">很容易</option>
					<option value="4" style="color:#00aa00">较容易</option>
					<option value="5" selected="selected">一般</option>
					<option value="6" style="color:#ff9900">较难</option>
					<option value="7" style="color:#ff0000">非常难</option>
				</select>
			</td>
		</tr>
		
		
		<tr>
			<th height="30"></th>
			<td>
				<input type="submit" name="btnok" value=" 开始自我检测 " class="btn" />
				<input type="reset" value=" 重 选 " class="btn" />
			</td>
		</tr>
		
	</table>
	</form>













	
	<%
	}	
	%>
	
</body>
</html>


