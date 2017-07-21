package com.tom.dao;

import java.util.List;

public class PaperExamDao extends BaseDao {
	@Deprecated
	public List getExamList(int pid) throws Exception {
		String sql = "select tei.*,tu.realname,tu.username,tu.userno from tm_exam_info tei left join tm_user tu on tei.uid=tu.id where tei.pid=?";
		return query(sql, new Object[] { Integer.valueOf(pid) });
	}

	public List getExamDetail(int uid, int pid) throws Exception {
		String sql = "select * from tm_exam_detail where uid=? and pid=?";
		return query(sql,
				new Object[] { Integer.valueOf(uid), Integer.valueOf(pid) });
	}

	public int SETScore(int did, int score) throws Exception {
		String sql = "update tm_exam_detail set score=?,status='1' where id=?";
		return execute(sql,
				new Object[] { Integer.valueOf(score), Integer.valueOf(did) });
	}

	public int RECountTotalScore(int pid, int uid, int id) throws Exception {
		String sql = "update tm_exam_info set score=(select sum(score) from tm_exam_detail where pid=? and uid=?) where id=?";
		return execute(sql,
				new Object[] { Integer.valueOf(pid), Integer.valueOf(uid),
						Integer.valueOf(id) });
	}

	public int deleteOnesExamRecord(int pid, int uid) throws Exception {
		String sql = "delete from tm_exam_info where pid=? and uid=?";
		return execute(sql,
				new Object[] { Integer.valueOf(pid), Integer.valueOf(uid) });
	}

	public int deleteOnesExamRecord(int pid) throws Exception {
		String sql = "delete from tm_exam_info where pid=?";
		return execute(sql, new Object[] { Integer.valueOf(pid) });
	}

	public int deleteOnesExamRecordDetail(int pid, int uid) throws Exception {
		String sql = "delete from tm_exam_detail where pid=? and uid=?";
		return execute(sql,
				new Object[] { Integer.valueOf(pid), Integer.valueOf(uid) });
	}

	public int deleteOnesExamRecordDetail(int pid) throws Exception {
		String sql = "delete from tm_exam_detail where pid=?";
		return execute(sql, new Object[] { Integer.valueOf(pid) });
	}
}