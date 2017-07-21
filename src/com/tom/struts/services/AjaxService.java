package com.tom.struts.services;

import com.tom.dao.NewsDao;
import com.tom.dao.OnlineDao;
import com.tom.dao.PaperExamDao;
import com.tom.dao.QcDao;
import com.tom.dao.UtilDao;
import com.tom.util.DBUtil;
import com.tom.util.Util;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class AjaxService {
	private static Logger log = Logger.getLogger(AjaxService.class);

	public static String addQc(HttpServletRequest request) {
		QcDao dao = new QcDao();
		String uid = request.getParameter("uid");
		String qid = request.getParameter("qid");
		String did = request.getParameter("did");
		int i = 0;
		try {
			i = dao.addQc(Util.StringToInt(qid), Util.StringToInt(uid),
					Util.StringToInt(did));
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		return i + "";
	}

	public static String deleteQc(HttpServletRequest request) {
		QcDao dao = new QcDao();
		String id = request.getParameter("id");
		int i = 0;
		try {
			i = dao.deleteQc(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		return i + "";
	}

	public static String manualCheck(HttpServletRequest request) {
		PaperExamDao dao = new PaperExamDao();
		int n = 0;

		String pid = request.getParameter("pid");
		String uid = request.getParameter("uid");
		String did = request.getParameter("did");
		String iid = request.getParameter("iid");
		String score = request.getParameter("score");
		try {
			n = dao.SETScore(Util.StringToInt(did), Util.StringToInt(score));
			if (n > 0) {
				n = dao.RECountTotalScore(Util.StringToInt(pid),
						Util.StringToInt(uid), Util.StringToInt(iid)) + 1;
			}
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
			n = 0;
		}

		return n + "";
	}

	public static String sync_server(HttpServletRequest request) {
		String str = "";
		String TomUserId = (String) request.getSession().getAttribute(
				"TomUserId");
		String pid = request.getParameter("pid") == null ? "0" : request
				.getParameter("pid");

		Map map = null;
		try {
			map = new OnlineDao().syncOnlineStatus(Util.StringToInt(TomUserId),
					Util.StringToInt(pid), "", request.getRemoteAddr());
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}

		if (map == null)
			str = "";
		else {
			str = (String) map.get("EXTA");
		}
		return str;
	}

	public static int sendSystemOrder(HttpServletRequest request) {
		int i = -1;
		String scmd = request.getParameter("scmd");
		String uid = request.getParameter("uid");
		try {
			i = new OnlineDao().sendCommand(scmd, Util.StringToInt(uid));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return i;
	}

	public static List CurrentExamList() {
		List list = new ArrayList();
		try {
			list = new UtilDao().CurrentExamList();
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return list;
	}

	public static List NewsList() {
		List list = new ArrayList();
		try {
			list = new NewsDao().getNewsList(5);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return list;
	}
}