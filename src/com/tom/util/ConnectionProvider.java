package com.tom.util;

import java.io.PrintStream;
import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

@Deprecated
public class ConnectionProvider {
	public static DataSource cpds;

	static {
		try {
			Context context = new InitialContext();
			cpds = (DataSource) context.lookup("java:comp/env/jdbc/tomutil");
			System.out.println("初始化数据源.." + cpds);
		} catch (NamingException e) {
			e.printStackTrace();
			System.out.println("初始化数据源时出错..");
		}
	}

	public static Connection getConnection() throws Exception {
		Connection conn = null;
		if (cpds != null)
			try {
				conn = cpds.getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
		else {
			try {
				Context context = new InitialContext();
				cpds = (DataSource) context
						.lookup("java:comp/env/jdbc/tomutil");
				conn = cpds.getConnection();
			} catch (NamingException e) {
				throw new Exception("初始化数据源时出错..");
			}
		}
		return conn;
	}
}