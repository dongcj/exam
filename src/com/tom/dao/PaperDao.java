package com.tom.dao;

import com.tom.util.DBUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;
import java.util.List;
import java.util.Map;

public class PaperDao extends BaseDao {
	public int addPaper(String paper_name, int adminid, String status,
			String starttime, String endtime, int paper_minute,
			int total_score, String remark, String qorder, String show_score)
			throws Exception {
		String sql = "insert into tm_paper(paper_name,adminid,status,starttime,endtime,paper_minute,total_score,remark,qorder,postdate,show_score)  values(?,?,?,?,?,?,?,?,?,"
				+ SystemCode.SYSDATE + ",?)";
		return execute(sql,
				new Object[] { paper_name, Integer.valueOf(adminid), status,
						starttime, endtime, Integer.valueOf(paper_minute),
						Integer.valueOf(total_score), remark, qorder,
						show_score });
	}

	public Map getPaperById(int id) throws Exception {
		String sql = "select * from tm_paper where id=?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updatePaper(int id, String paper_name, String status,
			String starttime, String endtime, int paper_minute, String remark,
			String qorder, String show_score) throws Exception {
		String sql = "update tm_paper set paper_name=?,status=?,starttime=?,endtime=?,paper_minute=?,remark=?,qorder=?,show_score=? where id=?";

		return execute(sql, new Object[] { paper_name, status, starttime,
				endtime, Integer.valueOf(paper_minute), remark, qorder,
				show_score, Integer.valueOf(id) });
	}

	@Deprecated
	public int deletePaper(int id) throws Exception {
		String sql = "delete from tm_paper where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int deletePaperLogic(int id) throws Exception {
		String sql = "update tm_paper set status='9' where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updatePaperTotalScore(int pid, int totalscore) throws Exception {
		String sql = "update tm_paper set total_score=? where id=?";
		return execute(
				sql,
				new Object[] { Integer.valueOf(totalscore),
						Integer.valueOf(pid) });
	}

	public void setPaperGroups(int pid, String[] gids) throws Exception {
		String sql = "delete from tm_paper_usergroup where paperid=?";
		execute(sql, new Object[] { Integer.valueOf(pid) });
		DBUtil.commit();

		if ((gids != null) && (gids.length > 0))
			for (String gid : gids) {
				sql = "insert into tm_paper_usergroup(paperid,usergroupid) values(?,?)";
				execute(sql,
						new Object[] { Integer.valueOf(pid),
								Integer.valueOf(Util.StringToInt(gid)) });
			}
	}

	public List getPaperGroupIds(int pid) throws Exception {
		String sql = "select usergroupid from tm_paper_usergroup where paperid=?";
		return query(sql, new Object[] { Integer.valueOf(pid) });
	}

	public int addPaperSection(int pid, String section_name, String remark,
			int per_score) throws Exception {
		String sql = "insert into tm_paper_section(pid,section_name,remark,per_score) values(?,?,?,?)";
		return execute(sql, new Object[] { Integer.valueOf(pid), section_name,
				remark, Integer.valueOf(per_score) });
	}

	public Map getPaperSectionById(int id) throws Exception {
		String sql = "select * from tm_paper_section where id=?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updatePaperSection(int sid, String section_name, String remark,
			int per_score) throws Exception {
		String sql = "update tm_paper_section set section_name=?,remark=?,per_score=? where id=?";
		return execute(sql,
				new Object[] { section_name, remark,
						Integer.valueOf(per_score), Integer.valueOf(sid) });
	}

	public int deletePaperSection(int id) throws Exception {
		String sql = "delete from tm_paper_section where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int countPaperTotalScore(int pid) throws Exception {
		String sql = "update tm_paper set total_score=(select sum(score) from tm_paper_detail where pid=?) where id=?";
		return execute(sql,
				new Object[] { Integer.valueOf(pid), Integer.valueOf(pid) });
	}

	public int deletePaperSectionByPid(int pid) throws Exception {
		String sql = "delete from tm_paper_section where pid = ?";
		return execute(sql, new Object[] { Integer.valueOf(pid) });
	}

	public List getPaperSectionList(int pid) throws Exception {
		String sql = "select * from tm_paper_section where pid=? order by id asc";
		return query(sql, new Object[] { Integer.valueOf(pid) });
	}

	public List getQuestionListBySectionId(int sid) throws Exception {
		String sql = "select td.*,tq.content,tq.id,tq.qtype from tm_paper_detail td left join tm_question tq on td.qid=tq.id where td.sid=? order by td.orderid";
		return query(sql, new Object[] { Integer.valueOf(sid) });
	}

	public int addPaperDetail(int pid, List<Map> list) throws Exception {
		int i = 0;
		if ((list != null) && (list.size() > 0)) {
			for (Map map : list) {
				int qid = Util.StringToInt(map.get("QID") + "");
				int score = Util.StringToInt(map.get("SCORE") + "");
				int orderid = Util.StringToInt(map.get("ORDERID") + "");
				int sid = Util.StringToInt(map.get("SID") + "");
				String sql = "insert into tm_paper_detail(pid,qid,sid,score,orderid) values(?,?,?,?,?)";
				i += execute(
						sql,
						new Object[] { Integer.valueOf(pid),
								Integer.valueOf(qid), Integer.valueOf(sid),
								Integer.valueOf(score),
								Integer.valueOf(orderid) });
			}
		}
		return i;
	}

	public int addPaperDetail_new(List<Object[]> list) throws Exception {
		int i = 0;
		String sql = "insert into tm_paper_detail(pid,qid,sid,score,orderid) values(?,?,?,?,?)";
		i = batchExcute(sql, list);
		return i;
	}

	public int deletePaperDetailByPaperId(int pid) throws Exception {
		String sql = "delete from tm_paper_detail where pid=?";
		return execute(sql, new Object[] { Integer.valueOf(pid) });
	}

	public int deletePaperDetailBySectionId(int sid) throws Exception {
		String sql = "delete from tm_paper_detail where sid=?";
		return execute(sql, new Object[] { Integer.valueOf(sid) });
	}

	public int HowManyPeopleExamedThePaper(int pid) throws Exception {
		String sql = "select count(1) t from tm_exam_info where pid = ?";
		Map map = uniqueQuery(sql, new Object[] { Integer.valueOf(pid) });
		int i = Util.StringToInt(map.get("T").toString());
		return i;
	}
}