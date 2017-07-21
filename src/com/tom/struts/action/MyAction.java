package com.tom.struts.action;

import com.tom.dao.UserDao;
import com.tom.struts.form.UserForm;
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

public class MyAction extends DispatchAction {
	private static Logger log = Logger.getLogger(MyAction.class);

	public ActionForward profile(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		Map map = null;
		String uid = (String) request.getSession().getAttribute("TomUserId");
		try {
			map = new UserDao().getUserById(Util.StringToInt(uid));
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		if (map != null)
			request.setAttribute("user", map);
		else {
			log.warn("uid=" + uid + "的用户不存在");
		}
		return mapping.findForward("to");
	}

	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		UserForm f = (UserForm) form;
		String id = (String) request.getSession().getAttribute("TomUserId");
		UserDao dao = new UserDao();
		request.setAttribute("surl", "my.do?action=profile");
		int i = 0;
		try {
			if ((f.getUserpass() == null) || ("".equals(f.getUserpass()))) {
				i = dao.updateUser(Util.StringToInt(id), f.getUserno(),
						f.getPhoto(), f.getStatus(), f.getRealname(),
						f.getEmail(), f.getMobi(), f.getRemark(), f.getSfzhm(),
						f.getGid().intValue());
			} else {
				String USERPASS = new MD5().getMD5ofStr(f.getUserpass());
				i = dao.updateUser(Util.StringToInt(id), f.getUserno(),
						USERPASS, f.getPhoto(), f.getStatus(), f.getRealname(),
						f.getEmail(), f.getMobi(), f.getRemark(), f.getGid()
								.intValue());
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
}