package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.List;
import java.util.Map;

public class QuestionDao extends BaseDao {
	public int addQuestion(int dbid, int qtype, int qlevel, int qfrom,
			String status, String content, String skey, String keydesc,
			int adminid) throws Exception {
		String sql = "insert into tm_question(dbid,qtype,qlevel,qfrom,status,content,postdate,skey,keydesc,adminid)  values(?,?,?,?,?,?,"
				+ SystemCode.SYSDATE + ",?,?,?)";
		return execute(
				sql,
				new Object[] { Integer.valueOf(dbid), Integer.valueOf(qtype),
						Integer.valueOf(qlevel), Integer.valueOf(qfrom),
						status, content, skey, keydesc,
						Integer.valueOf(adminid) });
	}

	public int LAST_INSERT_QUESTIONID() {
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

	public Map getQuestionById(int id) throws Exception {
		String sql = "select * from tm_question where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int updateQuestion(int id, int dbid, int qtype, int qlevel,
			int qfrom, String status, String content, String skey,
			String keydesc) throws Exception {
		String sql = "update tm_question set dbid=?,qtype=?,qlevel=?,qfrom=?,status=?,content=?,skey=?,keydesc=? where id=?";
		return execute(sql,
				new Object[] { Integer.valueOf(dbid), Integer.valueOf(qtype),
						Integer.valueOf(qlevel), Integer.valueOf(qfrom),
						status, content, skey, keydesc, Integer.valueOf(id) });
	}

	public int deleteQuestionById(int id) throws Exception {
		String sql = "delete from tm_question where id = ?";
		return execute(sql, new Object[] { Integer.valueOf(id) });
	}

	public int addOption(String salisa, int qid, String soption)
			throws Exception {
		String sql = "insert into tm_question_options(salisa,qid,soption) values(?,?,?)";
		return execute(sql, new Object[] { salisa, Integer.valueOf(qid),
				soption });
	}

	public int addOptions(int qid, List<String> listOfOptions) throws Exception {
		int rows = 0;
		char alisa = 'A';
		if ((listOfOptions != null) && (listOfOptions.size() > 0)) {
			for (String s : listOfOptions) {
				String sql = "insert into tm_question_options(salisa,qid,soption) values(?,?,?)";
				String _alisa = alisa + "";
				rows += execute(sql.toString(),
						new Object[] { _alisa, Integer.valueOf(qid), s });
				alisa = (char) (alisa + '\001');
			}
		}
		return rows;
	}

	public int deleteOptionPyQuestionId(int qid) throws Exception {
		String sql = "delete from tm_question_options where qid=?";
		return execute(sql, new Object[] { Integer.valueOf(qid) });
	}

	public List getOptionsByQuestionId(int qid) throws Exception {
		String sql = "select * from tm_question_options where qid=? order by salisa asc";
		return query(sql, new Object[] { Integer.valueOf(qid) });
	}

	public List queryQuestions(int dbid, int qtype, int qlevel, int total)
			throws Exception {
		String sql = "select * from tm_question where dbid=? and qtype=? and qlevel=? and status='0' order by rand() limit 0,?";
		return query(sql,
				new Object[] { Integer.valueOf(dbid), Integer.valueOf(qtype),
						Integer.valueOf(qlevel), Integer.valueOf(total) });
	}

	public List queryQuestions_new(int dbid, int qtype, int qlevel, int total)
			throws Exception {
		String sql = "select * from tm_question where dbid=? and qtype=? and qlevel=? order by rand() limit 0,?";
		return query(sql,
				new Object[] { Integer.valueOf(dbid), Integer.valueOf(qtype),
						Integer.valueOf(qlevel), Integer.valueOf(total) });
	}

	public List queryQuestionOptions(List<Map> lista, List<Map> listb)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("-1,");
		if ((lista != null) && (lista.size() > 0)) {
			for (Map map : lista) {
				String qid = map.get("ID").toString();
				sb.append(qid + ",");
			}
		}
		if ((listb != null) && (listb.size() > 0)) {
			for (Map map : listb) {
				String qid = map.get("ID").toString();
				sb.append(qid + ",");
			}
		}
		sb.append("-1");
		String sql = "select * from tm_question_options where qid in ("
				+ sb.toString() + ") order by qid,salisa asc";

		return query(sql, new Object[0]);
	}

	public int getTotalQuestions() {
		String sql = "select count(1) TOTAL_QUESTIONS from tm_question";
		try {
			Map map = uniqueQuery(sql, new Object[0]);
			String TOTAL_QUESTIONS = String.valueOf(map.get("TOTAL_QUESTIONS"));
			return Integer.parseInt(TOTAL_QUESTIONS);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return -1;
	}
}