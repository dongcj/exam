package com.tom.struts.action;

import com.tom.dao.DbDao;
import com.tom.dao.QuestionDao;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class SelfpaperAction extends DispatchAction {
	private static Logger log = Logger.getLogger(SelfpaperAction.class);

	public ActionForward setting(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DbDao dao = new DbDao();
		try {
			request.setAttribute("DBLIST", dao.getDbList("1"));
		} catch (Exception localException) {
		}
		return mapping.findForward("to");
	}

	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String dbid = request.getParameter("dbid");
		String numa = request.getParameter("numa");
		String numb = request.getParameter("numb");
		String numc = request.getParameter("numc");

		String qlevel_a = request.getParameter("qlevel_a");
		String qlevel_b = request.getParameter("qlevel_b");
		String qlevel_c = request.getParameter("qlevel_c");

		List list_options = new ArrayList();

		QuestionDao dao = new QuestionDao();
		try {
			List lista = dao.queryQuestions(Integer.parseInt(dbid), 1,
					Integer.parseInt(qlevel_a), Integer.parseInt(numa));
			List listb = dao.queryQuestions(Integer.parseInt(dbid), 2,
					Integer.parseInt(qlevel_b), Integer.parseInt(numb));
			list_options = dao.queryQuestionOptions(lista, listb);

			List listc = dao.queryQuestions(Integer.parseInt(dbid), 3,
					Integer.parseInt(qlevel_c), Integer.parseInt(numc));

			request.setAttribute("LISTA", lista);
			request.setAttribute("LISTB", listb);
			request.setAttribute("LISTC", listc);

			request.setAttribute("LISTOPTIONS", list_options);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return mapping.findForward("to");
	}
}