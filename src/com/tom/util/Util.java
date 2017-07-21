package com.tom.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class Util {
	public static synchronized int StringToInt(String source) {
		try {
			return Integer.parseInt(source);
		} catch (NumberFormatException e) {
		}
		return -9999;
	}

	public static synchronized String formatDate(Date date, String partten) {
		String s = "";
		SimpleDateFormat sdf = new SimpleDateFormat(partten);
		try {
			s = sdf.format(date);
		} catch (Exception e) {
			System.out.println("com.tom.util.Util.formatDate()发生异常,partten="
					+ partten);
		}
		return s;
	}

	public static synchronized String splitString(String s, int len) {
		String str = s;
		if ((s != null) && (s.length() > len)) {
			str = s.substring(0, len);
		}
		return str;
	}

	public static synchronized int SizeOfList(List list) {
		return list == null ? 0 : list.size();
	}

	public static String FormatBlankQuestions(String content, String input) {
		if ((content == null) || ("".equals(content))) {
			return "";
		}
		String result = "";
		Pattern p = Pattern.compile("\\[BlankArea.+?]");
		Matcher m = null;
		m = p.matcher(content);
		result = m.replaceAll(input);

		return result;
	}

	public static double CompareJSON(String key, String userkey) {
		JSONArray array_key = JSONArray.fromObject(key);
		JSONArray array_userkey = JSONArray.fromObject(userkey);

		if ((array_key == null) || (array_userkey == null)
				|| (array_key.size() < 2) || (array_userkey.size() < 1)) {
			return 0.0D;
		}

		if (key.contains("{\"QCOMPLEX\":\"YES\"}")) {
			String userkey_bak = key;
			double total = 0.0D;
			for (int i = 0; i < array_userkey.size(); i++) {
				JSONObject jo = array_userkey.getJSONObject(i);
				String VAL = (String) jo.get("VAL");

				String user_this_key = "\"VAL\":\"" + VAL + "\"";

				if (userkey_bak.contains(user_this_key)) {
					userkey_bak = userkey_bak.replaceAll(user_this_key, "");
					total += 1.0D;
				}
			}
			return total / (array_key.size() - 1);
		}

		double total = 0.0D;
		try {
			for (int i = 0; i < array_userkey.size(); i++) {
				JSONObject jo = array_userkey.getJSONObject(i);
				String ID = (String) jo.get("ID");
				String VAL = (String) jo.get("VAL");

				for (int j = 0; j < array_key.size(); j++) {
					JSONObject jokey = array_key.getJSONObject(j);
					String KEYID = (String) jokey.get("ID");
					String KEYVAL = (String) jokey.get("VAL");

					if ((ID.equals(KEYID)) && (VAL.equals(KEYVAL))) {
						total += 1.0D;
					}
				}
			}
			return total / (array_key.size() - 1);
		} catch (Exception localException) {
		}
		return 0.0D;
	}

	public static int dateDiff(Object o1, Object o2) {
		int i = 0;
		try {
			Timestamp sdate = (Timestamp) o1;
			Timestamp edate = (Timestamp) o2;
			long passed = edate.getTime() - sdate.getTime();
			int passed_min = (int) (passed / 60000L);
			i = 1 * passed_min;
		} catch (Exception e) {
			e.getMessage();
		}
		return i;
	}

	public static String dateDiffs(Object o1, Object o2) {
		try {
			Timestamp sdate = (Timestamp) o1;
			Timestamp edate = (Timestamp) o2;
			long passed = edate.getTime() - sdate.getTime();
			SimpleDateFormat sdf = new SimpleDateFormat("HH小时mm分钟SS秒");

			int passed_min = (int) (passed / 60000L);

			Date date = new Date(passed);
			return sdf.format(date);
		} catch (Exception e) {
			e.getMessage();
		}
		return "0";
	}

	public static String readFileByLines(String fileName) throws Exception {
		File file = new File(fileName);
		BufferedReader reader = null;
		StringBuffer sb = new StringBuffer();
		try {
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			while ((tempString = reader.readLine()) != null) {
				sb.append(tempString);
			}
			reader.close();
		} catch (IOException e) {
			throw new Exception("读取授权文件发生异常，文件可能不存在");
		} finally {
			if (reader != null)
				try {
					reader.close();
				} catch (IOException localIOException1) {
				}
		}
		return sb.toString();
	}

	public static boolean checksn(String sn) {
		boolean isok = false;

		return isok;
	}

	public static boolean isShowScore(String show_score) {
		if ((show_score == null) || (show_score.length() < 10)) {
			return true;
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String now_date = sdf.format(new Date());
		show_score = show_score.replaceAll(" ", "").replaceAll("/", "")
				.replaceAll(":", "");

		return now_date.compareTo(show_score) > 0;
	}

	public static String FUNCTION_FORMAT_PATH(String path) {
		String upath = path;
		upath = upath.replaceAll("\\\\", "\\\\\\\\");
		upath = upath.replaceAll("/", "//");

		if (upath.indexOf("/") > -1)
			upath = upath + "//";
		else {
			upath = upath + "\\\\";
		}
		return upath;
	}
	
	public String[]  stringToArr(String input) {
	    int i = 0;
	     StringTokenizer st = new StringTokenizer(input,"||");
	     int numTokens = st.countTokens();
	     String[] tokenList = new String[numTokens];
	     while (st.hasMoreTokens()){
	         tokenList[i] = st.nextToken().trim();
	         i++;
	     }
	     return(tokenList);
	}

	public static void main(String[] s) {
		String k = "[{\"VAL\":\"达芬奇\",\"ID\":\"1\"},{\"VAL\":\"米开朗琪罗\",\"ID\":\"2\"},{\"VAL\":\"拉斐尔\",\"ID\":\"3\"},{\"QCOMPLEX\":\"YES\"}]";

		String ku2 = "[{\"VAL\":\"拉斐尔\",\"ID\":\"1\"},{\"VAL\":\"liudehua\",\"ID\":\"2\"},{\"VAL\":\"米开朗琪罗\",\"ID\":\"3\"}]";
		System.out.println(3.0D * CompareJSON(k, ku2));
	}
}