package com.tom.struts.action;

import com.tom.cache.ConfigCache;
import com.tom.dao.PaperDao;
import com.tom.dao.QuestionDao;
import com.tom.dao.UserDao;
import com.tom.dao.UserGroupDao;
import com.tom.dao.UtilDao;
import com.tom.struts.services.AjaxService;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.Html2Text;
import com.tom.util.MD5;
import com.tom.util.PageUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class AjaxAction extends DispatchAction {
	private static Logger log = Logger.getLogger(AjaxAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward getQuestions(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String s_keywords = "";
		String s_dbid = request.getParameter("s_dbid");
		String s_qtype = request.getParameter("s_qtype");
		String pagesize = request.getParameter("pagesize");
		String epage = request.getParameter("epage");
		
		if ((pagesize == null) || ("".equals(pagesize))) {
			pagesize = "10";
		}
		try {
			s_keywords = new String(request.getParameter("s_keywords")
					.getBytes("ISO8859-1"), "UTF-8");
		} catch (Exception localException) {
		}
		
		StringBuffer countsql = new StringBuffer();
		StringBuffer querysql = new StringBuffer();
		StringBuffer conditions = new StringBuffer();

		countsql.append("select count(*) rows from tm_question where 1=1 ");
		querysql.append("select * from tm_question where 1=1 ");

		if ((s_dbid != null) && (!"".equals(s_dbid)))
			conditions.append(" and dbid=" + s_dbid);
		if ((s_qtype != null) && (!"".equals(s_qtype)))
			conditions.append(" and qtype=" + s_qtype);
		if ((s_keywords != null) && (!"".equals(s_keywords)))
			conditions.append(" and content like '%" + s_keywords + "%'");

		countsql.append(conditions);
		querysql.append(conditions);

		querysql.append(" order by id desc");

		PageUtil pu = new PageUtil(request, countsql.toString(),
				querysql.toString(), Util.StringToInt(pagesize));
		pu.setNOW_PAGE(Util.StringToInt(epage));
		List<Map> list = pu.getList();
		List retlist = new ArrayList();
		if ((list != null) && (list.size() > 0)) {
			for (Map map : list) {
				Map m = new HashMap();
				m.put("ID", (String) map.get("ID"));
				m.put("CONTENT",
						Html2Text.Html2TextFormate((String) map.get("CONTENT")));
				m.put("DBID", (String) map.get("DBID"));
				m.put("QTYPE", (String) map.get("QTYPE"));
				retlist.add(m);
			}

			Map info = new HashMap();
			info.put("totalrows", pu.getTOTAL_ROWS());
			info.put("perpage", pagesize);
			info.put("nowpage", pu.getNOW_PAGE());
			info.put("totalpages", pu.getTOTAL_PAGES());

			JSONArray jsonArray = JSONArray.fromObject(retlist);
			echo(jsonArray.toString(), info, request, response);
		}

		return null;
	}

	public ActionForward getPaperSections(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		if ((id == null) || ("".equals(id)))
			return null;
		PaperDao dao = new PaperDao();
		try {
			List list = dao.getPaperSectionList(Util.StringToInt(id));
			JSONArray jsonArray = JSONArray.fromObject(list);
			echo(jsonArray.toString(), null, request, response);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return null;
	}

	public ActionForward getQuestionInfoById(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		QuestionDao dao = new QuestionDao();

		Map question_map = null;
		try {
			question_map = dao.getQuestionById(Util.StringToInt(id));
		} catch (Exception localException) {
		}
		List question_options = null;
		try {
			question_options = dao.getOptionsByQuestionId(Util.StringToInt(id));
		} catch (Exception localException1) {
		}
		Map map = new HashMap();
		if (question_map != null) {
			map.put("CONTENT", question_map.get("CONTENT"));
			map.put("QTYPE", question_map.get("QTYPE"));
			map.put("SKEY", question_map.get("SKEY"));
			map.put("OPTIONS", question_options);

			JSONObject jso = JSONObject.fromObject(map);
			echo(jso.toString(), null, request, response);
		}

		return null;
	}

	public ActionForward checkUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String cw = request.getParameter("cw");
		String val = request.getParameter("val");
		UserDao dao = new UserDao();

		Map map = null;
		try {
			if ("userno".equals(cw))
				map = dao.getUserByUserNo(val);
			else if ("username".equals(cw))
				map = dao.getUserByUserName(val);
			else if ("sfzhm".equals(cw))
				map = dao.getUserBySfzhm(val);
			else if ("email".equals(cw))
				map = dao.getUserByEmail(val);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		if (map == null)
			out("0", request, response);
		else {
			out("1", request, response);
		}
		return null;
	}

	public ActionForward getUserGroups(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		UserGroupDao dao = new UserGroupDao();
		List list = new ArrayList();
		try {
			list = dao.getALlGroups();
			JSONArray jsonArray = JSONArray.fromObject(list);
			echo(jsonArray.toString(), null, request, response);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return null;
	}

	public ActionForward register(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		UserDao dao = new UserDao();
		String sys_sncode = ConfigCache.getConfigByKey("sys_sncode");
		if (SystemCode.free_sncode.equals(sys_sncode)) {
			int total_users = dao.getTotalUsers();
			if (total_users > SystemCode.free_userCount) {
				out("99", request, response);
				return null;
			}

		}

		String userno = request.getParameter("userno");
		String username = request.getParameter("username");
		String userpass = request.getParameter("userpass");
		String realname = request.getParameter("realname");
		String email = request.getParameter("email");
		String mobi = request.getParameter("mobi");
		String gid = request.getParameter("gid");
		String sfzhm = request.getParameter("sfzhm");

		// System.out.println("userno=" + userno + ", username=" + username +
		// ", userpass=" + userpass + ", realname=" + realname);
		try {
			userno = URLDecoder.decode(userno, "UTF-8");
			username = URLDecoder.decode(username, "UTF-8");
			realname = URLDecoder.decode(realname, "UTF-8");
			// System.out.println("userno=" + userno + ", username=" + username
			// + ", realname=" + realname);
		} catch (UnsupportedEncodingException e2) {
			log.error(e2.getMessage());
		}

		Map cmp = null;
		try {
			cmp = dao.getUserByUserName(username);
			if (cmp != null) {
				out("9", request, response);
				return null;
			}

			cmp = dao.getUserByUserNo(userno);
			if (cmp != null) {
				out("8", request, response);
				return null;
			}

			cmp = dao.getUserBySfzhm(sfzhm);
			if (cmp != null) {
				out("7", request, response);
				return null;
			}

		} catch (Exception e1) {
			log.error(e1.getMessage());
		}

		int i = 0;
		try {
			// 注册完即为"已通过审核"状态
/*			i = dao.addUser(userno, username, new MD5().getMD5ofStr(userpass),
					"", "1", realname, email, mobi, "", Util.StringToInt(gid),
					sfzhm);*/
			
			// 注册完即为锁定状态
			i = dao.addUser(userno, username, new MD5().getMD5ofStr(userpass),
					"", "0", realname, email, mobi, "", Util.StringToInt(gid),
					sfzhm);
			
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}

		if (i == 1) {
			
			// Can add the email checker
			
			out("1", request, response);
		} else {
			out("6", request, response);
		}
		return null;
	}

	public ActionForward getLeftTimeOfPaper(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		String uid = request.getParameter("uid");
		String pid = request.getParameter("pid");
		int left = 0;

		UtilDao dao = new UtilDao();
		try {
			left = dao.getPaperLeftTime(uid, pid);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		out(left + "", request, response);
		return null;
	}

	public ActionForward addQc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		out(AjaxService.addQc(request), request, response);
		return null;
	}

	public ActionForward deleteQc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		out(AjaxService.deleteQc(request), request, response);
		return null;
	}

	public ActionForward manualCheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		out(AjaxService.manualCheck(request), request, response);
		return null;
	}

	public ActionForward sendCommand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (this.PCK.HasPrivelege(request, "EXAM_FP"))
			out(AjaxService.sendSystemOrder(request) + "", request, response);
		else
			out("x", request, response);
		return null;
	}

	public ActionForward listenToServer(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		out(AjaxService.sync_server(request), request, response);
		return null;
	}

	public ActionForward currentExam(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		List list = AjaxService.CurrentExamList();
		JSONArray jsonArray = JSONArray.fromObject(list);
		echo(jsonArray.toString(), null, request, response);
		return null;
	}

	public ActionForward newsList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		List list = AjaxService.NewsList();
		JSONArray jsonArray = JSONArray.fromObject(list);
		echo(jsonArray.toString(), null, request, response);
		return null;
	}

	public void echo(String data, Map mapInfo, HttpServletRequest request,
			HttpServletResponse response) {
		PrintWriter out = null;
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		try {
			out = response.getWriter();
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			System.out.println("ajax发生异常:" + e.getMessage());
		}

		if (mapInfo != null) {
			String totalrows = mapInfo.get("totalrows") + "";
			String perpage = mapInfo.get("perpage") + "";
			String nowpage = mapInfo.get("nowpage") + "";
			String totalpages = mapInfo.get("totalpages") + "";

			String info = "\"info\":[";
			info = info + "{\"totalrows\":\"" + totalrows + "\",\"perpage\":\""
					+ perpage + "\",\"nowpage\":\"" + nowpage
					+ "\",\"totalpages\":\"" + totalpages + "\"}";
			info = info + "]";

			data = "{" + info + ",\"datalist\":" + data + "}";
		} else {
			data = "{\"datalist\":" + data + "}";
		}

		out.println(data);
		out.flush();
		out.close();
	}

	public void out(String s, HttpServletRequest request,
			HttpServletResponse response) {
		PrintWriter out = null;
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		try {
			out = response.getWriter();
			request.setCharacterEncoding("UTF-8");
			out.println(s);
			out.flush();
			out.close();
		} catch (Exception e) {
			System.out.println("ajax发生异常:" + e.getMessage());
		}
	}
}