package com.tom.dao;

import java.util.List;
import java.util.Map;

public class UserGroupDao extends BaseDao {
	public int addUserGroup(String groupname, String remark) throws Exception {
		String sql = "insert into tm_user_groups(groupname,remark) values(?,?)";
		return execute(sql, new Object[] { groupname, remark });
	}

	public Map getUserGroupById(int id) throws Exception {
		String sql = "select * from tm_user_groups where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updateUserGroup(int id, String groupname, String remark)
			throws Exception {
		String sql = "update tm_user_groups set groupname = ?, remark = ? where id = ?";
		return execute(sql,
				new Object[] { groupname, remark, Integer.valueOf(id) });
	}

	public int deleteUserGroupById(int id) throws Exception {
		String sql = "delete from tm_user_groups where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public List getALlGroups() throws Exception {
		return query("select * from tm_user_groups order by id desc",
				new Object[0]);
	}
}