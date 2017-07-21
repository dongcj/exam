package com.tom.util;

import com.tom.dao.BaseDao;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

public class PageUtil extends BaseDao {
	private int PAGE_SIZE = 10;
	private int NOW_PAGE = 1;
	private int TOTAL_ROWS = 0;
	private int TOTAL_PAGES = 0;
	private HttpServletRequest REQUEST;
	private String COUNT_SQL;
	private String QUERY_SQL;

	public PageUtil(HttpServletRequest req, String count, String query,
			int pagesize) {
		this.REQUEST = req;
		this.COUNT_SQL = count;
		this.QUERY_SQL = query;
		this.PAGE_SIZE = pagesize;
	}

	public List getList() {
		List list = null;
		try {
			String epage = this.REQUEST.getParameter("epage");
			try {
				this.NOW_PAGE = Integer.parseInt(epage);
			} catch (Exception e1) {
				this.NOW_PAGE = 1;
			}

			this.QUERY_SQL = (this.QUERY_SQL + " limit " + (this.NOW_PAGE - 1)
					* this.PAGE_SIZE + "," + this.PAGE_SIZE);
			list = query(this.QUERY_SQL, new Object[0]);

			this.TOTAL_ROWS = getTotalRows();

			this.TOTAL_PAGES = (this.TOTAL_ROWS / this.PAGE_SIZE);
			if (this.TOTAL_ROWS % this.PAGE_SIZE > 0)
				this.TOTAL_PAGES += 1;

			this.REQUEST.setAttribute("foot", getNavFoot());
		} catch (Exception e) {
			return null;
		}

		return list;
	}

	private int getTotalRows() {
		try {
			Map map = uniqueQuery(this.COUNT_SQL, new Object[0]);
			if (map == null)
				return 0;
			String rows = map.get("ROWS") + "";
			return Integer.parseInt(rows);
		} catch (Exception e) {
		}
		return 0;
	}

	public String getNavFoot() {
		StringBuffer html = new StringBuffer();

		String currentURL = this.REQUEST.getRequestURL() + "";
		if ((this.REQUEST.getQueryString() != null)
				&& (!"".equals(this.REQUEST.getQueryString()))) {
			currentURL = currentURL + "?";
			currentURL = currentURL + this.REQUEST.getQueryString();

			if (currentURL.indexOf("epage") > -1) {
				currentURL = currentURL.substring(0,
						currentURL.indexOf("epage=" + this.NOW_PAGE) - 1);
			}
		}

		String opflag = "";
		if (currentURL.contains("?"))
			opflag = "&";
		else {
			opflag = "?";
		}

		if (this.NOW_PAGE <= 1)
			html.append("首页 ");
		else {
			html.append("<a href=\"" + currentURL + opflag
					+ "epage=1\">首页</a> ");
		}

		if (this.NOW_PAGE <= 1)
			html.append("上页 ");
		else {
			html.append("<a href=\"" + currentURL + opflag + "epage="
					+ (this.NOW_PAGE - 1) + "\">上页</a> ");
		}

		if (this.NOW_PAGE >= this.TOTAL_PAGES)
			html.append("下页 ");
		else {
			html.append("<a href=\"" + currentURL + opflag + "epage="
					+ (this.NOW_PAGE + 1) + "\">下页</a> ");
		}

		if (this.NOW_PAGE >= this.TOTAL_PAGES)
			html.append("尾页 ");
		else {
			html.append("<a href=\"" + currentURL + opflag + "epage="
					+ this.TOTAL_PAGES + "\">尾页</a> ");
		}

		html.append(" &nbsp; ");
		html.append(" 共" + getTOTAL_ROWS() + "条记录 ");
		html.append(" &nbsp; ");
		html.append(this.NOW_PAGE + "页/" + this.TOTAL_PAGES + "页");
		html.append("");
		html.append("");

		return html.toString();
	}

	public int getPAGE_SIZE() {
		return this.PAGE_SIZE;
	}

	public void setPAGE_SIZE(int pAGESIZE) {
		this.PAGE_SIZE = pAGESIZE;
	}

	public int getNOW_PAGE() {
		return this.NOW_PAGE;
	}

	public void setNOW_PAGE(int nOWPAGE) {
		this.NOW_PAGE = nOWPAGE;
	}

	public int getTOTAL_ROWS() {
		return this.TOTAL_ROWS;
	}

	public void setTOTAL_ROWS(int tOTALROWS) {
		this.TOTAL_ROWS = tOTALROWS;
	}

	public int getTOTAL_PAGES() {
		return this.TOTAL_PAGES;
	}

	public void setTOTAL_PAGES(int tOTALPAGES) {
		this.TOTAL_PAGES = tOTALPAGES;
	}

	public String getCOUNT_SQL() {
		return this.COUNT_SQL;
	}

	public void setCOUNT_SQL(String cOUNTSQL) {
		this.COUNT_SQL = cOUNTSQL;
	}

	public String getQUERY_SQL() {
		return this.QUERY_SQL;
	}

	public void setQUERY_SQL(String qUERYSQL) {
		this.QUERY_SQL = qUERYSQL;
	}
}