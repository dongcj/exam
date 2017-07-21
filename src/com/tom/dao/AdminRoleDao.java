package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.List;
import java.util.Map;

public class AdminRoleDao extends BaseDao {
	public int addAdminRole(String rolename, String roleprivelege, String remark)
			throws Exception {
		String sql = "insert into tm_admin_roles(rolename, roleprivelege, remark, cdate) values(?,?,?,"
				+ SystemCode.SYSDATE + ")";
		return execute(sql, new Object[] { rolename, roleprivelege, remark });
	}

	public Map getAdminRoleById(int id) throws Exception {
		String sql = "select * from tm_admin_roles where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updateAdminRole(int id, String rolename, String roleprivelege,
			String remark) throws Exception {
		String sql = "update tm_admin_roles set rolename=?,roleprivelege=?,remark=? where id=?";
		return execute(sql, new Object[] { rolename, roleprivelege, remark,
				Integer.valueOf(id) });
	}

	public int deleteAdminRoleById(int id) throws Exception {
		String sql = "delete from tm_admin_roles where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public List getAdminRoleList() throws Exception {
		String sql = "select * from tm_admin_roles order by id desc";
		return query(sql, new Object[0]);
	}

	public List getPrivelegesList() throws Exception {
		String sql = "select * from tm_admin_roles_settings order by porder asc";
		return query(sql, new Object[0]);
	}

	public List getPrivelegesList(int ptype) throws Exception {
		String sql = "select * from tm_admin_roles_settings where ptype=? order by porder asc";
		return query(sql, new Object[] { Integer.valueOf(ptype) });
	}
}