package com.tom.struts.services;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PrivelegeChecker {
	public ActionForward RedirectToNoPrivelegePage(HttpServletRequest request,
			ActionMapping mapping) {
		request.setAttribute("smsg", "NO_PRIVELEGE");
		request.setAttribute("surl", "#");
		return mapping.findForward("msg");
	}

	public boolean HasPrivelege(HttpServletRequest request, String PrivelegeCode) {
		if ((request == null) || (request.getSession() == null))
			return false;
		String TomUserPrivelege = (String) request.getSession().getAttribute(
				"TomUserPrivelege");
		if (TomUserPrivelege != null) {
			return TomUserPrivelege.contains(PrivelegeCode);
		}
		return false;
	}
}