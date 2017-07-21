package com.tom.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	private static final ThreadLocal threadLocal = new ThreadLocal();

	public static synchronized Connection getConnection() throws Exception {
		Connection conn = (Connection) threadLocal.get();
		try {
			if (conn == null) {
				conn = ConnectionManager.getInstance().getConnection();
				conn.setAutoCommit(false);
				threadLocal.set(conn);
			}
		} catch (Exception e) {
			throw new Exception("数据库访问失败..");
		}
		return conn;
	}

	public static void closeConnection() throws Exception {
		Connection conn = (Connection) threadLocal.get();
		if ((conn != null) && (!conn.isClosed())) {
			try {
				conn.close();
			} catch (Exception e) {
				throw new Exception("关闭数据库连接失败..");
			}
			threadLocal.set(null);
		}
	}

	public static void commit() throws Exception {
		getConnection().commit();
	}

	public static void rollback() {
		try {
			getConnection().rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}

	public static void close(ResultSet rs) {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}

	public static void close(Connection conn) {
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}