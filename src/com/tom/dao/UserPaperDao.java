package com.tom.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class UserPaperDao extends BaseDao {
	public List getPapersByGroupId(int groupid) throws Exception {
		String sql = "select * from tm_paper where id in(select paperid from tm_paper_usergroup where usergroupid=?)";
		return query(sql, new Object[] { Integer.valueOf(groupid) });
	}

	public int addExamMainInfo(int uid, int pid, Date sdate, Date edate,
			String ip, String remark) throws Exception {
		List list = query("select * from tm_exam_info where uid=? and pid=?",
				new Object[] { Integer.valueOf(uid), Integer.valueOf(pid) });
		if ((list != null) && (list.size() > 0)) {
			return 0;
		}
		String sql = "insert into tm_exam_info(uid,pid,sdate,edate,ip,status,remark) values(?,?,?,?,?,?,?)";

		return execute(sql,
				new Object[] { Integer.valueOf(uid), Integer.valueOf(pid),
						sdate, edate, ip, "0", remark });
	}

	public int updateExamInfo(Date edate, int score, String status, int uid,
			int pid) throws Exception {
		String sql = "update tm_exam_info set edate=?,score=?,status=? where uid=? and pid=?";
		return execute(sql, new Object[] { edate, Integer.valueOf(score),
				status, Integer.valueOf(uid), Integer.valueOf(pid) });
	}

	public int addExamDetail(List<Object[]> list) throws Exception {
		String sql = "insert into tm_exam_detail(uid,pid,qid,user_answer,status,score,remark,qtype) values(?,?,?,?,?,?,?,?)";

		return batchExcute(sql, list);
	}

	public List getExamDetail(int uid, int pid) throws Exception {
		String sql = "select * from tm_exam_detail where uid=? and pid=?";
		return query(sql,
				new Object[] { Integer.valueOf(uid), Integer.valueOf(pid) });
	}

	public Map getExamInfo(int uid, int pid) throws Exception {
		String sql = "select * from tm_exam_info where uid=? and pid=?";
		return uniqueQuery(sql,
				new Object[] { Integer.valueOf(uid), Integer.valueOf(pid) });
	}

	public List getPaperExamByPid(String pid) throws Exception {
		String sql = "select tei.*,tu.realname,tu.username,tu.userno  from tm_exam_info tei left join tm_user tu on tei.uid=tu.id  where tei.pid="
				+ pid + " order by tei.id desc";
		return query(sql, new Object[0]);
	}
}