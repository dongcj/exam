package com.tom.cache;

import com.tom.dao.UtilDao;
import com.tom.util.Util;
import com.tom.vo.VOOption;
import com.tom.vo.VOPaper;
import com.tom.vo.VOQuestion;
import com.tom.vo.VOSection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.apache.log4j.Logger;

public class PaperCache {
	static final String cacheName = "PaperCache";
	private static Logger log = Logger.getLogger(PaperCache.class);

	public static VOPaper getPaperById(String pid) {
		if ((pid == null) || ("".equals(pid))) {
			return null;
		}
		CacheManager manager = CacheManager.getInstance();
		Cache c = manager.getCache("PaperCache");
		Element result = c.get(pid);
		if (result == null) {
			log.warn("加载试卷不存在....pid=" + pid + "，从数据库再取一次");
			try {
				VOPaper paper = getPaper(Util.StringToInt(pid));
				if (paper != null) {
					Element e = new Element(pid, paper);
					c.put(e);
				}
				return paper;
			} catch (Exception e) {
				log.error("从数据库获取试卷发生异常...pid=" + pid + "\n" + e.getMessage());
				e.printStackTrace();
				return null;
			}
		}

		return (VOPaper) result.getObjectValue();
	}

	private static VOPaper getPaper(int pid) throws Exception {
		UtilDao dao = new UtilDao();
		Map map = dao.getPaperById(pid);
		VOPaper paper = null;

		if (map != null) {
			paper = new VOPaper();
			String pminute = String.valueOf(map.get("PAPER_MINUTE"));
			String pscore = String.valueOf(map.get("TOTAL_SCORE"));

			paper.setPaperId(pid);
			paper.setPaperName((String) map.get("PAPER_NAME"));
			paper.setPaperMinute(Util.StringToInt(pminute));
			paper.setPaperStatus((String) map.get("STATUS"));
			paper.setPaperTotalScore(Util.StringToInt(pscore));
			paper.setPaperSections(getSections(pid));
			paper.setPaperTitle(String.valueOf(map.get("PAPER_NAME")));
			paper.setPaperStart(String.valueOf(map.get("STARTTIME")));
			paper.setPaperEnd(String.valueOf(map.get("ENDTIME")));
			paper.setQorder(String.valueOf(map.get("QORDER")));
			paper.setShowScore(String.valueOf(map.get("SHOW_SCORE")));
		}

		return paper;
	}

	private static List<VOSection> getSections(int pid) throws Exception {
		List Sections = new ArrayList();
		UtilDao dao = new UtilDao();
		List<Map> list_scetions = null;
		list_scetions = dao.LoadPaperSections(pid);

		if ((list_scetions != null) && (list_scetions.size() > 0)) {
			for (Map ms : list_scetions) {
				String sid = String.valueOf(ms.get("ID"));
				int isid = Util.StringToInt(sid);
				VOSection section = new VOSection();
				section.setSectionId(isid);
				section.setSectionName(String.valueOf(ms.get("SECTION_NAME")));
				section.setSectionRemark(String.valueOf(ms.get("REMARK")));
				section.setSectionQuestions(getQuestions(isid));

				Sections.add(section);
			}
		}
		return Sections;
	}

	private static List<VOQuestion> getQuestions(int sid) throws Exception {
		List Questions = new ArrayList();
		UtilDao dao = new UtilDao();
		List<Map> list_questions = dao.loadQuestionsBySectionId(sid);
		if ((list_questions != null) && (list_questions.size() > 0)) {
			for (Map map : list_questions) {
				VOQuestion question = new VOQuestion();

				String qid = String.valueOf(map.get("ID"));
				int iqid = Util.StringToInt(qid);
				String qtype = String.valueOf(map.get("QTYPE"));
				question.setQuestionContent((String) map.get("CONTENT"));
				question.setQuestionKey((String) map.get("SKEY"));
				question.setQuestionType(qtype);
				question.setQuestionId(iqid);
				question.setQuestionScore(String.valueOf(map.get("SCORE")));

				if (("1".equals(qtype)) || ("2".equals(qtype)))
					question.setQuestionOptions(getOptions(iqid));
				else {
					question.setQuestionOptions(null);
				}
				Questions.add(question);
			}

		}

		return Questions;
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