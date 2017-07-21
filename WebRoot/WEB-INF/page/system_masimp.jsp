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
	<script>
		checkfile = function(){
			var f = document.getElementById("cfiles").value + "";
			f = f.toLowerCase();
			if(f.indexOf("question.xls") != "-1" || f.indexOf("question.xlsx") != "-1"){
				return true;
			}else{
				alert("只允许上传EXCEL数据文件.请使用标准模板修改后上传,请直接在标准模板上修改，不要新建sheet!");
				return false;
			}
		};
	</script>
	
	<title>HCF exam question mass upload</title>
</head>
<body class="body">

	
	<% 
	if("question".equals(action)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>批量导入试题</li>
    </ul>
    
    <br />
	批量导入试题，请参考如下的说明步骤进行操作。
	<div class="buttons" style="display:none">
		<a href="system/masimpq.do?action=question" class="on">批量导入试题</a>
	</div>
    
    <br /><br />
    <form action="system/masimpq.do?action=masimp" method="post" ENCTYPE="multipart/form-data" onsubmit="return checkfile();" >
    <table class="stable" width="600" align="left">
		<tr>
    		<td class="thx" style="text-align:left">
				<b>操作说明:</b>
			</td>
		</tr>
    	<tr>
    		<td>
				1.使用该功能可以批量导入试题信息。<br/>
				2.请使用系统提供的标准模板进行填写，并导入。<br/>
				3.支持批量导入所有类型的试题，其中选择题的选项不能为空，每行表示一个选项。<br/>
				<br/>
				<img src="skins/images/icons/excel.png" border="0" align="absmiddle" /> <a href="files/ups/question.xls" target="_blank">下载标准模板</a>
			</td>
		</tr>
		<tr>
			<td>
				选择文件 
				<input type="file" name="files" size="10" id="cfiles" class="txtfree" />
			</td>
    	</tr>
		<tr>
			<td>
				<input type="submit" value=" 导 入 " class="btn" />
				<input type="reset" value=" 重 置 " class="btn" />
			</td>
		</tr>
    </table>
    </form>
    <% 
    }
    %>

</body>
</html>


