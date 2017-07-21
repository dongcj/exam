package com.tom.util;

import com.tom.vo.VOMenu;
import com.tom.vo.VOMenuItem;
import java.util.ArrayList;
import java.util.List;

public class SystemMenu {
	private static List<VOMenu> MENU = new ArrayList();

	static {
		List MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(1, "创建题库", "db_add.png",
				"system/db.do?action=add", "DB_ADD"));
		MENU_ITEM.add(new VOMenuItem(1, "管理题库", "db.png",
				"system/db.do?action=list", "MAN_DB"));
		MENU_ITEM.add(new VOMenuItem(1, "增加试题", "note_add.png",
				"system/question.do?action=add", "QUESTION_ADD"));
		MENU_ITEM.add(new VOMenuItem(1, "管理试题", "note.png",
				"system/question.do?action=list", "QUESTION"));
		MENU.add(new VOMenu(1, "题库管理", MENU_ITEM, "MAN_DB", "exam_system"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(2, "创建试卷", "page_add.png",
				"system/paper.do?action=add", "PAPER_ADD"));
		MENU_ITEM.add(new VOMenuItem(2, "快速创建试卷", "page_fast.png",
				"system/paper.do?action=addrand", "PAPER_ADD"));
		MENU_ITEM.add(new VOMenuItem(2, "管理试卷", "page.png",
				"system/paper.do?action=list", "MAN_PAPER"));
		MENU.add(new VOMenu(2, "试卷管理", MENU_ITEM, "MAN_PAPER", "exam_system"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(3, "考试管理", "monitor.png",
				"system/paper.do?action=examlist", "EXAM_MO"));
		MENU.add(new VOMenu(3, "考试管理", MENU_ITEM, "EXAM_MO", "exam_system"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(4, "发布文章", "news_add.png",
				"system/news.do?action=add", "NEWS_ADD"));
		MENU_ITEM.add(new VOMenuItem(4, "管理文章", "news.png",
				"system/news.do?action=list", "MAN_NEWS"));
		MENU_ITEM.add(new VOMenuItem(4, "文章分类", "news_type.png",
				"system/news.do?action=list_newstype", "NEWSTYPE"));
		MENU_ITEM.add(new VOMenuItem(4, "新闻中心", "news_center.png",
				"page.do?action=comm_news&act=catelist", "NEWS"));
		MENU.add(new VOMenu(4, "文章管理", MENU_ITEM, "MAN_NEWS", "others"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(8, "增加插件", "plus_add.png",
				"system/plus.do?action=add", "PLUS_ADD"));
		MENU_ITEM.add(new VOMenuItem(8, "管理插件", "plus.png",
				"system/plus.do?action=list", "MAN_PLUS"));
		MENU.add(new VOMenu(8, "管理插件", MENU_ITEM, "MAN_PLUS", "others"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(5, "系统设置", "config.png",
				"system/config.do?action=list", "SYS_CONFIG"));
		MENU_ITEM.add(new VOMenuItem(5, "管理员", "user.png",
				"system/admin.do?action=list", "ADMIN"));
		MENU_ITEM.add(new VOMenuItem(5, "角色管理", "role.png",
				"system/adminrole.do?action=list", "ROLE"));
		MENU_ITEM.add(new VOMenuItem(5, "个人资料", "profile.png",
				"system/admin.do?action=profile", "SYS_USERINFO"));
		MENU.add(new VOMenu(5, "系统管理", MENU_ITEM, "MAN_SYSTEM", "system_manage"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(6, "增加用户", "user_add.png",
				"system/user.do?action=add", "USER_ADD"));
		MENU_ITEM.add(new VOMenuItem(6, "管理用户", "user_green.png",
				"system/user.do?action=list", "MAN_USER"));
		MENU_ITEM.add(new VOMenuItem(6, "用户分组", "group.png",
				"system/usergroups.do?action=list", "USER_GROUP"));
		MENU_ITEM.add(new VOMenuItem(6, "批量导入用户", "group.png",
				"system/import.do?action=user", "USER_BATCHUP"));
		MENU.add(new VOMenu(6, "用户管理", MENU_ITEM, "MAN_USER", "system_manage"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(9, "系统日志查看", "syslog.png",
				"system/log.do?action=list", "LOG_VIEW"));
		MENU.add(new VOMenu(9, "系统日志", MENU_ITEM, "MAN_LOG", "system_manage"));

		MENU_ITEM = new ArrayList();
		MENU_ITEM.add(new VOMenuItem(7, "成绩分布", "chart_pie.png",
				"system/analysis.do?action=chengji", "ANA_CJ"));
		MENU_ITEM.add(new VOMenuItem(7, "试卷分析", "chart_bar.png",
				"system/analysis.do?action=shijuan", "ANA_SJ"));
		MENU_ITEM.add(new VOMenuItem(7, "考试分析", "chart_curve.png",
				"system/analysis.do?action=kaoshi", "ANA_KS"));
		MENU.add(new VOMenu(7, "分析系统", MENU_ITEM, "MAN_ANALYSIS",
				"analysis_system"));
	}

	public static List<VOMenu> getMenu() {
		return MENU;
	}
}