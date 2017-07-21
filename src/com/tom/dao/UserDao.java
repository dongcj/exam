package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserDao extends BaseDao {
	public int addUser(String userno, String username, String userpass,
			String photo, String status, String realname, String email,
			String mobi, String remark, int gid, String sfzhm) throws Exception {
		String sql = "insert into tm_user(userno,username,userpass,photo,status,regdate,realname,email,mobi,remark,gid,logintimes,sfzhm) values(?,?,?,?,?,"
				+ SystemCode.SYSDATE + ",?,?,?,?,?,0,?)";

		// Test Code by dongcj
		System.out.println("增加用户:" + username);

		return execute(sql, new Object[] { userno, username, userpass, photo,
				status, realname, email, mobi, remark, Integer.valueOf(gid),
				sfzhm });
	}

	public Map getUserByUserName(String username) throws Exception {
		String sql = "select * from tm_user where username = ? ";
		return uniqueQuery(sql, new Object[] { username });
	}

	public Map getUserById(int id) throws Exception {
		String sql = "select tu.*,tg.groupname from tm_user tu left join tm_user_groups tg on tg.id=tu.gid where tu.id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public Map getUserByUserNo(String userno) throws Exception {
		String sql = "select * from tm_user where userno = ?";
		return uniqueQuery(sql, new Object[] { userno });
	}
	
	public Map getUserByEmail(String email) throws Exception {
		String sql = "select * from tm_user where email = ?";
		return uniqueQuery(sql, new Object[] { email });
	}

	public Map getUserByUserNameAndUserPass(String username, String userpass)
			throws Exception {
		String sql = "select * from tm_user where username = ? and userpass = ?";
		return uniqueQuery(sql, new Object[] { username, userpass });
	}

	public Map getUserBySfzhmAndUserPass(String sfzhm, String userpass)
			throws Exception {
		// 原来使用用户名登陆 现根据需求使用身份证号码登陆
		String sql = "select * from tm_user where sfzhm = ? and userpass = ?";
		return uniqueQuery(sql, new Object[] { sfzhm, userpass });
	}

	public Map getUserBySfzhm(String sfzhm) throws Exception {
		// String sql =
		// "select * from tm_user where username = ? and userpass = ?";
		// 原来使用用户名登陆 现根据需求使用身份证号码登陆
		String sql = "select * from tm_user where sfzhm = ?";
		return uniqueQuery(sql, new Object[] { sfzhm });
	}

	public int updateUser(int id, String userno, String userpass, String photo,
			String status, String realname, String email, String mobi,
			String remark, String sfzhm, int gid) throws Exception {
		String sql = "update tm_user set userno=?,userpass=?,photo=?,status=?,realname=?,email=?,mobi=?,remark=?,gid=?,sfzhm=? where id=?";
		return execute(sql, new Object[] { userno, userpass, photo, status,
				realname, email, mobi, remark, Integer.valueOf(gid), sfzhm,
				Integer.valueOf(id) });
	}

	public int updateUser(int id, String userno, String photo, String status,
			String realname, String email, String mobi, String remark,
			String sfzhm, int gid) throws Exception {
		String sql = "update tm_user set userno=?,photo=?,status=?,realname=?,email=?,mobi=?,remark=?,gid=?,sfzhm=? where id=?";
		return execute(
				sql,
				new Object[] { userno, photo, status, realname, email, mobi,
						remark, Integer.valueOf(gid), sfzhm,
						Integer.valueOf(id) });
	}

	public int deleteUserById(int id) throws Exception {
		String sql = "delete from tm_user where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updateLastLogin(int id) throws Exception {
		String sql = "update tm_user set lastlogin = " + SystemCode.SYSDATE
				+ ",logintimes=(logintimes+1) where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int getTotalUsers() {
		String sql = "select count(1) TOTALUSERS from tm_user";
		try {
			Map map = uniqueQuery(sql, new Object[0]);
			String s_total_users = String.valueOf(map.get("TOTALUSERS"));
			return Integer.parseInt(s_total_users);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return -1;
	}

	public int batchDelete(String[] ids) throws Exception {
		List list = new ArrayList();
		if (ids != null)
			for (String s : ids)
				list.add(new Object[] { s });
		return batchExcute("delete from tm_user where id=?", list);
	}

	public int batchSetStatus(String[] ids, String status) throws Exception {
		List list = new ArrayList();
		if (ids != null)
			for (String s : ids)
				list.add(new Object[] { status, s });
		return batchExcute("update tm_user set status=? where id=?", list);
	}

	public int batchSetGid(String[] ids, int gid) throws Exception {
		List list = new ArrayList();
		if (ids != null)
			for (String s : ids)
				list.add(new Object[] { Integer.valueOf(gid), s });
		return batchExcute("update tm_user set gid=? where id=?", list);
	}
}