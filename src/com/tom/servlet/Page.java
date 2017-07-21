package com.tom.servlet;

import com.tom.cache.PaperCache;
import com.tom.dao.UserPaperDao;
import com.tom.util.MD5;
import com.tom.util.OfficeToolExcel;
import com.tom.util.OfficeToolWord;
import com.tom.util.Util;
import com.tom.vo.VOPaper;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class Page extends HttpServlet {
	private static final long serialVersionUID = 6727954560824535860L;
	private static Logger log = Logger.getLogger(Page.class);

	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		boolean isok = false;
		String action = req.getParameter("action");
		PrintWriter out = response.getWriter();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmSS");

		if ("download_paper".equals(action)) {
			String pid = req.getParameter("pid");
			String md5_pid = new MD5().getMD5ofStr("PAP" + pid + "ER"
					+ sdf.format(new Date()));
			String basepath = getServletContext().getRealPath(
					"/files/dows/" + md5_pid + ".doc");
			log.info("导出试卷到Word文档...[" + pid + "]..." + basepath);
			isok = download_paper(Util.FUNCTION_FORMAT_PATH(basepath), pid);
			response.sendRedirect("files/dows/" + md5_pid + ".doc");
			return;
		}
		if ("download_examlist".equals(action)) {
			String pid = req.getParameter("pid");
			if (pid != null) {
				VOPaper PAPER = PaperCache.getPaperById(pid);
				if (PAPER != null) {
					String md5_pid = new MD5().getMD5ofStr("PAP" + pid + "ER"
							+ sdf.format(new Date()));
					String basepath = getServletContext().getRealPath(
							"/files/dows/" + md5_pid + ".xls");
					log.info("导出考试详情到Excel文档...[" + pid + "]..." + basepath);
					List<Map> list = getPaperExamByPid(pid);

					List ls = new ArrayList();
					Map mmt = new HashMap();
					mmt.put("考试姓名", null);
					mmt.put("试卷得分", null);
					mmt.put("开始时间", null);
					mmt.put("交卷时间", null);
					mmt.put("IP地址", null);
					ls.add(mmt);

					for (Map m : list) {
						Map mm = new HashMap();
						mm.put("考试姓名", String.valueOf(m.get("REALNAME")));
						mm.put("试卷得分", String.valueOf(m.get("SCORE")));
						mm.put("开始时间", String.valueOf(m.get("SDATE")));
						mm.put("交卷时间", String.valueOf(m.get("EDATE")));
						mm.put("IP地址", String.valueOf(m.get("IP")));
						ls.add(mm);
					}
					try {
						OfficeToolExcel.makeExcel(
								Util.FUNCTION_FORMAT_PATH(basepath),
								PAPER.getPaperName(), ls, new int[] { 20, 20,
										20, 20, 20 });
						isok = true;
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					response.sendRedirect("files/dows/" + md5_pid + ".xls");
				}
			}

			return;
		}

		try {
			out.print(isok ? "操作成功." : "操作失败");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	private boolean download_paper(String filepath, String pid) {
		try {
			OfficeToolWord.makePaperDoc(filepath, pid);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	private List getPaperExamByPid(String pid) {
		UserPaperDao dao = new UserPaperDao();
		try {
			List ls = dao.getPaperExamByPid(pid);
			return ls;
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
		return new ArrayList();
	}
}