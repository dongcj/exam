package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.Map;

public class AdminDao extends BaseDao {
	public int addAdmin(String username, String userpass, String status,
			int roleid, String realname, String mobi, String remark)
			throws Exception {
		String sql = "insert into tm_admin(username,userpass,status,roleid,realname,mobi,remark,logintimes,lastlogin) values(?,?,?,?,?,?,?,0,"
				+ SystemCode.SYSDATE + ")";
		return execute(
				sql,
				new Object[] { username, userpass, status,
						Integer.valueOf(roleid), realname, mobi, remark });
	}

	public Map getAdminById(int id) throws Exception {
		String sql = "select * from tm_admin where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public Map getAdminByUsername(String username) throws Exception {
		String sql = "select * from tm_admin where username = ?";
		return uniqueQuery(sql, new Object[] { username });
	}

	public Map getAdminByUserNameAndUserPass(String username, String userpass)
			throws Exception {
		String sql = "select * from tm_admin where username = ? and userpass = ?";
		return uniqueQuery(sql, new Object[] { username, userpass });
	}

	public int updateAdmin(int id, String userpass, String status, int roleid,
			String realname, String mobi, String remark) throws Exception {
		String sql = "update tm_admin set userpass = ?, status = ?, roleid = ?, realname = ?, mobi = ? , remark = ? where id = ?";
		return execute(sql,
				new Object[] { userpass, status, Integer.valueOf(roleid),
						realname, mobi, remark, Integer.valueOf(id) });
	}

	public int updateAdmin(int id, String status, int roleid, String realname,
			String mobi, String remark) throws Exception {
		String sql = "update tm_admin set status = ?, roleid = ?, realname = ?, mobi = ? , remark = ? where id = ?";
		return execute(sql, new Object[] { status, Integer.valueOf(roleid),
				realname, mobi, remark, Integer.valueOf(id) });
	}

	public int deleteAdminById(int id) throws Exception {
		String sql = "delete from tm_admin where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updateLastLogin(int id) throws Exception {
		String sql = "update tm_admin set lastlogin = " + SystemCode.SYSDATE
				+ ",logintimes=(logintimes+1) where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}
}