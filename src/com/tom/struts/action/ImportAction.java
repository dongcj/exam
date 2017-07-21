package com.tom.struts.action;

import com.sun.xml.internal.bind.v2.TODO;
import com.tom.cache.ConfigCache;
import com.tom.dao.UtilDao;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.JspFileUpload;
import com.tom.util.MD5;
import com.tom.util.OfficeToolExcel;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.io.File;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.actions.DispatchAction;

public class ImportAction extends DispatchAction {
	private static String ULIST = "user.do?action=list";
	private static String QLIST = "question.do?action=list";
	private static Logger log = Logger.getLogger(ImportAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	String fname = this.sdf.format(new Date());

	public ActionForward user(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("to");
	}

	public ActionForward userimp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_BATCHUP"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		request.setAttribute("surl", ULIST);

		int vi = SystemCode.valiusx(SystemCode.uk,
				ConfigCache.getConfigByKey("sys_sncode"), SystemCode.SERVERIP);
		if (vi != 0) {
			if (vi == 9)
				request.setAttribute("smsg", "SY_AUTHOVER");
			else {
				request.setAttribute("smsg", "NO_COPYRIGHT");
			}
			request.setAttribute("surl", "#");
			return mapping.findForward("msg");
		}
/*
		String sys_sncode = ConfigCache.getConfigByKey("sys_sncode");
		if (SystemCode.free_sncode.equals(sys_sncode)) {
			request.setAttribute("smsg", "VERSION_LIMIT_FUNCTION");
			return mapping.findForward("msg");
		}
*/
		try {
			String upath = getServlet().getServletContext().getRealPath("/files/ups/upfiles/");
			JspFileUpload jfu = new JspFileUpload();
			jfu.setRequest(request);
			jfu.setUploadPath(Util.FUNCTION_FORMAT_PATH(upath));
			System.out.println(Util.FUNCTION_FORMAT_PATH(upath));
			jfu.process();
			String[] fileArr = jfu.getUpdFileNames();
			List list = new ArrayList();
			if (fileArr != null) {
				for (String filename : fileArr) {
					String spath = upath + "\\" + filename;
					spath = Util.FUNCTION_FORMAT_PATH(spath);
					List ls = OfficeToolExcel.readExcel(new File(spath),
							new String[] { "USERNO", "USERNAME", "USERPASS",
									"REALNAME", "EMAIL", "MOBI", "REMARK" });
					list.addAll(ls);
				}
			}

			int rows = 0;
			Object listo = new ArrayList();
			for (listo = list.iterator(); ((Iterator) listo).hasNext();) {
				Map map = (Map) ((Iterator) listo).next();
				if (rows > 0) {
					Object[] o = {
							String.valueOf(map.get("USERNO")),
							String.valueOf(map.get("USERNAME")),
							new MD5().getMD5ofStr(String.valueOf(map
									.get("USERPASS"))),
							String.valueOf(map.get("REALNAME")),
							String.valueOf(map.get("EMAIL")),
							String.valueOf(map.get("MOBI")),
							String.valueOf(map.get("REMARK")) };
					
					((List) listo).add(o);
				}
				rows++;
			}
			try {
				String sql = "insert into tm_user(userno,username,userpass,photo,status,regdate,realname,email,mobi,remark,gid,logintimes) values(?,?,?,'','0',"
						+ SystemCode.SYSDATE + ",?,?,?,?,0,0)";
				new UtilDao().BatchImport(sql, (List) listo);
				DBUtil.commit();
				request.setAttribute("smsg", "IMP_OK");
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
				request.setAttribute("smsg", "IMP_ERR");
			}
		} catch (Exception e) {
			request.setAttribute("smsg", "IMP_ERR");
			log.error(e.getMessage());
		}
		return (ActionForward) (ActionForward) mapping.findForward("msg");
	}
	
	public ActionForward question(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("to");
	}

	public ActionForward masimp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_BATCHUP"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);
	
		request.setAttribute("surl", QLIST);
	
		int vi = SystemCode.valiusx(SystemCode.uk,
				ConfigCache.getConfigByKey("sys_sncode"), SystemCode.SERVERIP);
		if (vi != 0) {
			if (vi == 9)
				request.setAttribute("smsg", "SY_AUTHOVER");
			else {
				request.setAttribute("smsg", "NO_COPYRIGHT");
			}
			request.setAttribute("surl", "#");
			return mapping.findForward("msg");
		}
/*	
		String sys_sncode = ConfigCache.getConfigByKey("sys_sncode");
		if (SystemCode.free_sncode.equals(sys_sncode)) {
			request.setAttribute("smsg", "VERSION_LIMIT_FUNCTION");
			return mapping.findForward("msg");
		}
*/	
		try {
			String upath = getServlet().getServletContext().getRealPath(
					"/files/ups/upfiles/");
			JspFileUpload jfu = new JspFileUpload();
			jfu.setRequest(request);
			jfu.setUploadPath(Util.FUNCTION_FORMAT_PATH(upath));
			System.out.println(Util.FUNCTION_FORMAT_PATH(upath));
			jfu.process();
			String[] fileArr = jfu.getUpdFileNames();
			
			
	
			List list = new ArrayList();
			if (fileArr != null) {
				for (String filename : fileArr) {
					String spath = upath + "\\" + filename;
					spath = Util.FUNCTION_FORMAT_PATH(spath);
					
					//
					System.out.println("file is: " + spath);
					
					List ls = OfficeToolExcel.readExcel(new File(spath),
							new String[] { "DBID", "QTYPE", "CONTENT", "OPTIONS", "SKEY" });
					list.addAll(ls);
					
				}
			}
			
			//判断上传的文件中类型是否合规则
			int rows = 0;
			// System.out.println(list);
			
			List listo = new ArrayList();
			for (Iterator i = list.iterator(); i.hasNext();) {
				Map map = (Map) (i.next());
				if (rows > 0) {
					String DBID_Content = String.valueOf(map.get("DBID"));
					String QTYPE_Content = String.valueOf(map.get("QTYPE"));
					String CONTENT_Content = "<p>" + String.valueOf(map.get("CONTENT")) + "</p>";
					String OPTIONS_Content = String.valueOf(map.get("OPTIONS"));
					String SKEY_Content = String.valueOf(map.get("SKEY"));
					
					if (! DBID_Content.equals("")) {
					// 所有试题必须要有的
					if (QTYPE_Content.equals("") ||  CONTENT_Content.equals("") || SKEY_Content.equals("")) {
						try {
							//删除上传的文件
							if (fileArr != null) {
								for (String filename : fileArr) {
									String spath = upath + "\\" + filename;
									spath = Util.FUNCTION_FORMAT_PATH(spath);
									
									// del file
									File fileTodel = new File(spath);
									if (fileTodel.isFile() && fileTodel.exists()) {
										fileTodel.delete();
										log.info("Current rows Number is: " + rows);
										log.info("文件被删除, 因为所题目的题库ID，试题类型，题干内容及答案都不能为空！");
										
									}
								}
							}
						} catch (Exception e) {
							log.error(e.getStackTrace());
						}
						request.setAttribute("smsg", "QUESTION_NO_SATISFY");
						return mapping.findForward("msg");
					}
					
					// 如果是单选、多选题，必须要有选项
					if (QTYPE_Content.equals("1") || QTYPE_Content.equals("2")) {
						if (OPTIONS_Content.equals("")) {
							try {
								//删除上传的文件
								if (fileArr != null) {
									for (String filename : fileArr) {
										String spath = upath + "\\" + filename;
										spath = Util.FUNCTION_FORMAT_PATH(spath);
										
										// del file
										File fileTodel = new File(spath);
										if (fileTodel.isFile() && fileTodel.exists()) {
											fileTodel.delete();
											log.info("Current rows Number is: " + rows);
											log.info("文件被删除, 因为有选择题的选项为空！");
										}
									}
								}
								
								// 返回用户错误
								request.setAttribute("smsg", "QUESTION_NO_OPTIONS");
								return mapping.findForward("msg");
								
							} catch (Exception e) {
								log.error(e.getStackTrace());
							}
						}
					// 如果非选择题
					} else {
						if (! OPTIONS_Content.equals("")) {
							try {
								//删除上传的文件
								if (fileArr != null) {
									for (String filename : fileArr) {
										String spath = upath + "\\" + filename;
										spath = Util.FUNCTION_FORMAT_PATH(spath);
										
										// del file
										File fileTodel = new File(spath);
										if (fileTodel.isFile() && fileTodel.exists()) {
											fileTodel.delete();
											log.info("Current rows Number is: " + rows);
											log.info("文件被删除, 如果不是选择题，请保持选项目为空！");
										}
									}
								}
								
								// 返回用户错误
								request.setAttribute("smsg", "QUESTION_HAS_OPTIONS");
								return mapping.findForward("msg");
								
							} catch (Exception e) {
								log.error(e.getStackTrace());
							}
						}
					}
					
					// 如果为判断题
					if (QTYPE_Content.equals("3")) {
						SKEY_Content = SKEY_Content.trim().toUpperCase();
						if (! SKEY_Content.equals("YES") && ! SKEY_Content.equals("NO")) {
							try {
								//删除上传的文件
								if (fileArr != null) {
									for (String filename : fileArr) {
										String spath = upath + "\\" + filename;
										spath = Util.FUNCTION_FORMAT_PATH(spath);
										
										// del file
										File fileTodel = new File(spath);
										if (fileTodel.isFile() && fileTodel.exists()) {
											fileTodel.delete();
											log.info("Current rows Number is: " + rows);
											log.info("文件被删除, 因为判断题的答案只能为YES或NO！");
										}
									}
								}
								
								// 返回用户错误
								request.setAttribute("smsg", "QUESTION_MUST_YESORNO");
								return mapping.findForward("msg");
								
							} catch (Exception e) {
								log.error(e.getStackTrace());
							}
						}
					}
					
					// 如果为填空题
					String[] skey2arr = new Util().stringToArr(SKEY_Content);
					String division = "______";
					if (QTYPE_Content.equals("4")) {
						// 题干和答案, 如果空位和答案不一致
						if (CONTENT_Content.split(division).length -1 != skey2arr.length) {
							if (CONTENT_Content.split(division).length -1 <= 0 ) {
								request.setAttribute("smsg", "QUESTION_OF_COMPLETION_NO_BLANK");
								return mapping.findForward("msg");
							}
							try {
								//删除上传的文件
								if (fileArr != null) {
									for (String filename : fileArr) {
										String spath = upath + "\\" + filename;
										spath = Util.FUNCTION_FORMAT_PATH(spath);
										
										// del file
										File fileTodel = new File(spath);
										if (fileTodel.isFile() && fileTodel.exists()) {
											fileTodel.delete();
											log.info("Current rows Number is: " + rows);
											log.info("文件被删除, 因为填空题的空位数与答案的个数不匹配！");
										}
									}
								}
								
								// 返回用户错误
								request.setAttribute("smsg", "QUESTION_ANS_NOMATCH");
								return mapping.findForward("msg");
								
							} catch (Exception e) {
								log.error(e.getStackTrace());
							}
						} else {
							// replace the "_______" with "[BlankArea*]" in CONTENT_Content
							if (CONTENT_Content.endsWith(division)) {
								CONTENT_Content = CONTENT_Content + "。";
							}
							
							String[] contArray = CONTENT_Content.split(division);
							String[] SkeyArray = new Util().stringToArr(SKEY_Content.toString());
							List ans = new ArrayList();
							String tmpstr = "";
							int j = 0;
							for (j = 0; j < contArray.length - 1; j++) {
								if (j == contArray.length - 2) {
									tmpstr += contArray[j] + "[BlankArea" + (j+1) + "]" + contArray[j+1];
									System.out.println("###" + tmpstr);
								} else {
									tmpstr += contArray[j] + "[BlankArea" + (j+1) + "]";
									System.out.println("######" + tmpstr);
								}
								// replace the SKEY_Content to json
								ans.add("{\"VAL\"" + ":" + "\"" + SkeyArray[j] + "\"" + "," + "\"ID\"" + ":" +  "\"" + (j + 1) + "\"" + "}");
							} 
							
							SKEY_Content = ans.toString();
							CONTENT_Content = tmpstr;
						}
					}
					
					
					Object[] o = {
							DBID_Content,
							QTYPE_Content,
							CONTENT_Content,
							SKEY_Content,
							OPTIONS_Content,
							};
					listo.add(o);
				}
				}
				rows++;
//				}
			}
			try {
				new UtilDao().BatchImportq(listo);
				DBUtil.commit();
				request.setAttribute("smsg", "IMP_OK");
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
				request.setAttribute("smsg", "IMP_ERR");
			}
		} catch (Exception e) {
			request.setAttribute("smsg", "IMP_ERR");
			log.error(e.getMessage());
		}
		return (ActionForward) (ActionForward) mapping.findForward("msg");
	}
	
}