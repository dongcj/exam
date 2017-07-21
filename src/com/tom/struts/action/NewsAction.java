package com.tom.struts.action;

import com.tom.dao.NewsCategoryDao;
import com.tom.dao.NewsDao;
import com.tom.struts.form.NewsForm;
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

public class NewsAction extends DispatchAction {
	private static String NEWS_LIST = "news.do?action=list";
	private static String NEWS_TYPE_LIST = "news.do?action=list_newstype";
	private static Logger log = Logger.getLogger(NewsAction.class);
	private PrivelegeChecker PCK = new PrivelegeChecker();

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWS_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);
		try {
			request.setAttribute("CLIST",
					new NewsCategoryDao().getNewsCategoryByParentId(0));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return mapping.findForward("to");
	}

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWS_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		NewsForm f = (NewsForm) form;
		NewsDao dao = new NewsDao();
		request.setAttribute("surl", NEWS_LIST);
		int i = 0;
		try {
			i = dao.addNews(f.getTitle(), f.getTitle_color(), f.getClassid()
					.intValue(), f.getContent(), f.getStatus(), f.getSummary(),
					f.getTotop().intValue(), f.getVisit().intValue(), f
							.getPhoto(), f.getAuthor(), f.getOutlink(), f
							.getNewsfrom(), f.getAdminid().intValue());
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "SAVE_NEWS_OK");
		else {
			request.setAttribute("smsg", "SAVE_NEWS_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "MAN_NEWS"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String countsql = "select count(*) rows from tm_news";
		String querysql = "select tn.*,tc.cname from tm_news tn left join tm_news_cate tc on tn.classid=tc.id order by tn.id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to");
	}

	public ActionForward load(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWS_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		NewsDao dao = new NewsDao();
		request.setAttribute("surl", NEWS_LIST);
		Map map = null;
		try {
			request.setAttribute("CLIST",
					new NewsCategoryDao().getNewsCategoryByParentId(0));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		try {
			map = dao.getNewsById(Util.StringToInt(id));
			request.setAttribute("news", map);
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("smsg", "LOAD_NEWS_ERR");
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
		if (!this.PCK.HasPrivelege(request, "NEWS_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		NewsForm f = (NewsForm) form;
		String id = request.getParameter("id");
		NewsDao dao = new NewsDao();
		request.setAttribute("surl", NEWS_LIST);
		int i = 0;
		try {
			i = dao.updateNews(Util.StringToInt(id), f.getTitle(), f
					.getTitle_color(), f.getClassid().intValue(), f
					.getContent(), f.getStatus(), f.getSummary(), f.getTotop()
					.intValue(), f.getVisit().intValue(), f.getPhoto(), f
					.getAuthor(), f.getOutlink(), f.getNewsfrom(), f
					.getAdminid().intValue());
			DBUtil.commit();
		} catch (Exception e) {
			DBUtil.rollback();
			log.error(e.getMessage());
		}
		if (i == 1)
			request.setAttribute("smsg", "UPDATE_NEWS_OK");
		else {
			request.setAttribute("smsg", "UPDATE_NEWS_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWS_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		NewsDao dao = new NewsDao();
		request.setAttribute("surl", NEWS_LIST);
		int i = 0;
		try {
			i = dao.deleteNewsById(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_NEWS_OK");
		else {
			request.setAttribute("smsg", "DELETE_NEWS_ERR");
		}
		return mapping.findForward("msg");
	}

	public ActionForward add_newstype(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWSTYPE_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		return mapping.findForward("to_newstype");
	}

	public ActionForward save_newstype(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWSTYPE_ADD"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		NewsCategoryDao dao = new NewsCategoryDao();
		request.setAttribute("surl", NEWS_TYPE_LIST);
		int i = 0;
		try {
			i = dao.addNewsCategory(request.getParameter("cname"), 0, 0, 0,
					request.getParameter("remark"));
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

	public ActionForward list_newstype(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String countsql = "select count(*) rows from tm_news_cate";
		String querysql = "select * from tm_news_cate order by id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("to_newstype");
	}

	public ActionForward load_newstype(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWSTYPE_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		NewsCategoryDao dao = new NewsCategoryDao();
		request.setAttribute("surl", NEWS_TYPE_LIST);
		Map map = null;
		try {
			map = dao.getNewsCategoryById(Util.StringToInt(id));
			request.setAttribute("newstype", map);
		} catch (Exception e) {
			log.error(e.getMessage());
			request.setAttribute("smsg", "LOAD_ERR");
			return mapping.findForward("msg");
		}
		if (map == null) {
			request.setAttribute("smsg", "NO_DATA");
			return mapping.findForward("msg");
		}

		return mapping.findForward("to_newstype");
	}

	public ActionForward update_newstype(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWSTYPE_MODI"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		NewsCategoryDao dao = new NewsCategoryDao();
		request.setAttribute("surl", NEWS_TYPE_LIST);
		int i = 0;
		try {
			i = dao.updateNewsCategory(Util.StringToInt(id),
					request.getParameter("cname"), 0, 0, 0,
					request.getParameter("remark"));
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

	public ActionForward delete_newstype(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		if (!this.PCK.HasPrivelege(request, "NEWSTYPE_DELETE"))
			return this.PCK.RedirectToNoPrivelegePage(request, mapping);

		String id = request.getParameter("id");
		NewsCategoryDao dao = new NewsCategoryDao();
		request.setAttribute("surl", NEWS_TYPE_LIST);
		int i = 0;
		try {
			i = dao.deleteNewsCategoryById(Util.StringToInt(id));
			DBUtil.commit();
		} catch (Exception e) {
			log.error(e.getMessage());
			DBUtil.rollback();
		}
		if (i == 1)
			request.setAttribute("smsg", "DELETE_OK");
		else {
			request.setAttribute("smsg", "DELETE_ERR");
		}
		return mapping.findForward("msg");
	}
}