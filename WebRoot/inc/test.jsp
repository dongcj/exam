<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HCF在线考试系统</title>
<!-- <meta http-equiv="refresh" content="300;URL=test.jsp" /> -->
</head>
<body>
	<%-- <%=new java.util.Date() %> --%>

	<!-- 输出所有的session -->
	<%=request.getSession().getAttribute("TomUser")%>
	<br /> TomUserType:
	<%=request.getSession().getAttribute("TomUserType")%>
	<br /> TomUserId:
	<%=request.getSession().getAttribute("TomUserId")%>
	<br /> 所有的Session:
	<%
		Enumeration e = session.getAttributeNames();
		//得到session中变量名的枚举对象
		while (e.hasMoreElements()) { //遍历每一个变量
			String name = (String) e.nextElement(); //首先得到名字
			String value = session.getAttribute(name).toString();
			//由名字从session中得到值
			out.println("<br>" + name + " = " + value + " "); //打印

		}
	%>
	<p>HCF在线考试系统</p>
</body>
</html>


