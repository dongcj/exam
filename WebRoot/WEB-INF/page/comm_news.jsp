<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List,java.util.Map,java.util.HashMap"  %>
<% 
String act = (String) request.getParameter("act");
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
	<style>
		.news{padding:5px;}
		.news h2{text-align:center}
		.newsdate{text-align:center}
		.newscontent *{line-height:1.5em;font-size:14px}
		.newscontent p{text-indent:2em;}
		
		.news_cate{float:left; margin:0 10px 10px 0;}
		.news_cate tr td{line-height:2em;}
		.news_cate tr td a{font-size:10pt}
	</style>
	<title>HCF exam</title>
</head>
<body class="body">

	
	<% 
	if("list".equals(act)){
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
        <li><a href="page.do?action=comm_news&act=catelist">新闻中心</a></li>
        <li id="li_cname">Loading...</li>
    </ul>
	
	<br />
	点击查看相关新闻
	<br />
	<table class="stable" width="100%" align="center">
		<tr>
			<th height="25">ID</th>
			<th>标题</th>
			<th>照片</th>
			<th>发布人</th>
			<th>阅读次数</th>
			<th>发布时间</th>
		</tr>
		<% 
		@SuppressWarnings("unchecked")
		List<Map> list = (List)request.getAttribute("list");
		if(list!=null && list.size()>0){
			for(Map<String,Object> map : list){
		%>
			<tr>
				<td cname="<%=map.get("CNAME") %>"><%=map.get("ID") %></td>
				<td><a href="page.do?action=comm_news&act=readthread&id=<%=map.get("ID") %>"><b><%=map.get("TITLE") %></b></a></td>
				<td>
					<%
					String photo = (String) map.get("PHOTO");
					if(photo!=null && photo.length()>5){ %>
						<a href="<%=photo %>" class="tooltips" target="_blank"><img src="<%=photo %>" height="25" border="0" /><span><img src="<%=photo %>" height="200" border="0" /></span></a>
					<%}%>
				</td>
				<td><%=map.get("AUTHOR") %></td>
				<td><%=map.get("VISIT") %></td>
				<td><%=map.get("POSTDATE") %></td>
			</tr>
		<% 
			}
		}
		%>
		<tr>
			<td colspan="5"><%=request.getAttribute("foot") %></td>
		</tr>
	</table>
	<script>
		var li_cname = $(".stable tr td:first").attr("cname");
		$("#li_cname").html(li_cname);
	</script>
	
	
	<% 
	} else if("readthread".equals(act)){
		Map map = (Map)request.getAttribute("news");
		if(map == null) map = new HashMap();
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li><a href="page.do?action=comm_news&act=catelist">新闻中心</a></li>
		<li><a href="page.do?action=comm_news&act=list&classid=<%=map.get("CLASSID") %>"><%=request.getAttribute("cname") %></a></li>
		<li>查看新闻</li>
    </ul>
	
	<br />
	<table class="stable" width="100%" align="center">
		<tr>
			<td>
				<div class="news">
					<h2><%=map.get("TITLE") %></h2>
					<div class="newsdate">
						<B>发布人：</B><%=map.get("AUTHOR") %> 
						&nbsp; &nbsp; 
						<B>发布时间：</B><%=map.get("POSTDATE") %>
						&nbsp; &nbsp; 
						<B>阅读次数：</B><%=map.get("VISIT") %>
						&nbsp; &nbsp; 
						<a href="javascript:;" onclick="window.print();" title="打印"><img src="skins/images/printer.png" align="absmiddle" border="0" /></a>
					</div>
					<div class="newscontent">
						<%=map.get("CONTENT") %>
					</div>
				</div>
			</td>
		</tr>
	</table>
	
	
	<% 
	} else if("catelist".equals(act)){
		List<Map> NEWS_CATEGORY = (List)request.getAttribute("NEWS_CATEGORY");
		
	%>
	<ul id="breadcrumb">
        <li><a href="welcome.jsp"><img src="skins/images/home_blk.gif" alt="Home" class="home" /></a></li>
		<li>新闻中心</li>
    </ul>
	
	<br />
	
	<% 
	if(NEWS_CATEGORY!=null){
		for(Map mc : NEWS_CATEGORY){
			List<Map> ls_news = (List)request.getAttribute("NEWS_"+mc.get("ID"));
	%>
	<table class="stable news_cate" width="45%">
		<tr>
			<th>
				<a href="page.do?action=comm_news&act=list&classid=<%=mc.get("ID") %>"><%=mc.get("CNAME") %></a>
			</th>
		</tr>
		<tr>
			<td>
				<% 
				if(ls_news!=null){
					for(Map map_news : ls_news){
						%>
						<a href="page.do?action=comm_news&act=readthread&id=<%=map_news.get("ID") %>"><%=map_news.get("TITLE") %></a>
						<font color="gray"><i><%=map_news.get("PDATE") %></i></font>
						<br/>
						<%
					}
				}
				%>
			</td>
		</tr>
	</table>
	
	<%
		}
	} 
	}
	%>
	
	
	
	
	

</body>
</html>


