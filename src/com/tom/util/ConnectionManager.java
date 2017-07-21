package com.tom.util;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mchange.v2.c3p0.DataSources;
import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionManager {
	private static ConnectionManager instance;
	private ComboPooledDataSource ds;

	private ConnectionManager() throws Exception {
		this.ds = new ComboPooledDataSource("userApp");
	}

	public static final ConnectionManager getInstance() {
		if (instance == null) {
			try {
				instance = new ConnectionManager();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}

	public final synchronized Connection getConnection() {
		try {
			return this.ds.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	protected void finalize() throws Throwable {
		DataSources.destroy(this.ds);
		super.finalize();
	}
}