package com.tom.struts.action;

import com.tom.cache.CacheUtil;
import com.tom.dao.ConfigDao;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class ConfigAction extends DispatchAction {
	private static Logger log = Logger.getLogger(ConfigAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();
	private static String CONFIG_LIST = "config.do?action=list";

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "SYS_CONFIG"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);
		return mapping.findForward("to");
	}

	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "SYS_CONFIG"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		request.setAttribute("surl", CONFIG_LIST);
		String key = request.getParameter("key");
		if (key != null) {
			String val = request.getParameter(key);
			ConfigDao dao = new ConfigDao();
			try {
				dao.updateConfigByKey(key, val);
				CacheUtil.removeCache("ConfigCache", key);
				DBUtil.commit();
				request.setAttribute("smsg", "UPDATE_CONFIG_OK");
			} catch (Exception e) {
				DBUtil.rollback();
				log.error(e.getMessage());
				request.setAttribute("smsg", "UPDATE_CONFIG_ERR");
			}

			if ("sys_sncode".equals(key)) {
				com.tom.util.SystemCode.isUserChangedSNCode = true;
			}

		}

		return mapping.findForward("msg");
	}
}