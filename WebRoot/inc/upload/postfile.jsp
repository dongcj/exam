<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.tom.util.JspFileUpload" %>
<%@ page import="com.tom.util.FolderMaker" %>
<%@ page import="com.tom.util.*" %>
<html>
<head>
<title>upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
	body{font-size:9pt}
	body,form{margin:0;padding:0}
</style>
</head>
<body>
<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
	String fname = sdf.format(new java.util.Date());
	
	
	String upath = config.getServletContext().getRealPath("/upload/");
	upath = upath + "\\" + fname;
	
	
	FolderMaker fm = new FolderMaker();
	boolean bmk = fm.CreateFolder(upath);
	
	
	String a = request.getServletPath();
	
	upath = upath.replaceAll("\\\\","\\\\\\\\");
	upath = upath.replaceAll("/","//");
	
	if(upath.indexOf("/")>-1){
		upath = upath + "//";
	}else{
		upath = upath + "\\\\";
	}	
	
	//out.println(upath);
	
	JspFileUpload jfu = new JspFileUpload();
	jfu.setRequest(request);
	jfu.setUploadPath(upath);
	jfu.process();
	String[] fileArr = jfu.getUpdFileNames();
	
	String ffff = upath+fileArr[0];
	
	 out.println("<script>");
	 if(ffff != null){
	 	String sfilename = ffff.toLowerCase();
	 	if(!sfilename.endsWith("jpg") && !sfilename.endsWith("png") && !sfilename.endsWith("bmp") && !sfilename.endsWith("gif")){
	 		out.println("	document.writeln('只允许上传图片文件');");
	 		out.println("	document.writeln(\" - [<a href=\'postfile.html\'>返回</a>]\");");
	 	}else{
	 		out.println("	document.writeln('上传成功');");
			out.println("	document.writeln(\" - [<a href=\'postfile.html\'>返回</a>]\");");
			out.println("	if(parent.$get('photo')!=null){");
			out.println("		parent.$get('photo').value = 'upload/"+fname+"/"+fileArr[0]+"';");
			out.println("		parent.$get('img_photo').src = 'upload/"+fname+"/"+fileArr[0]+"';");
			out.println("		parent.$get('img_photo').style.display = 'block';");
			out.println("	}");
	 	}
	 }
	 out.println("</script>");
	 
	 
%>






</body>
</html>
