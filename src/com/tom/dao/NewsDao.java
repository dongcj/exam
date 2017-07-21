package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.List;
import java.util.Map;

public class NewsDao extends BaseDao {
	public int addNews(String title, String title_color, int classid,
			String content, String status, String summary, int totop,
			int visit, String photo, String author, String outlink,
			String newsfrom, int adminid) throws Exception {
		String sql = "insert into tm_news(title,title_color,classid,content,status,summary,totop,visit,postdate,photo,author,outlink,newsfrom,adminid)  values(?,?,?,?,?,?,?,?,"
				+ SystemCode.SYSDATE + ",?,?,?,?,?)";
		return execute(sql,
				new Object[] { title, title_color, Integer.valueOf(classid),
						content, status, summary, Integer.valueOf(totop),
						Integer.valueOf(visit), photo, author, outlink,
						newsfrom, Integer.valueOf(adminid) });
	}

	public int updateNews(int id, String title, String title_color,
			int classid, String content, String status, String summary,
			int totop, int visit, String photo, String author, String outlink,
			String newsfrom, int adminid) throws Exception {
		String sql = "update tm_news set title=?,title_color=?,classid=?,content=?,status=?,summary=?,totop=?,visit=?,photo=?,author=?,outlink=?,newsfrom=?,adminid=? where id=?";

		return execute(
				sql,
				new Object[] { title, title_color, Integer.valueOf(classid),
						content, status, summary, Integer.valueOf(totop),
						Integer.valueOf(visit), photo, author, outlink,
						newsfrom, Integer.valueOf(adminid), Integer.valueOf(id) });
	}

	public Map getNewsById(int id) throws Exception {
		String sql = "select * from tm_news where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int deleteNewsById(int id) throws Exception {
		String sql = "delete from tm_news where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int addNewsVisit(int id) throws Exception {
		String sql = "update tm_news set visit=(visit+1) where id=?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public List getNewsList(int rows) throws Exception {
		String sql = "select title,id,DATE_FORMAT(postdate,'%Y-%m-%d %h:%i %p') pdate from tm_news order by id desc limit 0,?";
		return query(sql, new Object[] { Integer.valueOf(rows) });
	}

	public List getNewsList(int rows, String classid) throws Exception {
		String sql = "select title,id,DATE_FORMAT(postdate,'%Y-%m-%d %h:%i %p') pdate from tm_news where classid="
				+ classid + " order by id desc limit 0,?";
		return query(sql, new Object[] { Integer.valueOf(rows) });
	}
}