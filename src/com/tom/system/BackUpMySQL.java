package com.tom.system;

import java.io.File;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BackUpMySQL {
	private static final String yyymmdd = new SimpleDateFormat("yyyyMMdd-HHmm")
			.format(new Date());

	public static boolean backUpDataBase(String mysqlbin_path, String user,
			String pass, String host, String database, String filepath) {
		String osname = System.getProperty("os.name");
		if (osname == null)
			return false;

		String filename = filepath + "HCFexam_bak." + yyymmdd + ".sql";
		String mysql = mysqlbin_path + "mysqldump.exe --host " + host
				+ " --user=" + user + " --password=" + pass + " --opt "
				+ database + "> " + filename;
		try {
			if (osname.toLowerCase().contains("win"))
				Runtime.getRuntime().exec("cmd /c " + mysql);
			else {
				Runtime.getRuntime().exec(new String[] { "sh", "-c", mysql });
			}

			Thread.sleep(5000L);
			File file = new File(filename);
			if (file.exists()) {
				if (file.length() > 0L)
					return true;
			} else
				return false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void main(String[] args) {
		boolean isok = backUpDataBase("e:\\", "root", "root", "localhost",
				"tomexam", "e:\\");
		System.out.println(isok);
	}
}