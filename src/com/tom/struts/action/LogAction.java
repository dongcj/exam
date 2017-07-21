package com.tom.struts.action;

import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.PageUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class LogAction extends DispatchAction {
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "LOG_VIEW"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		StringBuffer condition = new StringBuffer("");
		String s_logtype = request.getParameter("s_logtype");
		if ((s_logtype != null) && (s_logtype.length() > 0)) {
			condition.append(" and logtype='" + s_logtype + "'");
		}

		String s_logtime = request.getParameter("s_logtime");
		if ((s_logtime != null) && (s_logtime.length() > 0)) {
			condition.append(" and date_format(logtime,'%Y-%m-%d')='"
					+ s_logtime + "'");
		}

		String countsql = "select count(*) rows from tm_log where 1=1 "
				+ condition.toString();
		String querysql = "select * from tm_log where 1=1 "
				+ condition.toString() + " order by id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}
}