package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.List;
import java.util.Map;

public class DbDao extends BaseDao {
	public int addDb(String dname, String remark, int adminid, String status)
			throws Exception {
		String sql = "insert into tm_question_db(dname,remark,adminid,cdate,status) values(?,?,?,"
				+ SystemCode.SYSDATE + ",?)";
		return execute(
				sql,
				new Object[] { dname, remark, Integer.valueOf(adminid), status });
	}

	public Map getDbById(int id) throws Exception {
		String sql = "select * from tm_question_db where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updateDb(int id, String dname, String remark, String status)
			throws Exception {
		String sql = "update tm_question_db set dname=?,remark=?,status=? where id=?";
		return execute(sql,
				new Object[] { dname, remark, status, Integer.valueOf(id) });
	}

	public int deleteDbById(int id) throws Exception {
		String sql = "delete from tm_question_db where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public List getDbList(String status) throws Exception {
		String sql = "select * from tm_question_db where status=? order by id desc";
		return query(sql, new Object[] { status });
	}
}