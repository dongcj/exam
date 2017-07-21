package com.tom.struts.action;

import com.tom.cache.ConfigCache;
import com.tom.cache.PaperCache;
import com.tom.dao.OnlineDao;
import com.tom.dao.UserPaperDao;
import com.tom.util.DBUtil;
import com.tom.util.PageUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import com.tom.vo.VOPaper;
import com.tom.vo.VOQuestion;
import com.tom.vo.VOSection;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class UserpaperAction extends DispatchAction {
	private static Logger log = Logger.getLogger(UserpaperAction.class);

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String TomUserType = (String) request.getSession().getAttribute(
				"TomUserType");
		Map TomUser = (Map) request.getSession().getAttribute("TomUser");
		String uid = (String) request.getSession().getAttribute("TomUserId");

		if ("2".equals(TomUserType)) {
			if (TomUser != null) {
				String gid = TomUser.get("GID").toString();
				String sonsql = "select paperid from tm_paper_usergroup where usergroupid="
						+ gid
						+ " and paperid not in ("
						+ "select pid from tm_exam_info where uid="
						+ uid
						+ " and status in('1','2'))";

				String countsql = "select count(*) rows from tm_paper tp where tp.id in("
						+ sonsql + ") and tp.status='1'";
				String querysql = "select tp.* from tm_paper tp where tp.id in("
						+ sonsql + ") and tp.status='1' order by tp.id desc";

				PageUtil pu = new PageUtil(request, countsql, querysql, 20);
				request.setAttribute("list", pu.getList());
			}
		} else
			log.warn("TomUserType=" + TomUserType + "的用户试图访问试卷列表");

		return mapping.findForward("to");
	}

	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");

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

		String sys_uncheckuser_exam = ConfigCache
				.getConfigByKey("sys_uncheckuser_exam");
		if (!"on".equals(sys_uncheckuser_exam)) {
			Map umap = (Map) request.getSession().getAttribute("TomUser");
			if (umap != null) {
				String _status = (String) umap.get("STATUS");
				if (!"1".equals(_status)) {
					request.setAttribute("surl", "paper.do?action=list");
					request.setAttribute("smsg", "UNCHECKUSER_NO_EXAM");
					return mapping.findForward("msg");
				}

			}

		}

		VOPaper PAPER = PaperCache.getPaperById(id);
		if (PAPER != null) {
			String paper_start = PAPER.getPaperStart();
			String paper_end = PAPER.getPaperEnd();
			
			paper_start = paper_start.replaceAll("/", "").replaceAll(" ", "")
					.replaceAll(":", "");
			paper_end = paper_end.replaceAll("/", "").replaceAll(" ", "")
					.replaceAll(":", "");
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			try {
				paper_start = sdf.format(sdf.parse(paper_start));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			String now_date = sdf.format(new Date());

			if (now_date.compareTo(paper_start) < 0) {
				request.setAttribute("surl", "paper.do?action=list");
				request.setAttribute("smsg", "NOT_START");
				return mapping.findForward("msg");
			}
			if (now_date.compareTo(paper_end) > 0) {
				request.setAttribute("surl", "paper.do?action=list");
				request.setAttribute("smsg", "ALLREADY_END");
				return mapping.findForward("msg");
			}
		}

		String uid = (String) request.getSession().getAttribute("TomUserId");
		UserPaperDao dao = new UserPaperDao();
		int i = 0;
		try {
			i = dao.addExamMainInfo(Util.StringToInt(uid),
					Util.StringToInt(id), new Date(), null,
					request.getRemoteAddr(), "");
			if (i > 0)
				DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}

		request.setAttribute("PAPER", PAPER);
		return mapping.findForward("to");
	}

	public ActionForward history(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String TomUserType = (String) request.getSession().getAttribute(
				"TomUserType");
		Map TomUser = (Map) request.getSession().getAttribute("TomUser");
		String uid = (String) request.getSession().getAttribute("TomUserId");

		if ("2".equals(TomUserType)) {
			if (TomUser != null) {
				String sonsql = "select pid from tm_exam_info where uid=" + uid
						+ " and status in('1','2')";

				String countsql = "select count(*) rows from tm_paper tp where tp.id in("
						+ sonsql + ")";
				String querysql = "select tp.*,te.sdate,te.edate,te.score,te.status estatus from tm_paper tp left join tm_exam_info te on tp.id=te.pid and te.uid="
						+ uid
						+ " where tp.id in("
						+ sonsql
						+ ") order by te.id desc";

				PageUtil pu = new PageUtil(request, countsql, querysql, 20);
				request.setAttribute("list", pu.getList());
			}
		} else
			log.warn("TomUserType=" + TomUserType + "的用户试图访问试卷列表");

		return mapping.findForward("to_history");
	}

	public ActionForward history_detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String uid = (String) request.getSession().getAttribute("TomUserId");

		VOPaper PAPER = PaperCache.getPaperById(id);
		request.setAttribute("PAPER", PAPER);

		UserPaperDao dao = new UserPaperDao();
		try {
			request.setAttribute("EXAM_INFO", dao.getExamInfo(
					Util.StringToInt(uid), Util.StringToInt(id)));

			Map map = new HashMap();
			List<Map> list = dao.getExamDetail(Util.StringToInt(uid),
					Util.StringToInt(id));
			if ((list != null) && (list.size() > 0)) {
				for (Map m : list) {
					String qid = String.valueOf(m.get("QID"));
					Map mp = new HashMap();
					mp.put("USER_ANSWER", m.get("USER_ANSWER"));
					mp.put("STATUS", m.get("STATUS"));
					mp.put("SCORE", m.get("SCORE"));
					mp.put("ID", m.get("ID"));
					map.put(qid, mp);
				}
			}

			if ((map == null) || (map.size() < 1)) {
				log.error("没有查询到uid=" + uid + "的答题明细");
				request.setAttribute("surl", "paper.do?action=history");
				request.setAttribute("smsg", "NO_DATA");
				return mapping.findForward("msg");
			}

			request.setAttribute("EXAM_DETAIL", map);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to_history");
	}

	/**
	 * 立即显示成绩
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward showScore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String uid = (String) request.getSession().getAttribute("TomUserId");

		VOPaper PAPER = PaperCache.getPaperById(id);
		request.setAttribute("PAPER", PAPER);

		UserPaperDao dao = new UserPaperDao();
		try {
			request.setAttribute("EXAM_INFO", dao.getExamInfo(
					Util.StringToInt(uid), Util.StringToInt(id)));

			Map map = new HashMap();
			List<Map> list = dao.getExamDetail(Util.StringToInt(uid),
					Util.StringToInt(id));
			if ((list != null) && (list.size() > 0)) {
				for (Map m : list) {
					String qid = String.valueOf(m.get("QID"));
					Map mp = new HashMap();
					mp.put("USER_ANSWER", m.get("USER_ANSWER"));
					mp.put("STATUS", m.get("STATUS"));
					mp.put("SCORE", m.get("SCORE"));
					mp.put("ID", m.get("ID"));
					map.put(qid, mp);
				}
			}

			if ((map == null) || (map.size() < 1)) {
				log.error("没有查询到uid=" + uid + "的答题明细");
				request.setAttribute("surl", "paper.do?action=history");
				request.setAttribute("smsg", "NO_DATA");
				return mapping.findForward("msg");
			}

			request.setAttribute("EXAM_DETAIL", map);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("user_showScore");
	}

	public ActionForward postPaper(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String pid = request.getParameter("pid");
		request.setAttribute("surl", "paper.do?action=list");
		String uid = (String) request.getSession().getAttribute("TomUserId");
		int int_uid = Util.StringToInt(uid);
		int int_pid = Util.StringToInt(pid);

		VOPaper paper = PaperCache.getPaperById(pid);
		if (paper == null) {
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}

		List<Object[]> list = new ArrayList();
		int TOTAL_SCORE = 0;

		List<VOSection> LIST_SECTIONS = paper.getPaperSections();
		if ((LIST_SECTIONS != null) && (LIST_SECTIONS.size() > 0)) {
			for (VOSection section : LIST_SECTIONS) {
				List<VOQuestion> LIST_QUESTIONS = section.getSectionQuestions();
				if ((LIST_QUESTIONS != null) && (LIST_QUESTIONS.size() > 0)) {
					for (VOQuestion question : LIST_QUESTIONS) {
						String[] ArrUserKey = request
								.getParameterValues("question_"
										+ question.getQuestionId());
						String UserKey = "";
						boolean UserKeyIsTure = false;
						String Qtype = question.getQuestionType();
						String DetailStatus = "1";
						String Qscore = question.getQuestionScore();
						int iQscore = 0;

						if ((ArrUserKey != null) && (ArrUserKey.length > 0)) {
							List ls;
							JSONArray jsonArray;
							if ("4".equals(Qtype)) {
								int ix = 1;
								ls = new ArrayList();
								for (String s : ArrUserKey) {
									Map _map = new HashMap();
									_map.put("ID", ix);
									_map.put("VAL", s);
									ls.add(_map);
									ix++;
								}
								jsonArray = JSONArray.fromObject(ls);
								UserKey = jsonArray.toString();
							} else {
								String[] arrayOfString1;
								for (int i = 0; i < ArrUserKey.length; i++) {
									String s = ArrUserKey[i];
									UserKey = UserKey + s;
								}

							}

						}

						if (("1".equals(Qtype)) || ("2".equals(Qtype))
								|| ("3".equals(Qtype))) {
							if (question.getQuestionKey() != null) {
								UserKeyIsTure = question.getQuestionKey()
										.equals(UserKey);
							}
							DetailStatus = "1";
						} else if ("4".equals(Qtype)) {
							double discore = 0.0D;

							discore = Util.StringToInt(Qscore)
									* Util.CompareJSON(
											question.getQuestionKey(), UserKey);
							iQscore = (int) discore;
							DetailStatus = "1";
						} else {
							DetailStatus = "0";
						}

						if (UserKeyIsTure) {
							iQscore = Util.StringToInt(Qscore);
						}

						TOTAL_SCORE += iQscore;

						list.add(new Object[] { Integer.valueOf(int_uid),
								Integer.valueOf(int_pid),
								Integer.valueOf(question.getQuestionId()),
								UserKey, DetailStatus,
								Integer.valueOf(iQscore), "", Qtype });
					}
				}
			}

		}

		if ((list != null) && (list.size() > 0)) {
			UserPaperDao dao = new UserPaperDao();
			try {
				dao.updateExamInfo(new Date(), TOTAL_SCORE, "2",
						Util.StringToInt(uid), Util.StringToInt(pid));
				dao.addExamDetail(list);

				new OnlineDao().offLine(int_uid);

				DBUtil.commit();
				request.setAttribute("smsg", "CHECKPAPER_OK");
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
				request.setAttribute("smsg", "CHECKPAPER_ERR");
				return mapping.findForward("msg");
			}
		} else {
			log.error("提交的试卷为空,uid=" + uid + ",pid=" + pid);
			request.setAttribute("smsg", "CHECKPAPER_OK");
		}
		try {
			response.sendRedirect("paper.do?action=showScore&id=" + pid + "");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return mapping.findForward("msg");
	}
}