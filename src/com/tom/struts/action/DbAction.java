package com.tom.struts.action;

import com.tom.dao.DbDao;
import com.tom.struts.form.DbForm;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.PageUtil;
import com.tom.util.Util;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class DbAction extends DispatchAction {
	private static String DB_LIST = "db.do?action=list";
	private static Logger log = Logger.getLogger(DbAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "DB_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "DB_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		DbForm f = (DbForm) form;
		DbDao dao = new DbDao();
		request.setAttribute("surl", DB_LIST);
		int i = 0;
		try {
			i = dao.addDb(f.getDname(), f.getRemark(), f.getAdminid()
					.intValue(), f.getStatus());
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "SAVE_DB_OK");
		else {
			request.setAttribute("smsg", "SAVE_DB_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "MAN_DB"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_question_db";
		String querysql = "select tdb.*,question_nums,ta.username from tm_question_db tdb left join (select dbid,count(1) question_nums from tm_question group by dbid) tq on tq.dbid = tdb.id left join tm_admin ta on tdb.adminid = ta.id order by tdb.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "DB_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		DbDao dao = new DbDao();
		request.setAttribute("surl", DB_LIST);

		Map map = null;
		try {
			map = dao.getDbById(Util.StringToInt(id));
			request.setAttribute("db", map);
		} catch (Exception e) {
			request.setAttribute("smsg", "LOAD_DB_ERR");
			log.error(e.getMessage());
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
		if (!this.PCK.HasPrivelege(request, "DB_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		DbForm f = (DbForm) form;
		DbDao dao = new DbDao();
		request.setAttribute("surl", DB_LIST);
		int i = 0;
		try {
			i = dao.updateDb(Util.StringToInt(id), f.getDname(), f.getRemark(),
					f.getStatus());
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "UPDATE_DB_OK");
		else {
			request.setAttribute("smsg", "UPDATE_DB_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "DB_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		DbDao dao = new DbDao();
		request.setAttribute("surl", DB_LIST);
		int i = 0;
		try {
			i = dao.deleteDbById(Util.StringToInt(id));

			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_DB_OK");
		else {
			request.setAttribute("smsg", "DELETE_DB_ERR");
		}
		return mapping.findForward("msg");
	}
}