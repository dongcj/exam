<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,net.fckeditor.*,com.tom.util.Html2Text,com.tom.util.SystemCode,com.tom.util.EscapeUtil"  %>
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
	%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/nav.css" />
	<link rel="stylesheet" type="text/css" href="skins/default/validationEngine.css" />
	<script src="inc/jquery.js" type="text/javascript"></script>
	<script src="inc/validationEngine.js" type="text/javascript"></script>
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/system/question.js" type="text/javascript"></script>
	<title>HCF exam</title>
	<% 
	FCKeditor fckEditor = null;
	%>
	<style>
		#TD_BLANKS{line-height:25px}
		#TD_BLANKS span{margin:0 10px 0 0;float:left}
		#TD_BLANKS span a{font-family:Webdings}
		
		#question_detail{position:absolute; left:100px; top:100px; width:350px; height:200px; display:none; padding:5px; border:solid 1px #ddd;
		background:#fff;OVERFLOW-y:auto}
	</style>
	
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
		<li>创建试题</li>
    </ul>
    
    <br />
	填写下列基本信息，创建试题。<br/>
	<div class="buttons">
		<a href="system/question.do?action=add" class="on">创建试题</a>
		<a href="system/masimpq.do?action=question">批量导入试题</a>
		<a href="system/question.do?action=list">管理试题</a>
	</div>
    
    <br /><br />
    <form action="system/question.do?action=save" method="post" >
    <table class="stable" width="100%" align="center">
    	<tr>
			<td class="thx">试题类型</td>
			<td colspan="3">
				<select name="qtype" id="qtype">
					<option value="1">单选题</option>
					<option value="2">多选题</option>
					<option value="3">判断题</option>
					<option value="4">填空题</option>
					<option value="5">问答题</option>
				</select>
			</td>
		</tr>
    	<tr>
    		<td width="10%" class="thx">所属题库</td>
    		<td width="40%">
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
			<td width="10%" class="thx">题库难度</td>
    		<td width="40%">
    			<select name="qlevel" class="validate[required]">
    				<option value="3" style="color:#00ff00">很容易</option>
					<option value="4" style="color:#00aa00">较容易</option>
					<option value="5" selected="selected">一般</option>
					<option value="6" style="color:#ff9900">较难</option>
					<option value="7" style="color:#ff0000">非常难</option>
				</select>
			</td>
    	</tr>
		<tr>
			<td class="thx">题库状态</td>
			<td>
				<select name="status">
					<option value="1">不完全开放</option>
					<option value="0">完全开放</option>
				</select>
			</td>
			<td class="thx">题库来源</td>
			<td>
				<select name="qfrom">
					<option value="1">自主命题</option>
					<option value="2">网络下载</option>
					<option value="3">图书</option>
					<option value="4">试卷</option>
					<option value="5">其他</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">题干内容</td>
			<td colspan="3">
				<% 
					fckEditor = new FCKeditor(request, "content");
					fckEditor.setToolbarSet("MyBasic");
					fckEditor.setWidth("100%");
					fckEditor.setHeight("150px");
					out.println(fckEditor);
				%>
			</td>
		</tr>
		
		<tr>
			<td class="thx">答案设置<br/>
				<input type="button" id="btn_xuan_addrow" style="display:none" value="增加选项" class="btn" onclick="xuan_addrow($('#qtype').val());" />
			</td>
			<td colspan="3" id="key_setting"></td>
		</tr>
		
		<tr>
			<td class="thx">试题解析</td>
			<td colspan="3">
				<textarea rows="3" cols="55" style="width:450px" name="keydesc"></textarea>
			</td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td colspan="3">
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" value="<%=session.getAttribute("TomUserId") %>" name="adminid" />
			</td>
		</tr>
    </table>
    </form>
    <% 
    }
    %>
    
    
    
    <% 
	if("load".equals(action)){
		String id = (String) request.getParameter("id");
		@SuppressWarnings("unchecked")
		Map<String,Object> map = (Map<String,Object>) request.getAttribute("question");
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>修改题库信息</li>
    </ul>
    
    <br />
	<font color="red"><b>修改试题信息，该操作不可还原，请谨慎操作。</b></font><br/>
    <div class="buttons">
		<a href="system/question.do?action=add">创建试题</a>
		<a href="system/question.do?action=list">管理试题</a>
	</div>
    
    <% 
    if( map != null ){
    %>
    <br /><br />
    <form action="system/question.do?action=update&id=<%=id %>&qtype=<%=map.get("QTYPE") %>" method="post">
    	<table class="stable" width="100%" align="center">
    	<tr>
			<td class="thx">试题类型</td>
			<td colspan="3">
				<select name="qtype" id="qtype1">
					<option value="1">单选题</option>
					<option value="2">多选题</option>
					<option value="3">判断题</option>
					<option value="4">填空题</option>
					<option value="5">问答题</option>
				</select>
			</td>
		</tr>
    	<tr>
    		<td width="10%" class="thx">所属题库</td>
    		<td width="40%">
    			<select name="dbid" class="validate[required]" id="dbid">
    				<option value="">--请选择所属题库--</option>
    				<% 
    				@SuppressWarnings("unchecked")
    				List<Map<String,Object>> dblist = (List)request.getAttribute("DBLIST");
    				if(dblist!=null && dblist.size()>0){
    					for(Map<String,Object> mapd : dblist){
    				%>
					<option value="<%=mapd.get("ID") %>"><%=mapd.get("DNAME") %></option>
					<% 
						}
					}
					%>
				</select>
			</td>
			<td width="10%" class="thx">题库难度</td>
    		<td width="40%">
    			<select name="qlevel" class="validate[required]" id="qlevel">
    				<option value="3" style="color:#00ff00">很容易</option>
					<option value="4" style="color:#00aa00">较容易</option>
					<option value="5">一般</option>
					<option value="6" style="color:#ff9900">较难</option>
					<option value="7" style="color:#ff0000">非常难</option>
				</select>
			</td>
    	</tr>
		<tr>
			<td class="thx">题库状态</td>
			<td>
				<select name="status" id="status">
					<option value="1">不完全开放</option>
					<option value="0">完全开放</option>
				</select>
			</td>
			<td class="thx">题库来源</td>
			<td>
				<select name="qfrom" id="qfrom">
					<option value="1">自主命题</option>
					<option value="2">网络下载</option>
					<option value="3">图书</option>
					<option value="4">试卷</option>
					<option value="5">其他</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="thx">题干内容</td>
			<td colspan="3">
				<% 
					fckEditor = new FCKeditor(request, "content");
					fckEditor.setValue((String)map.get("CONTENT"));
					fckEditor.setToolbarSet("MyBasic");
					fckEditor.setWidth("100%");
					fckEditor.setHeight("150px");
					out.println(fckEditor);
				%>
			</td>
		</tr>
		
		<tr>
			<td class="thx">答案设置<br/>
				<input type="button" id="btn_xuan_addrow" style="display:none" value="增加选项" class="btn" onclick="xuan_addrow($('#qtype').val());" />
			</td>
			<td colspan="3" id="key_setting"></td>
		</tr>
		
		<tr>
			<td class="thx">试题解析</td>
			<td colspan="3">
				<textarea rows="3" cols="55" style="width:450px" name="keydesc" id="keydesc"><%=map.get("KEYDESC") %></textarea>
			</td>
		</tr>
		<tr>
			<td class="thx"></td>
			<td colspan="3">
				<input type="submit" value=" 提 交 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
				<input type="hidden" value="<%=map.get("ADMINID") %>" name="adminid" />
				<% 
				String sqtype = "" + map.get("QTYPE");
				%>
				
				<%if("1".equals(sqtype) || "2".equals(sqtype) || "3".equals(sqtype)){ %>
					<input type="hidden" value="<%=map.get("SKEY") %>" id="_skey_" />
				<%}else if("4".equals(sqtype)){ %>
					
				<%}else if("5".equals(sqtype)){ %>
					<input type="hidden" value="<%=EscapeUtil.escape((String)map.get("SKEY")) %>" id="_skey_" />
				<%} %>
				
			</td>
		</tr>
    </table>
    </form>
    <script>
    	$("#qtype1").val(<%=map.get("QTYPE") %>);
    	$("#dbid").val(<%=map.get("DBID") %>);
    	$("#qlevel").val(<%=map.get("QLEVEL") %>);
    	$("#status").val(<%=map.get("STATUS") %>);
    	$("#qfrom").val(<%=map.get("QFROM") %>);
    	
    	<%
    	if("1".equals(sqtype) || "2".equals(sqtype)){//选择题
    	%>
    		var OPTION_LIST = <%=request.getAttribute("OPTION_LIST") %>;
    	<%
    	}else if("4".equals(sqtype)){//填空题
    	%>
    		var BLANKS = <%=map.get("SKEY") %>;
    	<%
    	}
    	%>
    	
    	
    	
    </script>
    <% 
    }
    }
    %>
	
	
	
	<% 
	if("list".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>管理试题</li>
    </ul>
    
    <br />
	管理试题，选择试题进行修改或删除。<br/>
	<div class="buttons">
		<a href="system/question.do?action=add">创建试题</a>
		<a href="system/masimpq.do?action=question">批量导入试题</a>
		<a href="system/question.do?action=list" class="on">管理试题</a>
	</div>
	<br/><br />
	
	<table class="stable" width="100%" align="center">
		<tr>
			<td>
				<form action="system/question.do" method="get">
				<!-- start -->
				<select name="s_dbid">
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
				<select name="s_qtype">
					<option value="">=选择题型=</option>
					<option value="1" >单选题</option>
					<option value="2" >多选题</option>
					<option value="3" >判断题</option>
					<option value="4" >填空题</option>
					<option value="5" >问答题</option>
				</select>
				&nbsp;
				<input type="text" name="s_keywords" id="s_keywords" value="" size="20" class="txt" />
				&nbsp;
				<input type="hidden" name="action" value="list" />
				<input type="submit" value="搜索" style="padding:2px 5px" class="btn"  />
				<!-- end -->
				<script>
					<%if(request.getAttribute("s_keywords")!=null){%>
					$("#s_keywords").val(unescape('<%=request.getAttribute("s_keywords") %>'));
					<%}%>
					<%if(request.getParameter("s_dbid")!=null){%>
					$("select[name=s_dbid]").val('<%=request.getParameter("s_dbid") %>');
					<%}%>
					<%if(request.getParameter("s_qtype")!=null){%>
					$("select[name=s_qtype]").val('<%=request.getParameter("s_qtype") %>');
					<%}%>
				</script>
				</form>
			</td>
		</tr>
	</table>
	
	<form action="system/question.do?action=batch" method="post" name="bf" onsubmit="return window.confirm('批量操作不可还原，您确定要执行批量操作吗？');">
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25"><input type="checkbox" name="mycheck" id="mycheck" onclick="selcheck(this)" /></th>
			<th height="25">编号</th>
			<th>题库</th>
			<th>类型</th>
			<th>题干</th>
			<th>创建时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr class="qestr" id="<%=map.get("ID") %>">
				<td><input type="checkbox" name="usercheckbox" id="usercheckbox" value="<%=map.get("ID") %>" /></td>
				<td><%=map.get("ID") %></td>
				<td><%=map.get("DNAME") %></td>
				<td>
					<% 
					String _QTYPE = "" + map.get("QTYPE");
					out.print(SystemCode.getQuestionTypeName(_QTYPE));
					%>
				</td>
				<td><%=Util.splitString(Html2Text.Html2TextFormate((""+map.get("CONTENT"))),35) %>..</td>
				<td><%=map.get("POSTDATE") %></td>
				<td>
					<% 
					String _STATUS = "" + map.get("STATUS");
					out.println("1".equals(_STATUS)?"不完全开放":"0".equals(_STATUS)?"<font color='green'>完全开放</font>":"未知状态");
					%>
				</td>
				<td>
					<a href="system/question.do?action=load&id=<%=map.get("ID") %>" title="修改试题"><img src="skins/images/icons/note_mod.png" border="0" align="absmiddle" /></a>
					
					<a href="system/question.do?action=delete&id=<%=map.get("ID") %>" title="删除试题" 
					onclick="return window.confirm('您即将要删除试题，这将影响到与之相关的试卷。\n而且，删除操作无法恢复，确定要删除吗?');"><img src="skins/images/icons/note_delete.png" border="0" align="absmiddle" /></a> 
				</td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="7"><%=request.getAttribute("foot") %></td>
		</tr>
		<tr>
			<td class="thx" style="text-align:left" colspan="9">
				<select name="batchop" class="validate[required]" onchange="batchopchange(this)">
					<option value="">=批量操作=</option>
					<option value="1">批量删除</option>
					<option value="2">批量开放</option>
					<option value="3">批量移动</option>
				</select><span id="batch_span"></span>
				<input type="submit" class="btn" value="操作" />
				<input type="button" onclick="submitPrint()" class="btn" value="打印" />
			</td>
		</tr>
	</table>
	
	<div id="question_detail"></div>

	<br/><br/><br/><br/><br/>
	<% 
	}
	%>
	
	
	
	
	
	

</body>
</html>


