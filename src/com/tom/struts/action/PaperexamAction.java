package com.tom.struts.action;

import com.tom.cache.PaperCache;
import com.tom.dao.PaperExamDao;
import com.tom.dao.UserPaperDao;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.PageUtil;
import com.tom.util.Util;
import com.tom.vo.VOPaper;
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

public class PaperexamAction extends DispatchAction {
	private static Logger log = Logger.getLogger(PaperexamAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		VOPaper PAPER = PaperCache.getPaperById(id);
		request.setAttribute("PAPER", PAPER);

		String countsql = "select count(*) rows from tm_exam_info where pid="
				+ id;
		String querysql = "select tei.*,tu.realname,tu.username,tu.userno from tm_exam_info tei left join tm_user tu on tei.uid=tu.id where tei.pid="
				+ id + " order by tei.id desc";
		PageUtil pu = new PageUtil(request, countsql, querysql, 20);
		request.setAttribute("list", pu.getList());

		return mapping.findForward("to");
	}

	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "EXMA_DETAIL"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String pid = request.getParameter("pid");
		String uid = request.getParameter("uid");

		VOPaper PAPER = PaperCache.getPaperById(pid);
		request.setAttribute("PAPER", PAPER);

		UserPaperDao dao = new UserPaperDao();
		try {
			request.setAttribute(
					"EXAM_INFO",
					dao.getExamInfo(Util.StringToInt(uid),
							Util.StringToInt(pid)));

			Map map = new HashMap();
			List<Map> list = dao.getExamDetail(Util.StringToInt(uid),
					Util.StringToInt(pid));
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
				request.setAttribute("surl", "paperexam.do?action=list&id="
						+ pid);
				request.setAttribute("smsg", "NO_DATA");
				return mapping.findForward("msg");
			}

			request.setAttribute("EXAM_DETAIL", map);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to");
	}

	public ActionForward delete_detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "EXAM_DETAIL_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String pid = request.getParameter("pid");
		String uid = request.getParameter("uid");
		request.setAttribute("surl", "paperexam.do?action=list&id=" + pid);

		PaperExamDao dao = new PaperExamDao();
		try {
			dao.deleteOnesExamRecord(Util.StringToInt(pid),
					Util.StringToInt(uid));
			dao.deleteOnesExamRecordDetail(Util.StringToInt(pid),
					Util.StringToInt(uid));
			DBUtil.commit();
			request.setAttribute("smsg", "DELETE_OK");
			return mapping.findForward("msg");
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
			request.setAttribute("smsg", "DELETE_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward delete_detail_all(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "EXAM_DETAIL_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String pid = request.getParameter("pid");
		request.setAttribute("surl", "paperexam.do?action=list&id=" + pid);

		PaperExamDao dao = new PaperExamDao();
		try {
			dao.deleteOnesExamRecord(Util.StringToInt(pid));
			dao.deleteOnesExamRecordDetail(Util.StringToInt(pid));
			DBUtil.commit();
			request.setAttribute("smsg", "DELETE_OK");
			return mapping.findForward("msg");
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
			request.setAttribute("smsg", "DELETE_ERR");
		}
		return mapping.findForward("msg");
	}
}