package com.tom.dao;

import java.util.List;
import java.util.Map;

public class AnalysisDao extends BaseDao {
	public Map analysisPaperById(int pid) throws Exception {
		String sql = "select tp.*, (select count(1) from tm_exam_info ti where ti.pid=?) total_people, (select count(1) from tm_exam_info ti where ti.pid=? and ti.score>=0.6*tp.total_score) pass_num, (select count(1) from tm_exam_info ti where ti.pid=? and ti.score<0.6*tp.total_score) not_pass_num, (select max(ti.score) from tm_exam_info ti where ti.pid=?) max_score, (select min(ti.score) from tm_exam_info ti where ti.pid=?) min_score, (select avg(ti.score) from tm_exam_info ti where ti.pid=?) avg_score,(select 0.6*tp.total_score) pass_score from tm_paper tp where tp.id=?";

		return uniqueQuery(
				sql,
				new Object[] { Integer.valueOf(pid), Integer.valueOf(pid),
						Integer.valueOf(pid), Integer.valueOf(pid),
						Integer.valueOf(pid), Integer.valueOf(pid),
						Integer.valueOf(pid) });
	}

	public List shijuan_chart(String[] from, String[] to, String pid)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		if ((from != null) && (from.length > 0)) {
			for (int i = 0; i < from.length; i++) {
				sb.append("select '" + from[i] + "' tfrom,'" + to[i] + "' tto,"
						+ "(select count(*) from tm_exam_info where pid=" + pid
						+ " and score>=" + from[i] + " and score<" + to[i]
						+ ") total ");
				if (i < from.length - 1) {
					sb.append(" union ");
				}
			}
		}

		return query(sb.toString(), new Object[0]);
	}

	public List kaoshi_detail(int pid) throws Exception {
		String sql = "select t.*,(t.mnum/t.totalnum)*100 tpercent from (  select td.qid,count(1) totalnum,  sum(if(td.score<=0,0,1)) mnum  from tm_exam_detail td where td.pid=? group by td.qid) t";

		return query(sql, new Object[] { Integer.valueOf(pid) });
	}
}