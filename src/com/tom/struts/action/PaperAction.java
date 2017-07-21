package com.tom.struts.action;

import com.tom.cache.CacheUtil;
import com.tom.cache.ConfigCache;
import com.tom.dao.DbDao;
import com.tom.dao.OnlineDao;
import com.tom.dao.PaperDao;
import com.tom.dao.QuestionDao;
import com.tom.dao.UserGroupDao;
import com.tom.dao.UtilDao;
import com.tom.struts.form.PaperForm;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.PageUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class PaperAction extends DispatchAction {
	private static String PAPER_LIST = "paper.do?action=list";
	private static Logger log = Logger.getLogger(PaperAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_ADD"))
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

		try {
			UserGroupDao dao = new UserGroupDao();
			request.setAttribute("GROUPS", dao.getALlGroups());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		PaperForm f = (PaperForm) form;
		PaperDao dao = new PaperDao();
		int i = 0;
		request.setAttribute("surl", PAPER_LIST);
		try {
			i = dao.addPaper(f.getPaper_name(), f.getAdminid().intValue(), f
					.getStatus(), f.getStarttime(), f.getEndtime(), f
					.getPaper_minute().intValue(), f.getTotal_score()
					.intValue(), f.getRemark(), f.getQorder(), f
					.getShow_score());
			DBUtil.commit();
			int last_id = new UtilDao().LAST_INSERT_ID();
			dao.setPaperGroups(last_id, request.getParameterValues("groupids"));
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "SAVE_PAPER_OK");
		else {
			request.setAttribute("smsg", "SAVE_PAPER_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "MAN_PAPER"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_paper where status !='9'";
		String querysql = "select tp.*,ta.username from tm_paper tp left join tm_admin ta on tp.adminid=ta.id where tp.status !='9' order by tp.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward examlist(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "EXAM_MO"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		String now_date = sdf.format(new Date());

		String countsql = "select count(*) rows from tm_paper tp where status !='9' and tp.starttime<='"
				+ now_date + "' and tp.endtime>='" + now_date + "'";

		String querysql = "select tp.*,ta.username from tm_paper tp left join tm_admin ta on tp.adminid=ta.id where tp.status !='9' and tp.starttime<='"
				+ now_date
				+ "' and tp.endtime>='"
				+ now_date
				+ "'"
				+ " order by tp.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		Map mam = new HashMap();
		try {
			mam = new OnlineDao().OnLineMap(SystemCode.getCommunicationRate());
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		request.setAttribute("online", mam);
		return mapping.findForward("to");
	}

	public ActionForward exam_online(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "EXAM_MO"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		OnlineDao dao = new OnlineDao();
		String id = request.getParameter("pid");
		if (id != null) {
			try {
				List list = dao.OnlineUsersOfPaper(Util.StringToInt(id),
						SystemCode.getCommunicationRate());
				request.setAttribute("online_list", list);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		PaperDao dao = new PaperDao();
		request.setAttribute("surl", PAPER_LIST);
		Map map = null;
		try {
			request.setAttribute("GROUPS", new UserGroupDao().getALlGroups());
			List<Map> glist = dao.getPaperGroupIds(Util.StringToInt(id));
			if ((glist != null) && (glist.size() > 0)) {
				String sgids = "";
				for (Map gm : glist) {
					sgids = sgids + gm.get("USERGROUPID") + "#";
				}
				request.setAttribute("USERGROUPIDS", sgids);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		try {
			map = dao.getPaperById(Util.StringToInt(id));
			request.setAttribute("paper", map);
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("smsg", "LOAD_PAPER_ERR");
			return mapping.findForward("msg");
		}
		if (map == null) {
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}

		return mapping.findForward("to");
	}

	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		PaperForm f = (PaperForm) form;
		PaperDao dao = new PaperDao();
		int i = 0;
		request.setAttribute("surl", PAPER_LIST);
		try {
			i = dao.updatePaper(Util.StringToInt(id), f.getPaper_name(), f
					.getStatus(), f.getStarttime(), f.getEndtime(), f
					.getPaper_minute().intValue(), f.getRemark(),
					f.getQorder(), f.getShow_score());
			DBUtil.commit();
			dao.setPaperGroups(Util.StringToInt(id),
					request.getParameterValues("groupids"));
			DBUtil.commit();

			CacheUtil.removeCache("PaperCache", id);
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "UPDATE_PAPER_OK");
		else {
			request.setAttribute("smsg", "UPDATE_PAPER_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		String phy = request.getParameter("phy");
		request.setAttribute("surl", PAPER_LIST);

		int pid = Util.StringToInt(id);
		PaperDao dao = new PaperDao();
		int i = 0;

		if ("yes".equals(phy)) {
			try {
				if (dao.HowManyPeopleExamedThePaper(pid) > 0) {
					request.setAttribute("smsg", "DELETE_PAPER_ERR2");
					return mapping.findForward("msg");
				}
				i = dao.deletePaper(pid);
				dao.deletePaperSectionByPid(pid);
				dao.deletePaperDetailByPaperId(pid);

				DBUtil.commit();
			} catch (Exception e) {
				i = -1;
				DBUtil.rollback();
				log.error(e.getMessage());
			}

			if (i >= 1)
				request.setAttribute("smsg", "DELETE_PAPER_OK");
			else {
				request.setAttribute("smsg", "DELETE_PAPER_ERR");
			}
			return mapping.findForward("msg");
		}

		try {
			i = dao.deletePaperLogic(pid);
			DBUtil.commit();
		} catch (Exception e) {
			i = -1;
			DBUtil.rollback();
			log.error(e.getMessage());
		}

		if (i >= 1)
			request.setAttribute("smsg", "DELETE_PAPER_OK");
		else {
			request.setAttribute("smsg", "DELETE_PAPER_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		PaperDao dao = new PaperDao();
		request.setAttribute("surl", PAPER_LIST);

		Map map = null;
		try {
			map = dao.getPaperById(Util.StringToInt(id));
			request.setAttribute("PAPER", map);

			DbDao ddao = new DbDao();
			try {
				request.setAttribute("DBLIST", ddao.getDbList("1"));
			} catch (Exception localException1) {
			}
			List<Map> SECTION_LIST = dao.getPaperSectionList(Util
					.StringToInt(id));
			request.setAttribute("SECTION_LIST", SECTION_LIST);

			if ((SECTION_LIST != null) && (SECTION_LIST.size() > 0))
				for (Map m : SECTION_LIST) {
					String sectionid = m.get("ID") + "";
					List QUESTION_LIST = dao.getQuestionListBySectionId(Util
							.StringToInt(sectionid));
					request.setAttribute("QUESTIONS_OF_" + sectionid,
							QUESTION_LIST);
				}
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("smsg", "LOAD_PAPER_ERR");
			return mapping.findForward("msg");
		}
		if (map == null) {
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}

		return mapping.findForward("detail");
	}

	public ActionForward updateDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_CONFIG"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String paperid = request.getParameter("paperid");
		request.setAttribute("surl", PAPER_LIST);

		String[] sid = request.getParameterValues("sid");
		String[] qid = request.getParameterValues("qid");
		String[] qscore = request.getParameterValues("qscore");

		CacheUtil.removeCache("PaperCache", paperid);

		PaperDao dao = new PaperDao();

		int how_man_people_examed = 0;
		try {
			how_man_people_examed = dao.HowManyPeopleExamedThePaper(Util
					.StringToInt(paperid));
		} catch (Exception e1) {
			log.error(e1.getMessage());
		}

		if (how_man_people_examed > 0) {
			request.setAttribute("smsg", "UPDATE_PAPER_ERR_005");
			return mapping.findForward("msg");
		}

		try {
			dao.deletePaperDetailByPaperId(Util.StringToInt(paperid));
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
			request.setAttribute("smsg", "UPDATE_PAPER_ERR_001");
			return mapping.findForward("msg");
		}

		int TOTAL_SCORE = 0;

		if ((sid != null) && (qid != null) && (qscore != null)
				&& (sid.length >= 0) && (qid.length >= 0)
				&& (qscore.length >= 0)) {
			if ((sid.length == qid.length) && (qid.length == qscore.length)) {
				List qlist = new ArrayList();
				for (int n = 0; n < sid.length; n++) {
					Map qmap = new HashMap();
					qmap.put("QID", qid[n]);
					qmap.put("SCORE", qscore[n]);
					qmap.put("ORDERID", n);
					qmap.put("SID", sid[n]);
					qlist.add(qmap);

					TOTAL_SCORE += Util.StringToInt(qscore[n]);
				}

				try {
					dao.addPaperDetail(Util.StringToInt(paperid), qlist);

					dao.updatePaperTotalScore(Util.StringToInt(paperid),
							TOTAL_SCORE);

					DBUtil.commit();
				} catch (Exception e) {
					DBUtil.rollback();
					log.error(e.getMessage());
					request.setAttribute("smsg", "UPDATE_PAPER_ERR_002");
					return mapping.findForward("msg");
				}

			} else {
				request.setAttribute("smsg", "UPDATE_PAPER_ERR_003");
				return mapping.findForward("msg");
			}
		}

		request.setAttribute("smsg", "UPDATE_PAPER_OK");
		return mapping.findForward("msg");
	}

	public ActionForward section(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		PaperDao dao = new PaperDao();
		String spid = request.getParameter("pid");
		String sid = request.getParameter("sid");
		String op = request.getParameter("op");
		int pid = Util.StringToInt(spid);
		request.setAttribute("surl", PAPER_LIST);

		if ("load".equals(op)) {
			try {
				request.setAttribute("section",
						dao.getPaperSectionById(Util.StringToInt(sid)));
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} else if ("delete".equals(op)) {
			try {
				dao.deletePaperSection(Util.StringToInt(sid));
				dao.deletePaperDetailBySectionId(Util.StringToInt(sid));
				dao.countPaperTotalScore(pid);
				DBUtil.commit();
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
			}
		} else if ("add".equals(op)) {
			String section_name = request.getParameter("section_name");
			String remark = request.getParameter("remark");
			String per_score = "0";
			try {
				dao.addPaperSection(pid, section_name, remark,
						Util.StringToInt(per_score));
				DBUtil.commit();
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
			}
		} else if ("update".equals(op)) {
			String section_name = request.getParameter("section_name");
			String remark = request.getParameter("remark");
			String per_score = "0";
			try {
				dao.updatePaperSection(Util.StringToInt(sid), section_name,
						remark, Util.StringToInt(per_score));
				DBUtil.commit();
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
			}
		}

		try {
			List list = dao.getPaperSectionList(pid);
			request.setAttribute("list", list);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to");
	}

	public ActionForward addrand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_ADD"))
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

		try {
			UserGroupDao dao = new UserGroupDao();
			request.setAttribute("GROUPS", dao.getALlGroups());

			DbDao ddao = new DbDao();
			request.setAttribute("DBLIST", ddao.getDbList("1"));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return mapping.findForward("rand");
	}

	public ActionForward saverand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PAPER_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		PaperForm f = (PaperForm) form;
		PaperDao dao = new PaperDao();
		int i = 0;
		request.setAttribute("surl", PAPER_LIST);
		try {
			i = dao.addPaper(f.getPaper_name(), f.getAdminid().intValue(), f
					.getStatus(), f.getStarttime(), f.getEndtime(), f
					.getPaper_minute().intValue(), f.getTotal_score()
					.intValue(), f.getRemark(), f.getQorder(), f
					.getShow_score());
			DBUtil.commit();
			int paperid = new UtilDao().LAST_INSERT_ID();
			dao.setPaperGroups(paperid, request.getParameterValues("groupids"));
			DBUtil.commit();

			String[] rand_cname = request.getParameterValues("rand_cname");
			String[] rand_dbid = request.getParameterValues("rand_dbid");
			String[] rand_qtype = request.getParameterValues("rand_qtype");
			String[] rand_nums = request.getParameterValues("rand_nums");
			String[] rand_perscore = request
					.getParameterValues("rand_perscore");
			String[] rand_qlevel = request.getParameterValues("rand_qlevel");

			if ((rand_cname != null) && (rand_cname.length > 0)) {
				for (int j = 0; j < rand_cname.length; j++) {
					try {
						int r_perscore = Util.StringToInt(rand_perscore[j]);

						dao.addPaperSection(paperid, rand_cname[j],
								rand_cname[j], r_perscore);
						DBUtil.commit();

						int section_id = new UtilDao().LAST_INSERT_ID();

						QuestionDao qdao = new QuestionDao();
						List<Map> list = qdao.queryQuestions_new(
								Integer.parseInt(rand_dbid[j]),
								Integer.parseInt(rand_qtype[j]),
								Integer.parseInt(rand_qlevel[j]),
								Integer.parseInt(rand_nums[j]));

						List ls = new ArrayList();
						for (Map m : list) {
							int r_qid = Util
									.StringToInt(m.get("ID").toString());
							ls.add(new Object[] { Integer.valueOf(paperid),
									Integer.valueOf(r_qid),
									Integer.valueOf(section_id),
									Integer.valueOf(r_perscore),
									Integer.valueOf(j) });
						}
						dao.addPaperDetail_new(ls);
						DBUtil.commit();
						i++;
					} catch (Exception e) {
						DBUtil.rollback();
						log.error(e.getMessage());
						request.setAttribute("smsg", "SAVE_PAPER_ERR");
						return mapping.findForward("msg");
					}
				}

			}

			dao.countPaperTotalScore(paperid);
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
			request.setAttribute("smsg", "SAVE_PAPER_ERR");
			return mapping.findForward("msg");
		}
		if (i >= 1)
			request.setAttribute("smsg", "SAVE_PAPER_OK");
		else {
			request.setAttribute("smsg", "SAVE_PAPER_ERR");
		}
		return mapping.findForward("msg");
	}
}