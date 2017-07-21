package com.tom.cache;

import com.tom.dao.ConfigDao;
import java.util.List;
import java.util.Map;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.apache.log4j.Logger;

public class ConfigCache {
	static final String cacheName = "ConfigCache";
	private static Logger log = Logger.getLogger(ConfigCache.class);

	static {
		CacheManager manager = CacheManager.getInstance();
		Cache c = manager.getCache("ConfigCache");
		log.info("加载ConfigCache...");
		ConfigDao dao = new ConfigDao();
		try {
			List<Map> list = dao.getAllConfig();
			for (Map map : list) {
				String key = (String) map.get("CONFKEY");
				String val = String.valueOf(map.get("CONFVAL"));
				Element e = new Element(key, val);
				c.put(e);
			}
			log.info("加载ConfigCache...[OK]");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	public static String getConfigByKey(String key) {
		if ((key == null) || ("".equals(key))) {
			return null;
		}
		CacheManager manager = CacheManager.getInstance();
		Cache c = manager.getCache("ConfigCache");
		Element result = c.get(key);

		if (result == null) {
			log.warn("ConfigCache[key=" + key + "]缓存中不存在，重新加载...");
			ConfigDao dao = new ConfigDao();
			Map map = null;
			try {
				String confval = null;
				map = dao.getConfigByKey(key);
				if (map != null) {
					confval = String.valueOf(map.get("CONFVAL"));
					Element e = new Element(key, confval);
					c.put(e);
				}
				return confval;
			} catch (Exception e) {
				log.error(e.getMessage());
				return null;
			}
		}

		return (String) result.getObjectValue();
	}
}