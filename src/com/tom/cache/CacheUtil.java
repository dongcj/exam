package com.tom.cache;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import org.apache.log4j.Logger;

public class CacheUtil {
	private static Logger log = Logger.getLogger(CacheUtil.class);

	public static void removeCache(String cacheName) {
		try {
			CacheManager manager = CacheManager.getInstance();
			Cache c = manager.getCache(cacheName);
			if (c != null) {
				c.removeAll();
				log.info("清理全部[" + cacheName + "]");
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	public static void removeCache(String cacheName, String key) {
		try {
			CacheManager manager = CacheManager.getInstance();
			Cache c = manager.getCache(cacheName);
			if (c != null) {
				c.remove(key);
				log.info("清理[" + cacheName + "][" + key + "]");
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
}