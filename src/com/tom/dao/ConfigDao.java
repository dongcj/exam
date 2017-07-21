package com.tom.dao;

import java.util.List;
import java.util.Map;

public class ConfigDao extends BaseDao {
	@Deprecated
	public int addConfig(String confkey, String confval, String remark,
			int conftype, String vals) throws Exception {
		String sql = "insert into tm_config(confkey,confval,remark, conftype, vals) values(?,?,?,?,?)";
		return execute(
				sql,
				new Object[] { confkey, confval, remark,
						Integer.valueOf(conftype), vals });
	}

	public Map getConfigById(int id) throws Exception {
		String sql = "select * from tm_config where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public List getAllConfig() throws Exception {
		String sql = "select * from tm_config";
		return query(sql, new Object[0]);
	}

	public Map getConfigByKey(String key) throws Exception {
		String sql = "select * from tm_config where confkey = ?";
		return uniqueQuery(sql, new Object[] { key });
	}

	public int updateConfigByKey(String confkey, String confval)
			throws Exception {
		String sql = "update tm_config set confval=? where confkey=?";
		return execute(sql, new Object[] { confval, confkey });
	}
}