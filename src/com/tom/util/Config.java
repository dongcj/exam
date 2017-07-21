package com.tom.util;

import java.io.IOException;
import java.util.Properties;

public class Config {
	private static Properties prop = new Properties();

	static {
		try {
			prop.load(Config.class.getResourceAsStream("config.properties"));
		} catch (IOException ioe) {
			ioe.printStackTrace();
			throw new RuntimeException("读取系统配置文件发生错误");
		}
	}

	public static String get(String propName) {
		return prop == null ? "" : (String) prop.get(propName);
	}
}