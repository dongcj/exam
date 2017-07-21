package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.Map;

public class PlusDao extends BaseDao {
	public int addPlus(String pname, String pdesc, String photo, String vurl,
			String status, String purl) throws Exception {
		String sql = "insert into tm_plus(pname,pdesc,photo,vurl,status,purl,cdate) values(?,?,?,?,?,?,"
				+ SystemCode.SYSDATE + ")";
		return execute(sql, new Object[] { pname, pdesc, photo, vurl, status,
				purl });
	}

	public int updatePlus(int id, String pname, String pdesc, String photo,
			String vurl, String status, String purl) throws Exception {
		String sql = "update tm_plus set pname=?,pdesc=?,photo=?,vurl=?,status=?,purl=? where id=?";
		return execute(sql, new Object[] { pname, pdesc, photo, vurl, status,
				purl, Integer.valueOf(id) });
	}

	public Map getPlusById(int id) throws Exception {
		String sql = "select * from tm_plus where id=?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int deletePlusById(int id) throws Exception {
		String sql = "delete from tm_plus where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}
}