package com.tom.struts.action;

import com.tom.cache.PaperCache;
import com.tom.dao.AnalysisDao;
import com.tom.struts.services.PrivelegeChecker;
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

public class AnalysisAction extends DispatchAction {
	private static Logger log = Logger.getLogger(AnalysisAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward chengji(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ANA_CJ"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_paper where status !='9'";
		String querysql = "select tp.*, (select count(1) from tm_exam_info ti where ti.pid=tp.id) total_people, (select count(1) from tm_exam_info ti where ti.pid=tp.id and ti.score>=0.6*tp.total_score) pass_num, (select count(1) from tm_exam_info ti where ti.pid=tp.id and ti.score<0.6*tp.total_score) not_pass_num, (select max(ti.score) from tm_exam_info ti where ti.pid=tp.id) max_score, (select min(ti.score) from tm_exam_info ti where ti.pid=tp.id) min_score, (select avg(ti.score) from tm_exam_info ti where ti.pid=tp.id) avg_score,(select 0.6*tp.total_score) pass_score  from tm_paper tp where tp.status !='9' order by tp.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward chengji_detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ANA_CJ"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		AnalysisDao dao = new AnalysisDao();
		String pid = request.getParameter("pid");
		try {
			request.setAttribute("data",
					dao.analysisPaperById(Util.StringToInt(pid)));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return mapping.findForward("to");
	}

	public ActionForward shijuan(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("to");
	}

	public ActionForward shijuan_chart(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ANA_SJ"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String[] tfrom = request.getParameterValues("tfrom");
		String[] tto = request.getParameterValues("tto");
		String pid = request.getParameter("pid");
		AnalysisDao dao = new AnalysisDao();
		try {
			request.setAttribute("data", dao.shijuan_chart(tfrom, tto, pid));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return mapping.findForward("to");
	}

	public ActionForward kaoshi(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ANA_KS"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_paper where status !='9'";
		String querysql = "select tp.*,(select count(1) from tm_exam_info ti where ti.pid=tp.id) total_people,ta.username from tm_paper tp left join tm_admin ta on tp.adminid=ta.id where tp.status !='9' order by tp.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward kaoshi_detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ANA_KS"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		AnalysisDao dao = new AnalysisDao();
		String pid = request.getParameter("pid");

		VOPaper PAPER = PaperCache.getPaperById(pid);
		request.setAttribute("PAPER", PAPER);
		try {
			Map map = new HashMap();
			List<Map> list = dao.kaoshi_detail(Util.StringToInt(pid));
			if ((list != null) && (list.size() > 0)) {
				for (Map m : list) {
					map.put(String.valueOf(m.get("QID")), m.get("TPERCENT"));
				}
			}

			request.setAttribute("data", map);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to");
	}

	public ActionForward show_papers(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String countsql = "select count(*) rows from tm_paper where status !='9'";
		String querysql = "select tp.*,ta.username from tm_paper tp left join tm_admin ta on tp.adminid=ta.id where tp.status !='9' order by tp.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 5);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}
}