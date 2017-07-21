package com.tom.struts.action;

import com.tom.util.PageUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class QcAction extends DispatchAction {
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String uid = (String) request.getSession().getAttribute("TomUserId");
		String countsql = "select count(*) rows from tm_question_collection where uid = "
				+ uid;
		String querysql = "select tqc.id,tqc.cdate,td.user_answer,tqc.qid from tm_question_collection tqc  left join tm_exam_detail td on tqc.detailid=td.id where tqc.uid = "
				+ uid + " order by tqc.id desc";
		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}
}