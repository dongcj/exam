package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.List;

public class QcDao extends BaseDao {
	public int addQc(int qid, int uid, int did) throws Exception {
		List list = query(
				"select * from tm_question_collection where detailid=?",
				new Object[] { Integer.valueOf(did) });
		if ((list != null) && (list.size() > 0)) {
			return 0;
		}
		String sql = "insert into tm_question_collection(qid,uid,cdate,detailid) values(?,?,"
				+ SystemCode.SYSDATE + ",?)";
		return execute(sql,
				new Object[] { Integer.valueOf(qid), Integer.valueOf(uid),
						Integer.valueOf(did) });
	}

	public int deleteQc(int id) throws Exception {
		String sql = "delete from tm_question_collection where id=?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}
}