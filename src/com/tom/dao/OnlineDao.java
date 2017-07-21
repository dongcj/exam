package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OnlineDao extends BaseDao {
	public Map syncOnlineStatus(int uid, int pid, String exta, String ip)
			throws Exception {
		Map map = uniqueQuery("select * from tm_online where uid=?",
				new Object[] { Integer.valueOf(uid) });
		if (map != null)
			execute("update tm_online set lasttime=" + SystemCode.SYSDATE
					+ ",pid=? where uid=?", new Object[] {
					Integer.valueOf(pid), Integer.valueOf(uid) });
		else {
			execute("insert into tm_online(uid,pid,lasttime,exta,ip) values(?,?,"
					+ SystemCode.SYSDATE + ",?,?)",
					new Object[] { Integer.valueOf(uid), Integer.valueOf(pid),
							exta, ip });
		}
		return map;
	}

	public Map OnLineMap(int minute) throws Exception {
		Map m = new HashMap();
		List<Map> list = query(
				"select pid,count(*) total_on from tm_online where lasttime>date_add("
						+ SystemCode.SYSDATE
						+ ", interval ? minute) group by pid",
				new Object[] { Integer.valueOf(minute) });
		for (Map map : list) {
			m.put((String) map.get("PID"), map.get("TOTAL_ON"));
		}
		return m;
	}

	public List OnlineUsersOfPaper(int pid, int minute) throws Exception {
		String sql = "select t.*,tu.username,tu.realname,tu.photo from tm_online t left join tm_user tu on t.uid=tu.id where t.pid=? and t.lasttime>date_add(now(), interval ? minute)";

		return query(sql,
				new Object[] { Integer.valueOf(pid), Integer.valueOf(minute) });
	}

	public int sendCommand(String scmd, int uid) throws Exception {
		String sql = "update tm_online set exta=? where uid=?";
		return execute(sql, new Object[] { scmd, Integer.valueOf(uid) });
	}

	public int offLine(int uid) throws Exception {
		String sql = "delete from tm_online where uid=?";
		return execute(sql, new Object[] { Integer.valueOf(uid) });
	}
}