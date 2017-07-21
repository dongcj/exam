package com.tom.system;

import java.io.File;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;

public class FileUtil {
	private static Logger log = Logger.getLogger(FileUtil.class);
	private static SimpleDateFormat sdf = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:SS");

	public static void main(String[] s) {
		try {
			for (File file : DirectoryFileList("E:/XW_Workstation/jsbo-wap/src/com/xwtec/jsbo/wap/elment"))
				System.out.println(file.getAbsolutePath() + "\t"
						+ sdf.format(new Date(file.lastModified())));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static List<File> DirectoryFileList(String path) throws Exception {
		List list = new ArrayList();
		try {
			File dir = new File(path);
			for (String filename : dir.list()) {
				File file = new File(path + "/" + filename);
				list.add(file);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new Exception("FileUtil.DirectoryFileList...Error");
		}
		return list;
	}

	public static List<File> DirectoryFileList(String path, String EXT_FILTER)
			throws Exception {
		List list = new ArrayList();
		for (File file : DirectoryFileList(path)) {
			if (file.getName().endsWith(EXT_FILTER))
				list.add(file);
		}
		return list;
	}

	public static int deleteFile(String filePathAndName) {
		try {
			String filePath = filePathAndName;
			File myDelFile = new File(filePath);
			if (myDelFile.exists()) {
				myDelFile.delete();
				return 1;
			}
			return 2;
		} catch (Exception e) {
		}
		return 9;
	}
}