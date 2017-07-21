package com.tom.struts.action;

import com.tom.cache.ConfigCache;
import com.tom.dao.AdminDao;
import com.tom.dao.AdminRoleDao;
import com.tom.struts.form.AdminForm;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.MD5;
import com.tom.util.PageUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class AdminAction extends DispatchAction {
	private static String ADMIN_LIST = "admin.do?action=list";
	private static Logger log = Logger.getLogger(AdminAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ADMIN_ADD"))
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

		AdminRoleDao dao = new AdminRoleDao();
		try {
			request.setAttribute("ADMIN_ROLES", dao.getAdminRoleList());
		} catch (Exception localException) {
		}
		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ADMIN_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		AdminForm f = (AdminForm) form;
		String userpass = new MD5().getMD5ofStr(f.getUserpass());
		AdminDao dao = new AdminDao();
		request.setAttribute("surl", ADMIN_LIST);
		try {
			Map map = dao.getAdminByUsername(f.getUsername());
			if (map != null) {
				request.setAttribute("smsg", "USER_EXSIT");
				return mapping.findForward("msg");
			}
		} catch (Exception ee) {
			log.error(ee.getMessage());
			request.setAttribute("smsg", "SAVE_ADMIN_ERR");
			return mapping.findForward("msg");
		}

		int i = 0;
		try {
			i = dao.addAdmin(f.getUsername(), userpass, f.getStatus(), f
					.getRoleid().intValue(), f.getRealname(), f.getMobi(), f
					.getRemark());
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
			i = -1;
		}
		if (i == 1)
			request.setAttribute("smsg", "SAVE_ADMIN_OK");
		else {
			request.setAttribute("smsg", "SAVE_ADMIN_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String countsql = "select count(*) rows from tm_admin";
		String querysql = "select t.*,tr.rolename from tm_admin t left join tm_admin_roles tr on t.roleid=tr.id order by t.id desc";
		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ADMIN_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		AdminDao dao = new AdminDao();
		AdminRoleDao rdao = new AdminRoleDao();
		Map map = null;
		try {
			map = dao.getAdminById(Util.StringToInt(id));
			request.setAttribute("ADMIN_ROLES", rdao.getAdminRoleList());
			request.setAttribute("admin", map);
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("surl", ADMIN_LIST);
			request.setAttribute("smsg", "LOAD_ADMIN_ERR");
			return mapping.findForward("msg");
		}
		if (map == null) {
			request.setAttribute("surl", ADMIN_LIST);
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}

		return mapping.findForward("to");
	}

	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ADMIN_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		String op = request.getParameter("op");
		AdminForm f = (AdminForm) form;
		String userpass = new MD5().getMD5ofStr(f.getUserpass());
		AdminDao dao = new AdminDao();
		int i = 0;
		try {
			if ((f.getUserpass() == null) || ("".equals(f.getUserpass())))
				i = dao.updateAdmin(Util.StringToInt(id), f.getStatus(), f
						.getRoleid().intValue(), f.getRealname(), f.getMobi(),
						f.getRemark());
			else {
				i = dao.updateAdmin(Util.StringToInt(id), userpass,
						f.getStatus(), f.getRoleid().intValue(),
						f.getRealname(), f.getMobi(), f.getRemark());
			}
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "UPDATE_ADMIN_OK");
		else {
			request.setAttribute("smsg", "UPDATE_ADMIN_ERR");
		}
		if ("profile".equals(op))
			request.setAttribute("surl", "admin.do?action=profile");
		else {
			request.setAttribute("surl", ADMIN_LIST);
		}
		return mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "ADMIN_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		AdminDao dao = new AdminDao();
		int i = 0;
		try {
			i = dao.deleteAdminById(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_ADMIN_OK");
		else {
			request.setAttribute("smsg", "DELETE_ADMIN_ERR");
		}
		request.setAttribute("surl", ADMIN_LIST);
		return mapping.findForward("msg");
	}

	public ActionForward profile(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "SYS_USERINFO"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		Map map = null;
		String uid = (String) request.getSession().getAttribute("TomUserId");
		try {
			map = new AdminDao().getAdminById(Util.StringToInt(uid));
		} catch (Exception localException1) {
		}
		if (map != null) {
			String roleid = (String) map.get("ROLEID");
			int rid = 0;
			try {
				rid = Util.StringToInt(roleid);
			} catch (Exception e) {
				rid = 0;
			}
			AdminRoleDao dao = new AdminRoleDao();
			try {
				Map m = dao.getAdminRoleById(rid);
				if (m != null)
					request.setAttribute("ROLENAME", m.get("ROLENAME"));
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}

		request.setAttribute("profile", map);
		return mapping.findForward("to");
	}
}