package com.tom.struts.action;

import com.tom.cache.ConfigCache;
import com.tom.dao.AdminDao;
import com.tom.dao.AdminRoleDao;
import com.tom.dao.LogDao;
import com.tom.dao.UserDao;
import com.tom.util.DBUtil;
import com.tom.util.MD5;
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

public class ProcessAction extends DispatchAction {
	private static Logger log = Logger.getLogger(ProcessAction.class);

	public ActionForward login(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String username = request.getParameter("username");
		String userpass = request.getParameter("userpass");
		String usertype = request.getParameter("usertype");
		
//		System.out.println("usertype is: " + usertype);

		HttpSession session = request.getSession();
		String code_a = request.getParameter("tvery");
		String code_b = (String) session.getAttribute("rand");

		/* 暂时取消验证码功能开始 */
		if ((code_a == null) || (code_b == null)) {
			session.setAttribute("loginmsg", "验证码丢失，请重新输入。");
			return mapping.findForward("login");
		}

		if (!code_a.equals(code_b)) {
			session.setAttribute("loginmsg", "验证码错误。");
			return mapping.findForward("login");
		}
		/* 暂时取消验证码功能结束 */

		userpass = new MD5().getMD5ofStr(userpass);
		Map umap = null;
		String userstatus = "-1";

		// 管理员登陆
		if ("1".equals(usertype)) {
			AdminDao dao = new AdminDao();
			try {
				umap = dao.getAdminByUserNameAndUserPass(username, userpass);
				if (umap == null) {
					return null;
				}
				String aid = (String) umap.get("ID");
				dao.updateLastLogin(Util.StringToInt(aid));
				new LogDao().addLog("1", "1", username, aid,
						request.getRemoteAddr(), "管理员登陆 " + username);
				System.out.println("管理员" + username + "登陆");
				DBUtil.commit();
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
			}
			// 普通考生登陆
		} else if ("2".equals(usertype)) {
			String sys_userlogin = ConfigCache.getConfigByKey("sys_userlogin");
			if (!"on".equals(sys_userlogin)) {
				session.setAttribute("loginmsg", "无法登陆，登陆功能被管理员关闭。");
				return mapping.findForward("login");
			}

			UserDao dao = new UserDao();
			try {
				umap = dao.getUserByUserNameAndUserPass(username, userpass);
				if (umap != null) {
					String aid = (String) umap.get("ID");
					dao.updateLastLogin(Util.StringToInt(aid));
					new LogDao().addLog("1", "2", username, aid,
							request.getRemoteAddr(), "用户登陆 " + username);
					System.out.println("用户" + username + "登陆");
					DBUtil.commit();
				}
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
			}

		}

		if (umap == null) {
			session.setAttribute("loginmsg", "登陆名和密码不匹配。");
			return mapping.findForward("examiner");
		}

		userstatus = (String) umap.get("STATUS");
		if ("-1".equals(userstatus)) {
			session.setAttribute("loginmsg", "您的账号处于锁定状态，无法登陆，请与管理员联系。");
			return mapping.findForward("examiner");
		}

		session.setAttribute("TomUser", umap);
		session.setAttribute("TomUserType", usertype);
		session.setAttribute("TomUserId", (String) umap.get("ID"));

		if ("1".equals(usertype)) {
			String roleId = (String) umap.get("ROLEID");
			String roleprivelege = "";
			if (roleId != null) {
				AdminRoleDao adao = new AdminRoleDao();
				try {
					Map rolemap = adao.getAdminRoleById(Util
							.StringToInt(roleId));
					if (rolemap != null) {
						roleprivelege = (String) rolemap.get("ROLEPRIVELEGE");
						session.setAttribute("TomUserPrivelege", roleprivelege);
					}
				} catch (Exception e) {
					log.error(e.getMessage());
				}
			}
		}

		return mapping.findForward("index");
	}

	public ActionForward logout(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		session.removeAttribute("TomUser");
		session.removeAttribute("TomUserType");
		session.removeAttribute("TomUserId");
		session.removeAttribute("TomUserPrivelege");

		return mapping.findForward("examiner");
	}

	public ActionForward login3(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String sfzhm = request.getParameter("sfzhm");
		String userpass = request.getParameter("userpass");
		String usertype = request.getParameter("usertype");	// 从examiner.jsp中得到的

		HttpSession session = request.getSession();

		/*
		 * 暂时取消验证码功能开始 String code_a = request.getParameter("tvery"); String
		 * code_b = (String) session.getAttribute("rand");
		 * 
		 * if ((code_a == null) || (code_b == null)) {
		 * session.setAttribute("loginmsg", "验证码丢失，请重新输入。"); return
		 * mapping.findForward("login"); }
		 * 
		 * if (!code_a.equals(code_b)) { session.setAttribute("loginmsg",
		 * "验证码错误。"); return mapping.findForward("login"); }
		 */

		userpass = new MD5().getMD5ofStr(userpass);
		Map umap = null;
		String userstatus = "-1";

		// 普通考生从examiner.jsp登陆
		if ("3".equals(usertype)) {
			String sys_userlogin = ConfigCache.getConfigByKey("sys_userlogin");

			if (!"on".equals(sys_userlogin)) {
				session.setAttribute("loginmsg", "无法登陆，登陆功能被管理员关闭。");
				return mapping.findForward("examiner");
			}

			UserDao dao = new UserDao();
			try {
				umap = dao.getUserBySfzhmAndUserPass(sfzhm, userpass);
				if (umap != null) {
					String aid = (String) umap.get("ID");
					dao.updateLastLogin(Util.StringToInt(aid));
					new LogDao().addLog("1", "2", sfzhm, aid,
							request.getRemoteAddr(), "用户登陆 " + sfzhm);
					System.out.println("用户使用身份证号码" + sfzhm + "登陆");
					DBUtil.commit();
				}
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
			}

		}

		if (umap == null) {
			session.setAttribute("loginmsg", "身份证和密码不匹配。");
			return mapping.findForward("examiner");
		}

		userstatus = (String) umap.get("STATUS");
		if ("-1".equals(userstatus)) {
			session.setAttribute("loginmsg", "您的账号处于锁定状态，无法登陆，请与管理员联系。");
			return mapping.findForward("examiner");
		}

		session.setAttribute("TomUser", umap);
		session.setAttribute("TomUserType", usertype);
		session.setAttribute("TomUserId", (String) umap.get("ID"));

		return mapping.findForward("index");
	}
}