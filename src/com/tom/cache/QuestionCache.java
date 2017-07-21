package com.tom.cache;

import com.tom.dao.QuestionDao;
import com.tom.dao.UtilDao;
import com.tom.vo.VOOption;
import com.tom.vo.VOQuestion;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.apache.log4j.Logger;

public class QuestionCache {
	static final String cacheName = "QuestionCache";
	private static Logger log = Logger.getLogger(QuestionCache.class);

	public static VOQuestion getQuestionById(int qid) {
		VOQuestion question = null;

		CacheManager manager = CacheManager.getInstance();
		Cache c = manager.getCache("QuestionCache");
		Element result = c.get(Integer.valueOf(qid));
		if (result == null) {
			log.warn("加载试题不存在....qid=" + qid + "，从数据库再取一次");
			question = getQuestion(qid);
			if (question != null) {
				Element e = new Element(Integer.valueOf(qid), question);
				c.put(e);
			}
		} else {
			return (VOQuestion) result.getObjectValue();
		}
		return question;
	}

	private static VOQuestion getQuestion(int qid) {
		QuestionDao dao = new QuestionDao();
		VOQuestion question = null;

		Map map = new HashMap();
		try {
			map = dao.getQuestionById(qid);
			if (map != null) {
				question = new VOQuestion();

				String qtype = String.valueOf(map.get("QTYPE"));
				question.setQuestionContent((String) map.get("CONTENT"));
				question.setQuestionKey((String) map.get("SKEY"));
				question.setQuestionType(qtype);
				question.setQuestionScore(String.valueOf(map.get("SCORE")));
				question.setQuestionId(qid);

				if (("1".equals(qtype)) || ("2".equals(qtype)))
					question.setQuestionOptions(getOptions(qid));
				else
					question.setQuestionOptions(null);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return question;
	}

	private static List<VOOption> getOptions(int qid) throws Exception {
		List VOOptions = new ArrayList();
		UtilDao dao = new UtilDao();
		List<Map> list_options = dao.loadOptionsByQuestionId(qid);
		if ((list_options != null) && (list_options.size() > 0)) {
			for (Map map : list_options) {
				VOOption option = new VOOption();
				option.setOptionAlisa(String.valueOf(map.get("SALISA")));
				option.setOptionContent(String.valueOf(map.get("SOPTION")));

				VOOptions.add(option);
			}
		}
		return VOOptions;
	}
}