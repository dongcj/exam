package com.tom.struts.action;

import com.tom.cache.ConfigCache;
import com.tom.dao.UserDao;
import com.tom.dao.UserGroupDao;
import com.tom.struts.form.UserForm;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.EscapeUtil;
import com.tom.util.MD5;
import com.tom.util.PageUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class UserAction extends DispatchAction {
	private static String DLIST = "user.do?action=list";
	private static Logger log = Logger.getLogger(UserAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);
		try {
			request.setAttribute("GROUPS", new UserGroupDao().getALlGroups());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return mapping.findForward("to");
	}

	/**
	 * 保存增加用户
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		UserForm f = (UserForm) form;
		UserDao dao = new UserDao();
		int i = 0;
		request.setAttribute("surl", DLIST);

		String sys_sncode = ConfigCache.getConfigByKey("sys_sncode");
		// if (SystemCode.free_sncode.equals(sys_sncode)) {
		// int total_users = dao.getTotalUsers();
		// if (total_users > 1) {
		// request.setAttribute("smsg", "VERSION_LIMIT_USER");
		// return mapping.findForward("msg");
		// }
		//
		// }

		Map cmp = null;
		try {

			// cmp = dao.getUserByUserName(f.getUsername());
			// if (cmp != null) {
			// request.setAttribute("smsg", "USER_EXSIT");
			// return mapping.findForward("msg");
			// }

			cmp = dao.getUserByUserNo(f.getUserno());
			if (cmp != null) {
				request.setAttribute("smsg", "USERNO_EXSIT");
				return mapping.findForward("msg");
			}

			cmp = dao.getUserBySfzhm(f.getSfzhm());
			if (cmp != null) {
				request.setAttribute("smsg", "SFZHM_EXSIT");
				return mapping.findForward("msg");
			}

			try {
				i = dao.addUser(f.getUserno(), f.getUsername(),
						new MD5().getMD5ofStr(f.getUserpass()), f.getPhoto(),
						f.getStatus(), f.getRealname(), f.getEmail(),
						f.getMobi(), f.getRemark(), f.getGid().intValue(),
						f.getSfzhm());
				DBUtil.commit();
			} catch (Exception e2) {
				DBUtil.rollback();
				log.error(e2.getMessage());
			}
			if (i == 1)
				request.setAttribute("smsg", "SAVE_OK");
			else
				request.setAttribute("smsg", "SAVE_ERR");
		} catch (Exception e) {
			log.error(e.getMessage());

		}
		return mapping.findForward("msg");
	}

	/**
	 * 查询所有用户列表
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "MAN_USER"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_user t where 1=1 ";
		String querysql = "select t.*,tg.groupname from tm_user t left join tm_user_groups tg on t.gid=tg.id where 1=1 ";
		try {
			request.setAttribute("GROUPS", new UserGroupDao().getALlGroups());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		StringBuffer conditions = new StringBuffer();
		String s_username = request.getParameter("s_username");
		String s_realname = request.getParameter("s_realname");
		String s_gid = request.getParameter("s_gid");
		String s_userno = request.getParameter("s_userno");
		String s_status = request.getParameter("s_status");
		String s_sfzhm = request.getParameter("s_sfzhm");
		try {
			request.setAttribute("s_username", EscapeUtil.escape(s_username));

			request.setAttribute("s_realname", EscapeUtil.escape(s_realname));
		} catch (Exception localException1) {
		}
		if ((s_gid != null) && (!"".equals(s_gid))) {
			conditions.append(" and t.gid=" + s_gid);
			request.setAttribute("s_gid", s_gid);
		}
		if ((s_userno != null) && (!"".equals(s_userno))) {
			conditions.append(" and t.userno='" + s_userno + "'");
			request.setAttribute("s_userno", s_userno);
		}
		if ((s_realname != null) && (!"".equals(s_realname))) {
			conditions.append(" and t.realname like '%" + s_realname + "%'");
		}
		if ((s_username != null) && (!"".equals(s_username))) {
			conditions.append(" and t.username like '%" + s_username + "%'");
		}
		if ((s_status != null) && (!"".equals(s_status))) {
			conditions.append(" and t.status=" + s_status);
			request.setAttribute("s_status", s_status);
		}
		if ((s_sfzhm != null) && (!"".equals(s_sfzhm))) {
			conditions.append(" and t.sfzhm like '%" + s_sfzhm + "%'");
			request.setAttribute("s_sfzhm", s_sfzhm);
		}

		countsql = countsql + conditions.toString();
		querysql = querysql + conditions.toString();

		querysql = querysql + " order by t.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	/**
	 * 获取用户信息 用于 修改前页面等
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		UserDao dao = new UserDao();

		Map map = null;
		try {
			map = dao.getUserById(Util.StringToInt(id));
			request.setAttribute("user", map);
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("smsg", "LOAD_ERR");
			return mapping.findForward("msg");
		}
		if (map == null) {
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}
		try {
			request.setAttribute("GROUPS", new UserGroupDao().getALlGroups());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to");
	}

	/**
	 * 修改用户
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		UserForm f = (UserForm) form;
		String id = request.getParameter("id");
		UserDao dao = new UserDao();
		request.setAttribute("surl", DLIST);
		int i = 0;
		String USERPASS = new MD5().getMD5ofStr(f.getUserpass());
		try {
			// 不修密码
			if ((f.getUserpass() == null) || ("".equals(f.getUserpass())))
				i = dao.updateUser(Util.StringToInt(id), f.getUserno(),
						f.getPhoto(), f.getStatus(), f.getRealname(),
						f.getEmail(), f.getMobi(), f.getRemark(), f.getSfzhm(),
						f.getGid().intValue());
			// 修改密码
			else {
				i = dao.updateUser(Util.StringToInt(id), f.getUserno(),
						USERPASS, f.getPhoto(), f.getStatus(), f.getRealname(),
						f.getEmail(), f.getMobi(), f.getRemark(), f.getSfzhm(),
						f.getGid().intValue());
			}
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
		if (!this.PCK.HasPrivelege(request, "USER_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		UserDao dao = new UserDao();
		request.setAttribute("surl", DLIST);
		int i = 0;
		try {
			i = dao.deleteUserById(Util.StringToInt(id));
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

	public ActionForward examlist(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String uid = request.getParameter("uid");
		String countsql = "select count(*) rows from tm_exam_info where uid="
				+ uid;
		String querysql = "select tei.*,tu.realname,tu.username,tu.userno from tm_exam_info tei left join tm_user tu on tei.uid=tu.id where tei.uid="
				+ uid + " order by tei.id desc";
		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward batch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "USER_BATCHOP"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		request.setAttribute("surl", DLIST);
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