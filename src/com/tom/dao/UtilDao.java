package com.tom.dao;

import com.tom.cache.PaperCache;
import com.tom.vo.VOPaper;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class UtilDao extends BaseDao {
	public List getSYSCodes() throws Exception {
		String sql = "select * from tm_systips";
		return query(sql, new Object[0]);
	}

	public int LAST_INSERT_ID() {
		int i = -1;
		String sql = "select LAST_INSERT_ID() lid";
		try {
			Map map = uniqueQuery(sql, new Object[0]);
			if (map != null) {
				String lid = map.get("LID").toString();
				return Integer.parseInt(lid);
			}
		} catch (Exception e) {
			return -1;
		}
		return i;
	}

	public List LoadAllPapers() throws Exception {
		String sql = "select id,paper_name,status,paper_minute,total_score from tm_paper where status = ?";
		return query(sql, new Object[] { "1" });
	}

	public Map getPaperById(int id) throws Exception {
		String sql = "select * from tm_paper where id=?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public List LoadPaperSections(int pid) throws Exception {
		String sql = "select * from tm_paper_section where pid=? order by id asc";
		return query(sql, new Object[] { Integer.valueOf(pid) });
	}

	public List loadQuestionsBySectionId(int sid) throws Exception {
		String sql = "select td.*,tq.content,tq.id,tq.qtype,tq.skey from tm_paper_detail td left join tm_question tq on td.qid=tq.id where td.sid=? order by td.orderid";
		return query(sql, new Object[] { Integer.valueOf(sid) });
	}

	public List loadOptionsByQuestionId(int qid) throws Exception {
		String sql = "select * from tm_question_options where qid = ? order by salisa";
		return query(sql, new Object[] { Integer.valueOf(qid) });
	}

	public int getPaperLeftTime(String uid, String pid) throws Exception {
		String sql = "select * from tm_exam_info where uid=? and pid=?";
		int left = 0;
		VOPaper paper = PaperCache.getPaperById(pid);

		Map map = uniqueQuery(sql, new Object[] { uid, pid });
		if (map != null) {
			Timestamp sdate = (Timestamp) map.get("SDATE");
			long start = sdate.getTime();
			long now = new Date().getTime();
			long passed = now - start;
			int passed_min = (int) (passed / 60000L);

			if (paper != null)
				left = paper.getPaperMinute() - passed_min;
			else
				left = 0;
		} else {
			return paper.getPaperMinute();
		}
		return left;
	}

	public List CurrentExamList() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		String now_date = sdf.format(new Date());
		String sql = "select tp.*,ta.username from tm_paper tp left join tm_admin ta on tp.adminid=ta.id where tp.status !='9' and tp.starttime<='"
				+ now_date
				+ "' and tp.endtime>='"
				+ now_date
				+ "'"
				+ " order by tp.id desc";
		return query(sql, new Object[0]);
	}

	public int BatchImport(String sql, List<Object[]> list)
			throws Exception {
		return batchExcute(sql, list);
	}
	
	public int BatchImportq(List<Object[]> list)
			throws Exception {
		return batchExcuteq(list);
	}
}