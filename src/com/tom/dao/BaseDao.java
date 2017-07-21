package com.tom.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tom.util.DBUtil;
import com.tom.util.SystemCode;
import com.tom.util.Util;

public class BaseDao {
	protected int execute(String sql, Object[] params) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		try {
			conn = DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error at:" + getClass().getName()
					+ "execute()");
		} finally {
			DBUtil.close(ps);
		}
		return result;
	}

	protected int batchExcute(String sql, List<Object[]> list) throws Exception {
		if (list == null)
			return 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			for (Object[] obj : list) {
				for (int i = 0; i < obj.length; i++) {
					ps.setObject(i + 1, obj[i]);
				}
				ps.addBatch();
			}
			int[] ii = ps.executeBatch();
			int i = ii.length;
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error at:" + getClass().getName()
					+ "batchExcute()");
		} finally {
			DBUtil.close(ps);
		}
	}

	protected int batchExcuteq(List<Object[]> list) throws Exception {
		if (list == null)
			return 0;
		Connection conn = null;
		PreparedStatement ps = null;
		int res = 0;
		int q_id = 1;
		try {
			conn = DBUtil.getConnection();

			for (Object[] obj : list) {
				q_id ++;
				// 都需要插入这条
				String sql = "insert into tm_question(dbid,qtype,qlevel,qfrom,status,content,postdate,skey,keydesc,adminid) "
						+ "values(?, ?, 5, 1, '1', ?, "
						+ SystemCode.SYSDATE
						+ ", ?, '', 1)";
				ps = conn.prepareStatement(sql);
				for (int i = 0; i < obj.length - 1; i++) {
					ps.setObject(i + 1, obj[i]);
				}
				res = ps.executeUpdate();
				System.out.println("试题" + q_id + ": " + obj[2].toString() + "。。。");

				// 如果options不为空(选择题), 则要插入多一条
				if (!obj[4].equals("")) {
				
					sql = "insert into tm_question_options(salisa, qid, soption) "
							+ "values(?, LAST_INSERT_ID(), ?)";
					ps = conn.prepareStatement(sql);
					// get the obj and set to selection
					String[] obj4arr = new Util().stringToArr(obj[4].toString());
					ArrayList lst = new ArrayList();
//					Map map = new HashMap();
					for (int i = 0; i < obj4arr.length; i++) {
						char[] a = Character.toChars(97 + i);
//						map.put(String.valueOf(a[0]).toUpperCase(), obj4arr[i]);
						ps.setObject(1, String.valueOf(a[0]).toUpperCase());
						ps.setObject(2, obj4arr[i]);
						ps.executeUpdate();
						System.out.println("试题" + q_id + ": " + obj[2].toString() + "。。。");
					}

				}
			}
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error at:" + getClass().getName()
					+ "batchExcuteq()");
		} finally {
			DBUtil.close(ps);
		}
	}

	// 返回第一个查询到的sql
	protected Map uniqueQuery(String sql, Object[] params) throws Exception {
		Map m = null;
		List list = query(sql, params);
		if ((list != null) && (list.size() > 0)) {
			m = (Map) list.get(0);
		}
		return m;
	}

	protected List query(String sql, Object[] params) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List list = new ArrayList();
		try {
			conn = DBUtil.getConnection();
			ps = conn.prepareStatement(sql.toString());
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			rs = ps.executeQuery();
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			int columns = resultSetMetaData.getColumnCount();
			while (rs.next()) {
				Map m = new HashMap();
				for (int i = 0; i < columns; i++) {
					Object obj = null;
					int type = resultSetMetaData.getColumnType(i + 1);
					int scale = resultSetMetaData.getScale(i + 1);
					String columnName = resultSetMetaData.getColumnName(i + 1);
					switch (type) {
					case -1:
						obj = rs.getObject(columnName);
						break;
					case 1:
						obj = rs.getCharacterStream(columnName);
						break;
					case -5:
						obj = Long.valueOf(rs.getLong(columnName));
						break;
					case 2:
						switch (scale) {
						case 0:
							obj = Integer.valueOf(rs.getInt(columnName));
							break;
						case -127:
							obj = Float.valueOf(rs.getFloat(columnName));
							break;
						default:
							obj = Integer.valueOf(rs.getInt(columnName));
						}
						break;
					case 12:
						obj = rs.getString(columnName);
						break;
					case 91:
						obj = rs.getDate(columnName);
						break;
					case 93:
						obj = rs.getTimestamp(columnName);
						break;
					case 2004:
						obj = rs.getBlob(columnName);
						break;
					default:
						obj = rs.getString(columnName);
					}
					m.put(columnName.toUpperCase(), obj);
				}
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		} finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
		}
		return list;
	}
}