package com.tom.dao;

import com.tom.util.SystemCode;

public class LogDao extends BaseDao {
	public int addLog(String logtype, String usertype, String username,
			String uid, String ip, String remark) throws Exception {
		String sql = "insert into tm_log(logtype,usertype,username,uid,logtime,ip,remark) values(?,?,?,?,"
				+ SystemCode.SYSDATE + ",?,?)";
		return execute(sql, new Object[] { logtype, usertype, username, uid,
				ip, remark });
	}
}