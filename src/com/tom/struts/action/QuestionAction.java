package com.tom.struts.action;

import com.tom.cache.CacheUtil;
import com.tom.cache.ConfigCache;
import com.tom.dao.DbDao;
import com.tom.dao.QuestionDao;
import com.tom.dao.UserDao;
import com.tom.struts.form.QuestionForm;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.EscapeUtil;
import com.tom.util.PageUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.AbstractDocument.Content;

import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class QuestionAction extends DispatchAction {
	private static String QUESTION_LIST = "question.do?action=list";
	private static Logger log = Logger.getLogger(QuestionAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

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

		DbDao dao = new DbDao();
		try {
			request.setAttribute("DBLIST", dao.getDbList("1"));
		} catch (Exception localException) {
		}
		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		QuestionDao dao = new QuestionDao();
		request.setAttribute("surl", QUESTION_LIST);

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

		String sys_sncode = ConfigCache.getConfigByKey("sys_sncode");
		if (SystemCode.free_sncode.equals(sys_sncode)) {
			int total_questions = dao.getTotalQuestions();
			if (total_questions > 100000) {
				request.setAttribute("smsg", "VERSION_LIMIT_QES");
				return mapping.findForward("msg");
			}

		}

		QuestionForm f = (QuestionForm) form;
		int i = 0;

		String SKEY = "";
		String qcomplex;
		JSONArray jsonArray;
		if ((1 == f.getQtype().intValue()) || (2 == f.getQtype().intValue())) {
			String[] _SEKYS = request.getParameterValues("skey");
			if ((_SEKYS != null) && (_SEKYS.length > 0))
				for (String s : _SEKYS)
					SKEY = SKEY + s;
		} else if (4 == f.getQtype().intValue()) {
			List ls = new ArrayList();
			Pattern p = Pattern.compile("\\[BlankArea.+?]");
			Matcher m = null;
			m = p.matcher(f.getContent());
			while (m.find()) {
				String blank = m.group();
				String blankid = blank.replace("BlankArea", "").replaceAll(
						"\\]", "");
				blankid = blankid.substring(1);
				Map _map = new HashMap();
				_map.put("ID", blankid);
				_map.put("VAL", request.getParameter("skey" + blankid));
				ls.add(_map);
			}

			Object cmap = new HashMap();

			qcomplex = request.getParameter("qcomplex");
			if ("yes".equals(qcomplex))
				((Map) cmap).put("QCOMPLEX", "YES");
			else {
				((Map) cmap).put("QCOMPLEX", "NO");
			}
			ls.add(cmap);

			jsonArray = JSONArray.fromObject(ls);
			SKEY = jsonArray.toString();
		} else {
			SKEY = f.getSkey();
		}

		try {
			i = dao.addQuestion(f.getDbid().intValue(),
					f.getQtype().intValue(), f.getQlevel().intValue(), f
							.getQfrom().intValue(), f.getStatus(), f
							.getContent(), SKEY, f.getKeydesc(), f.getAdminid()
							.intValue());
			DBUtil.commit();
			int last_insert_questionid = dao.LAST_INSERT_QUESTIONID();
			if ((1 == f.getQtype().intValue())
					|| (2 == f.getQtype().intValue()))
				try {
					List listOfOptions = new ArrayList();
					String[] sopions = request.getParameterValues("soption");
					if ((sopions != null) && (sopions.length > 0)) {
						// String[] arrayOfString2;
						// jsonArray = (arrayOfString2 = sopions);
						for (int ii = 0; ii < sopions.length; ii++) {
							String s = sopions[ii];
							listOfOptions.add(s);
						}
					}
					dao.addOptions(last_insert_questionid, listOfOptions);
					DBUtil.commit();
				} catch (Exception e) {
					DBUtil.rollback();
					log.error(e.getMessage());
				}
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "SAVE_QUESTION_OK");
		else {
			request.setAttribute("smsg", "SAVE_QUESTION_ERR");
		}
		return (ActionForward) mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DbDao ddao = new DbDao();
		try {
			request.setAttribute("DBLIST", ddao.getDbList("1"));
		} catch (Exception localException) {
		}
		String countsql = "select count(*) rows from tm_question tq where 1=1";
		String querysql = "select tq.*,tdb.dname from tm_question tq left join tm_question_db tdb on tq.dbid=tdb.id where 1=1";

		String s_keywords = "";
		String s_dbid = request.getParameter("s_dbid");
		String s_qtype = request.getParameter("s_qtype");

		StringBuffer conditions = new StringBuffer();
		try {
			s_keywords = new String(request.getParameter("s_keywords")
					.getBytes("ISO8859-1"), "UTF-8");
			request.setAttribute("s_keywords", EscapeUtil.escape(s_keywords));
		} catch (Exception localException1) {
		}
		if ((s_dbid != null) && (!"".equals(s_dbid)))
			conditions.append(" and tq.dbid=" + s_dbid);
		if ((s_qtype != null) && (!"".equals(s_qtype)))
			conditions.append(" and tq.qtype=" + s_qtype);
		if ((s_keywords != null) && (!"".equals(s_keywords)))
			conditions.append(" and tq.content like '%" + s_keywords + "%'");

		countsql = countsql + conditions.toString();
		querysql = querysql + conditions.toString();

		querysql = querysql + " order by tq.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 20);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		QuestionDao dao = new QuestionDao();
		request.setAttribute("surl", QUESTION_LIST);

		DbDao ddao = new DbDao();
		try {
			request.setAttribute("DBLIST", ddao.getDbList("1"));
		} catch (Exception localException1) {
		}
		Map map = null;
		try {
			map = dao.getQuestionById(Util.StringToInt(id));
			request.setAttribute("question", map);
		} catch (Exception e) {
			request.setAttribute("smsg", "LOAD_QUESTION_ERR");
			return mapping.findForward("msg");
		}

		try {
			JSONArray jsonArray = JSONArray.fromObject(dao
					.getOptionsByQuestionId(Util.StringToInt(id)));
			request.setAttribute("OPTION_LIST", jsonArray);
		} catch (Exception localException2) {
		}
		if (map == null) {
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}
		return mapping.findForward("to");
	}

	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		QuestionForm f = (QuestionForm) form;
		request.setAttribute("surl", QUESTION_LIST);
		QuestionDao dao = new QuestionDao();
		int i = 0;

		String SKEY = "";
		Object cmap;
		String qcomplex;
		JSONArray jsonArray;
		if ((1 == f.getQtype().intValue()) || (2 == f.getQtype().intValue())) {
			String[] _SEKYS = request.getParameterValues("skey");
			if ((_SEKYS != null) && (_SEKYS.length > 0))
				for (String s : _SEKYS)
					SKEY = SKEY + s;
		} else if (4 == f.getQtype().intValue()) {
			List ls = new ArrayList();
			Pattern p = Pattern.compile("\\[BlankArea.+?]");
			Matcher m = null;
			
			
/*			String content = f.getContent();
			log.info("###Before content is: " + content);
			// Replace The "____" with [BlankArea*]
			String tmpstr = "";
			int j;
			String division = "______";
			String[] contArray = content.split(division);
			for (j = 0; j < content.split(division).length - 1; j++) {
				tmpstr += contArray[j] + "[BlankArea" + (j+1) + "]";
			}
			log.info("###After content is: " + tmpstr);
			m = p.matcher(tmpstr);*/
			
			
			m = p.matcher(f.getContent());
			while (m.find()) {
				String blank = m.group();
				String blankid = blank.replace("BlankArea", "").replaceAll(
						"\\]", "");
				blankid = blankid.substring(1);
				Map _map = new HashMap();
				_map.put("ID", blankid);
				_map.put("VAL", request.getParameter("skey" + blankid));
				ls.add(_map);
			}

			cmap = new HashMap();

			qcomplex = request.getParameter("qcomplex");
			if ("yes".equals(qcomplex))
				((Map) cmap).put("QCOMPLEX", "YES");
			else {
				((Map) cmap).put("QCOMPLEX", "NO");
			}
			ls.add(cmap);

			jsonArray = JSONArray.fromObject(ls);
			SKEY = jsonArray.toString();
		} else {
			SKEY = f.getSkey();
		}
		try {
			i = dao.updateQuestion(Util.StringToInt(id),
					f.getDbid().intValue(), f.getQtype().intValue(), f
							.getQlevel().intValue(), f.getQfrom().intValue(), f
							.getStatus(), f.getContent(), SKEY, f.getKeydesc());
			dao.deleteOptionPyQuestionId(Util.StringToInt(id));
			DBUtil.commit();
			if ((1 == f.getQtype().intValue())
					|| (2 == f.getQtype().intValue()))
				try {
					List listOfOptions = new ArrayList();
					String[] sopions = request.getParameterValues("soption");
					if ((sopions != null) && (sopions.length > 0)) {
						for (int ii = 0; ii < sopions.length; ii++) {
							String s = sopions[ii];
							listOfOptions.add(s);
						}
					}
					dao.addOptions(Util.StringToInt(id), listOfOptions);
					DBUtil.commit();

					CacheUtil.removeCache("QuestionCache", id);
				} catch (Exception e) {
					DBUtil.rollback();
					log.error(e.getMessage());
				}
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "UPDATE_QUESTION_OK");
		else {
			request.setAttribute("smsg", "UPDATE_QUESTION_ERR");
		}
		return (ActionForward) mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		QuestionDao dao = new QuestionDao();
		request.setAttribute("surl", QUESTION_LIST);
		int i = 0;
		try {
			i = dao.deleteQuestionById(Util.StringToInt(id));

			dao.deleteOptionPyQuestionId(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_QUESTION_OK");
		else {
			request.setAttribute("smsg", "DELETE_QUESTION_ERR");
		}
		return mapping.findForward("msg");
	}
	
	
	public ActionForward batch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "QUESTION_BATCHOP"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		request.setAttribute("surl", QUESTION_LIST);
		String batchop = request.getParameter("batchop");
		String s_gid = request.getParameter("s_gidx");
		String s_status = request.getParameter("s_statusx");
		String[] uids = request.getParameterValues("usercheckbox");
		UserDao dao = new UserDao();

		if ((s_gid == null) || (s_gid.length() < 0))
			s_gid = "0";
		if ((s_status == null) || (s_status.length() < 0))
			s_status = "0";
		try {
			if ("1".equals(batchop)) {
				dao.batchDelete(uids);
			} else if ("2".equals(batchop)) {
				dao.batchSetStatus(uids, s_status);
			} else if ("3".equals(batchop)) {
				dao.batchSetGid(uids, Integer.parseInt(s_gid));
			}
			DBUtil.commit();
			request.setAttribute("smsg", "BATCH_OK");
		} catch (Exception e) {
			e.printStackTrace();
			DBUtil.rollback();
			log.error(e.getMessage());
			request.setAttribute("smsg", "BATCH_ERR");
		}
		return mapping.findForward("msg");
	}
}