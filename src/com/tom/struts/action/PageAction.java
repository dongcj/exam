package com.tom.struts.action;

import com.tom.dao.NewsCategoryDao;
import com.tom.dao.NewsDao;
import com.tom.struts.services.PrivelegeChecker;
import com.tom.util.DBUtil;
import com.tom.util.PageUtil;
import com.tom.util.SystemMenu;
import com.tom.util.Util;
import com.tom.vo.VOMenu;
import com.tom.vo.VOMenuItem;
import java.io.PrintStream;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class PageAction extends DispatchAction {
	public ActionForward system_top(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("system_top");
	}

	public ActionForward system_menu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("sysmenu", buildSysMenu(request));
		return mapping.findForward("system_menu");
	}

	public ActionForward system_switch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("system_switch");
	}

	public ActionForward plus(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String countsql = "select count(*) rows from tm_plus where status='1'";
		String querysql = "select * from tm_plus where status='1' order by id desc";

		PageUtil pu = new PageUtil(request, countsql, querysql, 10);
		request.setAttribute("list", pu.getList());
		return mapping.findForward("user_plus");
	}

	public ActionForward comm_news(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String act = request.getParameter("act");
		String id = request.getParameter("id");
		String classid = request.getParameter("classid");

		if ("list".equals(act)) {
			String countsql = "select count(*) rows from tm_news";
			String querysql = "select tn.*,tc.cname from tm_news tn left join tm_news_cate tc on tn.classid=tc.id where tn.classid="
					+ classid + " order by tn.id desc";

			PageUtil pu = new PageUtil(request, countsql, querysql, 10);
			request.setAttribute("list", pu.getList());
		} else {
			String map_news_classid;
			if ("readthread".equals(act))
				try {
					NewsDao dao = new NewsDao();
					int int_id = Util.StringToInt(id);
					Map map_news = dao.getNewsById(int_id);
					request.setAttribute("news", map_news);

					if (map_news != null) {
						map_news_classid = (String) map_news.get("CLASSID");
						Map map_class = new NewsCategoryDao()
								.getNewsCategoryById(Util
										.StringToInt(map_news_classid));
						request.setAttribute("cname", map_class == null ? ""
								: map_class.get("CNAME"));
					}

					dao.addNewsVisit(int_id);
					DBUtil.commit();
				} catch (Exception e) {
					DBUtil.rollback();
					System.out
							.println("PageAction发生异常在comm_news().readthread\n"
									+ e.getMessage());
				}
			else if ("catelist".equals(act)) {
				try {
					List<Map> category = new NewsCategoryDao()
							.getNewsAllCategory();
					NewsDao ndao = new NewsDao();
					for (Map map : category) {
						String cid = String.valueOf(map.get("ID"));
						request.setAttribute("NEWS_" + cid,
								ndao.getNewsList(5, cid));
					}
					request.setAttribute("NEWS_CATEGORY", category);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return mapping.findForward("comm_news");
	}

	private String buildSysMenu(HttpServletRequest request) {
		String pannel = request.getParameter("pannel");

		StringBuffer sb = new StringBuffer("");
		PrivelegeChecker PCK = new PrivelegeChecker();

		for (VOMenu menu : SystemMenu.getMenu()) {
			if ((PCK.HasPrivelege(request, menu.getPrivelegeCode()))
					&& ((pannel == null) || (menu.getGroup().equals(pannel)))) {
				sb.append("<div class=\"menu\">");
				sb.append("\t<div class=\"menu_title\"><a href=\"javascript:void(0);\" onclick=\"$('#menu"
						+ menu.getMid()
						+ "').slideToggle('fast'); \">"
						+ menu.getMenuTitle() + "</a></div>");
				sb.append("\t<div class=\"menu_body\" id=\"menu"
						+ menu.getMid() + "\" style=\"display:block\">");
				for (VOMenuItem item : menu.getMenuItems()) {
					if (PCK.HasPrivelege(request, item.getPrivelegeCode())) {
						sb.append("<a href=\"" + item.getMenuItemUrl()
								+ "\" target=\"main\">");
						sb.append("<img src=\"skins/images/icons/"
								+ item.getMenuItemIcon()
								+ "\" align=\"absmiddle\" />"
								+ item.getMenuItemTitle() + "</a>");
					}
				}
				sb.append(" </div>");
				sb.append("</div>");
			}

		}

		return sb.toString();
	}
}