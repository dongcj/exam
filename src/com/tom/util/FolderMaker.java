package com.tom.util;

import java.io.File;
import java.io.PrintStream;

public class FolderMaker {
	public boolean CreateFolder(String path) {
		boolean isok = false;
		try {
			if (!new File(path).isDirectory()) {
				System.out.println("即将创建文件夹[" + path + "]...");
				new File(path).mkdir();
			}
		} catch (Exception e) {
			System.out.println("创建文件夹[" + path + "]发生异常.");
		}

		return isok;
	}

	public static void main(String[] arg) {
	}
}