package com.tom.dao;

import com.tom.util.SystemCode;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class VoteDao extends BaseDao {
	public int addVote(String title, String vcontent, String status,
			Date startdate, Date enddate) throws Exception {
		String sql = "insert into tm_vote(title,vcontent,status,cdate,startdate,enddate) values(?,?,"
				+ SystemCode.SYSDATE + ",?,?)";
		return execute(sql, new Object[] { title, vcontent, status, startdate,
				enddate });
	}

	public int updateVote(int id, String title, String vcontent, String status)
			throws Exception {
		String sql = "update tm_vote set  title=?, vcontent=?,status=? where id=?";
		return execute(sql,
				new Object[] { title, vcontent, status, Integer.valueOf(id) });
	}

	public Map getVoteById(int id) throws Exception {
		String sql = "select * from tm_vote where id = ?";
		return uniqueQuery(sql, new Object[] { Integer.valueOf(id) });
	}

	public int deleteVoteById(int vid) throws Exception {
		int i = 0;
		i += execute(
				"delete from tm_vote_option where itemid in (select id from tm_vote_item where vid = ?) ",
				new Object[] { Integer.valueOf(vid) });
		i += execute("delete from tm_vote_item where vid = ?",
				new Object[] { Integer.valueOf(vid) });
		i += execute("delete from tm_vote where id = ?",
				new Object[] { Integer.valueOf(vid) });
		return i;
	}

	public int addVoteItem(int vid, String vcontent, String itemtype,
			int maxvote) throws Exception {
		String sql = "insert into tm_vote_item(vid,vcontent,itemtype,maxvote) values(?,?,?,?)";
		return execute(sql, new Object[] { Integer.valueOf(vid), vcontent,
				itemtype, Integer.valueOf(maxvote) });
	}

	public List getVoteOptions(int vid) throws Exception {
		String sql = "select * from tm_vote_item where vid = ? order by id asc";
		return query(sql, new Object[] { Integer.valueOf(vid) });
	}

	public int deleteVoteItem(int itemid) throws Exception {
		int i = 0;
		i += execute("delete from tm_vote_option where itemid = ? ",
				new Object[] { Integer.valueOf(itemid) });
		i += execute("delete from tm_vote_item where id = ?",
				new Object[] { Integer.valueOf(itemid) });
		return i;
	}

	public int addVoteItemOptions(List<Object[]> list) throws Exception {
		String sql = "insert into tm_vote_option(itemid,ocontent,salisa,vtimes) values(?,?,?,0)";
		return batchExcute(sql, list);
	}
}