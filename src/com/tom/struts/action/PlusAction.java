package com.tom.struts.action;

import com.tom.dao.PlusDao;
import com.tom.struts.form.PlusForm;
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

public class PlusAction extends DispatchAction {
	private static String PLUS_LIST = "plus.do?action=list";
	private static Logger log = Logger.getLogger(PlusAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PLUS_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PLUS_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		PlusForm f = (PlusForm) form;
		PlusDao dao = new PlusDao();

		request.setAttribute("surl", PLUS_LIST);
		int i = 0;
		try {
			i = dao.addPlus(f.getPname(), f.getPdesc(), f.getPhoto(),
					f.getVurl(), f.getStatus(), f.getPurl());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		if (i == 1)
			request.setAttribute("smsg", "SAVE_OK");
		else {
			request.setAttribute("smsg", "SAVE_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "MAN_PLUS"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_plus";
		String querysql = "select * from tm_plus order by id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PLUS_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		PlusDao dao = new PlusDao();
		request.setAttribute("surl", PLUS_LIST);

		Map map = null;
		try {
			map = dao.getPlusById(Util.StringToInt(id));
			request.setAttribute("plus", map);
		} catch (Exception e) {
			request.setAttribute("smsg", "LOAD_ERR");
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
		if (!this.PCK.HasPrivelege(request, "PLUS_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		PlusForm f = (PlusForm) form;
		PlusDao dao = new PlusDao();
		request.setAttribute("surl", PLUS_LIST);

		int i = 0;
		try {
			i = dao.updatePlus(Util.StringToInt(id), f.getPname(),
					f.getPdesc(), f.getPhoto(), f.getVurl(), f.getStatus(),
					f.getPurl());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		if (i == 1)
			request.setAttribute("smsg", "UPDATE_OK");
		else {
			request.setAttribute("smsg", "UPDATE_ERR");
		}

		return mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "PLUS_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		PlusDao dao = new PlusDao();
		request.setAttribute("surl", PLUS_LIST);
		int i = 0;
		try {
			i = dao.deletePlusById(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_OK");
		else {
			request.setAttribute("smsg", "DELETE_ERR");
		}
		return mapping.findForward("msg");
	}
}