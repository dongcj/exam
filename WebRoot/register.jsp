<%@ page language="java" import="java.util.List,java.util.Map,com.tom.cache.ConfigCache" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String sys_register = ConfigCache.getConfigByKey("sys_register");
%>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=ConfigCache.getConfigByKey("sys_sitename") %> - 用户注册</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="skins/default/style.css" />
	<script src="inc/jquery.js"></script>
	
	<script src="inc/util.js" type="text/javascript"></script>
	<script src="inc/user/register.js" type="text/javascript"></script>
	
	<style>
		.container{width:100%; float:left}
		.main{ width:800px; margin:0 auto; height:auto;}
		.mainbody{ width:798px; border:solid 1px #eee; border-top:none}
		.cont{ width:800px; margin:0 auto; height:430px; margin-right:15px}
		.cont_info{ padding:15px;}
		.cont_table{ padding:15px;padding-top:0px}
		
		.logo{width:800px; height:160px; background:url('skins/images/register.jpg');}
		.logo div{ position:relative; top:140px; left:10px; color:#fff}
		.logo div a{color:#f00}
		
		.tip{color:#aaa}
	</style>
	
</head>
<body>

	<div class="container">
		<div class="main">
			<div class="logo">
				<div>当前位置：<a href="index.jsp">首页</a> &gt; 用户注册 </div>
			</div>
		</div>
	</div>
	
	
	<div class="container">
		<div class="main mainbody">
			<div class="cont">
			
				<!-- 功能介绍 -->
				<div class="cont_info">
					请如实填写下列基本信息。<br/>
					个人资料被审核后可以根据用户名和密码登陆系统，并参加考试。 
				</div>
				
				<!-- 注册表单 -->
				<div class="cont_table">
					<form action="" method="post" id="form1">
					<table class="stable" width="100%" align="center">
						<tr>
							<td width="100" class="thx">工号</td>
							<td class="aleft"><input type="text" class="txt" maxlength="10" name="userno" id="userno" /> * <span id="userno_tip" class="tip">请填写自己的工号,三位以上且必须全为数字</span> <span id="span_userno"></span> </td>
						</tr>
						
						<tr>
							<td width="100" class="thx">用户名</td>
							<td class="aleft"><input type="text" class="txt" maxlength="10" name="username" id="username" /> * <span id="username_tip" class="tip">如：xiaoming</span> <span id="span_username"></span> </td>
						</tr>
						
						<tr>
							<td class="thx">登陆密码</td>
							<td><input maxlength="20" class="txt" type="password" name="userpass" id="userpass" /> * <span id="userpass_tip" class="tip">请设置登录密码</span> <span id="span_userpass"></span></td>
						</tr>
						
						<tr>
							<td class="thx">重复密码</td>
							<td><input class="txt" type="password" name="userpass2" id="userpass2" /> * <span id="userpass2_tip" class="tip">请和登陆密码保持一致</span> <span id="span_userpass2"></span></td>
						</tr>
						
						<tr>
							<td class="thx">身份证号码</td>
							<td><input type="text" class="txt" maxlength="20" name="sfzhm" id="sfzhm" /> * <span id="sfzhm_tip" class="tip">请输入有效身份证号码</span> <span id="span_sfzhm"></span> </td>
						</tr>
						
						<tr>
							<td class="thx">真实姓名</td>
							<td><input type="text" class="txt" maxlength="10" name="realname" id="realname" /> * <span id="realname_tip" class="tip">请输入真实姓名</span> <span id="span_realname"></span> </td>
						</tr>
						
						<tr>
							<td class="thx">所属部门</td>
							<td>
								<select id="gid"><option value="">加载分组信息中...</option></select> *  <span id="gid_tip" class="tip">请选择您所在的部门</span> <span id="span_gid"></span>
							</td>
						</tr>
						
						<tr>
							<td class="thx">电子邮箱</td>
							<td><input type="text" class="txt" maxlength="30" name="email" id="email"  />  <span id="email_tip" class="tip"></span> <span id="span_email"></span></td>
						</tr>
						<tr>
							<td class="thx">联系电话</td>
							<td><input type="text" class="txt" maxlength="20" name="mobi" id="mobi"  /> <span id="mobi_tip" class="tip"></span> <span id="span_mobi"></span> </td>
						</tr>
						<tr>
							<td class="thx" height="50"></td>
							<td>
								<%
								if("on".equals(sys_register)){
									%>
									<input type="button" value=" 提 交 " class="btn" id="btnsubmit" />
									<input type="reset" value=" 重 置 " class="btn" />
									<%
								}else{
								%>
									<font color="red">对不起，用户注册功能被管理员关闭。</font>
								<%
								}
								%>
							</td>
						</tr>
						
					</table>
					</form>
					
				</div>
				<!-- 注册表单 -->
				
			</div><!-- end of cont -->
			
		</div><!-- end of main -->
		
	</div>
	
	<div class="logininfo" style="padding-top:10px">
		Copyright &copy; <b>HCF Exam</b> All Right Reserved 2013-2014
		<p></p>
	</div>
	

</body>
</html>


