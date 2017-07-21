<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String[] usercheckboxs = request.getParameterValues("usercheckbox");


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>页面打印</title>
		<!--media=print 这个属性在打印时有效 有些不想打印出来的分页打印的都可以应用这类样式进行控制 在非打印时是无效的(可从打印预览中看到效果)-->
		<style media=print>
			/* 应用这个样式的在打印时隐藏 */
			.noPrint {
				display: none;
			}
			
			/* 应用这个样式的，从那个标签结束开始另算一页，之后在遇到再起一页，以此类推 */
			.page {
				page-break-after: always;
			}
		</style>

		<!-- 这个是普通样式 -->
		<style type="text/css">
			.tab td {
				border-bottom: 1 solid #000000;
				border-left: 1 solid #000000;
				border-right: 0 solid #ffffff;
				border-top: 0 solid #ffffff;
			}
			
			.tab {
				border-color: #000000 #000000 #000000 #000000;
				border-style: solid;
				border-top-width: 2px;
				border-right-width: 2px;
				border-bottom-width: 1px;
				border-left-width: 1px;
			}
			
			.hr {
				font-family: "宋体";
				font-size: 9pt;
			}
		</style>
		<script language="JavaScript" type="text/JavaScript">
			var hkey_root, hkey_path, hkey_key;   
			hkey_root = "HKEY_CURRENT_USER";
			hkey_path = "//Software//Microsoft//Internet Explorer//PageSetup//";
			//这个是用来设置打印页眉页脚的，你可以设置为空或者其它
			try{   
				var RegWsh = new ActiveXObject("WScript.Shell"); 
				hkey_key="header";
				RegWsh.RegWrite(hkey_root+hkey_path+hkey_key, "&w&b页码，&p/&P");
				hkey_key="footer";
				RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
			}catch(e){
				alert(e.description());
			}
	</script>
  </head>
  
  <body bgcolor="white">
		<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
			<thead class="noPrint">
				<tr>
					<td align="center" colspan="3">
						<center class="NoPrint">
							<OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT>
							<input type=button value=打印 onclick=document.all.WebBrowser.ExecWB(6,1)>
							<input type=button value=直接打印 onclick=document.all.WebBrowser.ExecWB(6,6) />
							<input type=button value=页面设置 onclick=document.all.WebBrowser.ExecWB(8,1) />
							<input type=button value=打印预览 onclick=document.all.WebBrowser.ExecWB(7,1) />
							<!--
							关于这个组件还有其他的用法，列举如下： 
							WebBrowser.ExecWB(1,1) 打开 
							Web.ExecWB(2,1) 关闭现在所有的IE窗口，并打开一个新窗口 
							Web.ExecWB(4,1) 保存网页 
							Web.ExecWB(6,1) 打印 
							Web.ExecWB(7,1) 打印预览 
							Web.ExecWB(8,1) 打印页面设置 
							Web.ExecWB(10,1) 查看页面属性 
							Web.ExecWB(15,1) 好像是撤销，有待确认 
							Web.ExecWB(17,1) 全选 
							Web.ExecWB(22,1) 刷新 
							Web.ExecWB(45,1) 关闭窗体无提示 
							-->
						</center>
					</td>
				</tr>
			</thead>
			<tr>
				<td align="center" colspan="3" style="font-size: 24px">
					<b>报告印章申请表</b>  <%=usercheckboxs.length %>
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">编号：A002&nbsp;</td>			
				<td align="right">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3">
					<table class="tab" cellSpacing="0" cellPadding="0" width="100%">
						<tr align="center" height="23">
							<td width="10%" height="23"><b>编号</b></td>
							<td width="5%"><b>份数</b></td>
							<td width="12%"><b>项目/级别编号</b></td>
							<td width="12%"><b>单位</b></td>
							<td width="12%"><b>项目名称</b></td>
							<td width="12%"><b>工程地点</b></td>
							<td width="12%"><b>检测项目</b></td>
							<td width="7%"><b>单价</b></td>
							<td width="8%"><b>数量</b></td>
							<td width="10%"><b>总价</b></td>
						</tr>
						<tr style="font-size: 13px" align="center" height="23">
							<td>A14785&nbsp;</td>
							<td>5&nbsp;</td>
							<td>A1546/8975&nbsp;</td>
							<td>中国广东广州&nbsp;</td>
							<td>BRT工程&nbsp;</td>
							<td>广州天河&nbsp;</td>
							<td>BRT工程&nbsp;</td>
							<td>￥999999999.99</td>
							<td>20&nbsp;</td>
							<td>20*￥999999999.99&nbsp;</td>
						</tr>
						<tr align="center" height="23">
							<td colspan="2">备注</td>
							<td colspan="8">&nbsp;</td>
						</tr>						
					</table>
				</td>
			</tr>
		</table>
		<hr class="noprint" width="100%" size="2"/>
		<div class="page"></div>
		<table class="tab" cellSpacing="0" cellPadding="0" width="100%">
			<tr align="center" height="23">
				<td width="10%" height="23"><b>编号</b></td>
				<td width="5%"><b>份数</b></td>
				<td width="12%"><b>项目/级别编号</b></td>
				<td width="12%"><b>单位</b></td>
				<td width="12%"><b>项目名称</b></td>
				<td width="12%"><b>工程地点</b></td>
				<td width="12%"><b>检测项目</b></td>
				<td width="7%"><b>单价</b></td>
				<td width="8%"><b>数量</b></td>
				<td width="10%"><b>总价</b></td>
			</tr>
			<tr style="font-size: 13px" align="center" height="23">
				<td>A14785&nbsp;</td>
				<td>5&nbsp;</td>
				<td>A1546/8975&nbsp;</td>
				<td>中国广东广州&nbsp;</td>
				<td>BRT工程&nbsp;</td>
				<td>广州天河&nbsp;</td>
				<td>BRT工程&nbsp;</td>
				<td>￥999999999.99</td>
				<td>20&nbsp;</td>
				<td>20*￥999999999.99&nbsp;</td>
			</tr>
			<tr align="center" height="23">
				<td colspan="2">备注</td>
				<td colspan="8">&nbsp;</td>
			</tr>						
		</table>

		<div class="page"></div>
		<table class="tab" cellSpacing="0" cellPadding="0" width="100%">
			<tr align="center" height="23">
				<td width="10%" height="23"><b>编号</b></td>
				<td width="5%"><b>份数</b></td>
				<td width="12%"><b>项目/级别编号</b></td>
				<td width="12%"><b>单位</b></td>
				<td width="12%"><b>项目名称</b></td>
				<td width="12%"><b>工程地点</b></td>
				<td width="12%"><b>检测项目</b></td>
				<td width="7%"><b>单价</b></td>
				<td width="8%"><b>数量</b></td>
				<td width="10%"><b>总价</b></td>
			</tr>
			<tr style="font-size: 13px" align="center" height="23">
				<td>A14785&nbsp;</td>
				<td>5&nbsp;</td>
				<td>A1546/8975&nbsp;</td>
				<td>中国广东广州&nbsp;</td>
				<td>BRT工程&nbsp;</td>
				<td>广州天河&nbsp;</td>
				<td>BRT工程&nbsp;</td>
				<td>￥999999999.99</td>
				<td>20&nbsp;</td>
				<td>20*￥999999999.99&nbsp;</td>
			</tr>
			<tr align="center" height="23">
				<td colspan="2">备注</td>
				<td colspan="8">&nbsp;</td>
			</tr>						
		</table>

	</body>
</html>
