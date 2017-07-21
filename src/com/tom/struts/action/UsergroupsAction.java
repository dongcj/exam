package com.tom.struts.action;

import com.tom.dao.UserGroupDao;
import com.tom.struts.form.UsergroupsForm;
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

public class UsergroupsAction extends DispatchAction {
	private static String DLIST = "usergroups.do?action=list";
	private static Logger log = Logger.getLogger(UsergroupsAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_GROUP_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_GROUP_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		UsergroupsForm f = (UsergroupsForm) form;
		UserGroupDao dao = new UserGroupDao();
		request.setAttribute("surl", DLIST);
		int i = 0;
		try {
			i = dao.addUserGroup(f.getGroupname(), f.getRemark());
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
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
		String countsql = "select count(*) rows from tm_user_groups";
		String querysql = "select * from tm_user_groups order by id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_GROUP_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		UserGroupDao dao = new UserGroupDao();
		request.setAttribute("surl", DLIST);

		Map map = null;
		try {
			map = dao.getUserGroupById(Util.StringToInt(id));
			request.setAttribute("usergroup", map);
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("smsg", "LOAD_ERR");
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
		if (!this.PCK.HasPrivelege(request, "USER_GROUP_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		UserGroupDao dao = new UserGroupDao();
		request.setAttribute("surl", DLIST);
		UsergroupsForm f = (UsergroupsForm) form;
		int i = 0;
		try {
			i = dao.updateUserGroup(Util.StringToInt(id), f.getGroupname(),
					f.getRemark());
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
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
		if (!this.PCK.HasPrivelege(request, "USER_GROUP_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		UserGroupDao dao = new UserGroupDao();
		request.setAttribute("surl", DLIST);
		int i = 0;
		try {
			i = dao.deleteUserGroupById(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_OK");
		else {
			request.setAttribute("smsg", "DELETE_ERR");
		}
		return mapping.findForward("msg");
	}
}