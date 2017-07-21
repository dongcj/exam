package com.tom.dao;

import java.util.List;
import java.util.Map;

public class NewsCategoryDao extends BaseDao {
	public int addNewsCategory(String cname, int parentid, int adminid,
			int orderid, String remark) throws Exception {
		String sql = "insert into tm_news_cate(cname,parentid,adminid,orderid,remark) values(?,?,?,?,?)";
		return execute(sql, new Object[] { cname, Integer.valueOf(parentid),
				Integer.valueOf(adminid), Integer.valueOf(orderid), remark });
	}

	public int updateNewsCategory(int id, String cname, int parentid,
			int adminid, int orderid, String remark) throws Exception {
		String sql = "update tm_news_cate set cname=?,parentid=?,adminid=?,orderid=?,remark=? where id=?";
		return execute(sql, new Object[] { cname, Integer.valueOf(parentid),
				Integer.valueOf(adminid), Integer.valueOf(orderid), remark,
				Integer.valueOf(id) });
	}

	public Map getNewsCategoryById(int id) throws Exception {
		String sql = "select * from tm_news_cate where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public List<Map> getNewsCategoryByParentId(int parentid) throws Exception {
		String sql = "select * from tm_news_cate where parentid = ? order by id desc";
		return query(sql, new Object[] { Integer.valueOf(parentid) });
	}

	public int deleteNewsCategoryById(int id) throws Exception {
		String sql = "delete from tm_news_cate where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public List<Map> getNewsAllCategory() throws Exception {
		String sql = "select * from tm_news_cate order by id desc";
		return query(sql, new Object[0]);
	}
}