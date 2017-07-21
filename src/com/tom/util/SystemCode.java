package com.tom.util;

import com.tom.cache.ConfigCache;
import com.tom.dao.UtilDao;
import com.tom.security.DesEncrypt;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SystemCode {
	public static String SYSDATE = "now()";

	public static String DATABASE = "mysql";

	private static Map<String, String> MAPINFO = null;

	public static Map<String, String> COLORS = null;

	public static String SECURITYKEY = "1DA5FA2AFF7938B4045EC357D413FCC4";

	public static String[] VERSIONS = { "FREE", "PUJI", "BIAO" };

	public static String uk = "";

	public static Map<String, String> SYSINFO = new HashMap<String, String>();

	public static String free_sncode = "1111-1111-1111-1111";

	public static int free_userCount = 9999;

	public static boolean isUserChangedSNCode = false;

	public static String SERVERIP = "";

	static {
		MAPINFO = new HashMap<String, String>();
		UtilDao dao = new UtilDao();
		try {
			System.out.println("加载系统编码...");
			List<Map> list_codes = dao.getSYSCodes();
			if ((list_codes != null) && (list_codes.size() > 0)) {
				for (Map m : list_codes) {
					MAPINFO.put((String) m.get("SCODE"),
							(String) m.get("SDESC"));
				}
			}
			MAPINFO.put("SY_AUTHOVER", "您所使用的注册码已经过期，请联系软件销售商。");
			MAPINFO.put("IMP_OK", "导入数据成功");
			MAPINFO.put("IMP_ERR", "导入数据失败");
			MAPINFO.put("BATCH_OK", "批量操作数据成功");
			MAPINFO.put("BATCH_ERR", "批量操作数据发生异常，失败");
			MAPINFO.put("VERSION_LIMIT_FUNCTION",
					"对不起，此功能暂不对免费用户开放，请联系软件销售商购买。");
		} catch (Exception e) {
			System.out.println("加载系统编码..错误...");
		}

		COLORS = new HashMap<String, String>();
		COLORS.put("红色", "ff0000");
		COLORS.put("绿色", "00ff00");
		COLORS.put("蓝色", "0000ff");
		COLORS.put("黑色", "000000");

		SYSINFO.put("SOFT_NAME", "HCF在线考试系统2013-2014");
		SYSINFO.put("SOFT_VER", "V2.0");
		SYSINFO.put("SOFT_DEV", "");
		SYSINFO.put("SOFT_REMARK", "");
	}

	public static String getSystemInfo(String key) {
		if (MAPINFO.containsKey(key)) {
			return (String) MAPINFO.get(key);
		}
		return "";
	}

	public static String getQuestionTypeName(String qtype) {
		if ("1".equals(qtype))
			return "单选题";
		if ("2".equals(qtype))
			return "多选题";
		if ("3".equals(qtype))
			return "判断题";
		if ("4".equals(qtype))
			return "填空题";
		if ("5".equals(qtype)) {
			return "问答题";
		}
		return "不存在的试题类型";
	}

	public static int getCommunicationRate() {
		String sys_communication_rate = ConfigCache
				.getConfigByKey("sys_communication_rate");
		int int_sys_communication_rate;
		try {
			int_sys_communication_rate = Integer
					.parseInt(sys_communication_rate);
		} catch (NumberFormatException e) {
			System.out.println("系统参数错误：sys_communication_rate，转换成数字发生错误:\n"
					+ e.getMessage());
			return -5;
		}
		return -1 * int_sys_communication_rate;
	}

	public static int valiusx(String uf, String sn, String sip) {
		if ((uf == null) || (uf.length() < 1)) {
			return 1;
		}
		if ((sn == null) || (sn.length() < 1)) {
			return 2;
		}

		if (free_sncode.equals(sn)) {
			return 0;
		}

		DesEncrypt des = new DesEncrypt();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			String sps = "elUeKxt";
			String[] aaa = uf.split(sps);

			String bbb = des.getDesString(aaa[0]);

			String[] ccc = bbb.split("#");

			if (!sn.equals(ccc[1])) {
				return 3;
			}

			String eee = new MD5().getMD5ofStr(bbb);
			if (!eee.equals(aaa[1])) {
				return 3;
			}

			String ddd = String.valueOf(ccc[2]);

			if (!ddd.contains(sip)) {
				return 4;
			}

			String nd = sdf.format(new Date());

			if (nd.compareTo(ccc[3]) > 0) {
				return 9;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}

		return 0;
	}

	public static String getLogType(String logtype) {
		if (logtype == null)
			return "";
		if ("1".equals(logtype)) {
			return "登陆日志";
		}
		return "未知类型";
	}
}