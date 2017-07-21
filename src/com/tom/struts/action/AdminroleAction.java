package com.tom.struts.action;

import com.tom.dao.AdminRoleDao;
import com.tom.struts.form.AdminroleForm;
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

public class AdminroleAction extends DispatchAction {
	private static String ADMINROLE_LIST = "adminrole.do?action=list";
	private static Logger log = Logger.getLogger(AdminroleAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ROLE_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		AdminRoleDao dao = new AdminRoleDao();
		try {
			request.setAttribute("menu", dao.getPrivelegesList(0));
			request.setAttribute("list", dao.getPrivelegesList());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ROLE_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		AdminroleForm f = (AdminroleForm) form;
		AdminRoleDao dao = new AdminRoleDao();

		StringBuffer privs = new StringBuffer();
		String[] priveleges = request.getParameterValues("roleprivelege");
		if ((priveleges != null) && (priveleges.length > 0)) {
			for (String s : priveleges) {
				privs.append("#" + s);
			}
		}

		int i = 0;
		try {
			i = dao.addAdminRole(f.getRolename(), privs.toString(),
					f.getRemark());
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "SAVE_ROLE_OK");
		else {
			request.setAttribute("smsg", "SAVE_ROLE_ERR");
		}
		request.setAttribute("surl", ADMINROLE_LIST);
		return mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String countsql = "select count(*) rows from tm_admin_roles";
		String querysql = "select * from tm_admin_roles order by id desc";
		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ROLE_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		AdminRoleDao dao = new AdminRoleDao();
		request.setAttribute("surl", ADMINROLE_LIST);
		try {
			request.setAttribute("menu", dao.getPrivelegesList(0));
			request.setAttribute("list", dao.getPrivelegesList());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		Map map = null;
		try {
			map = dao.getAdminRoleById(Util.StringToInt(id));
			request.setAttribute("adminrole", map);
		} catch (Exception e) {
			request.setAttribute("smsg", "LOAD_ROLE_ERR");
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
		if (!this.PCK.HasPrivelege(request, "ROLE_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		AdminroleForm f = (AdminroleForm) form;
		AdminRoleDao dao = new AdminRoleDao();

		StringBuffer privs = new StringBuffer();
		String[] priveleges = request.getParameterValues("roleprivelege");
		if ((priveleges != null) && (priveleges.length > 0)) {
			for (String s : priveleges) {
				privs.append("#" + s);
			}
		}

		int i = 0;
		try {
			i = dao.updateAdminRole(Util.StringToInt(id), f.getRolename(),
					privs.toString(), f.getRemark());
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "UPDATE_ROLE_OK");
		else {
			request.setAttribute("smsg", "UPDATE_ROLE_ERR");
		}
		request.setAttribute("surl", ADMINROLE_LIST);
		return mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ROLE_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		AdminRoleDao dao = new AdminRoleDao();
		request.setAttribute("surl", ADMINROLE_LIST);

		int i = 0;
		try {
			i = dao.deleteAdminRoleById(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_ROLE_OK");
		else {
			request.setAttribute("smsg", "DELETE_ROLE_ERR");
		}
		request.setAttribute("surl", ADMINROLE_LIST);
		return mapping.findForward("msg");
	}
}