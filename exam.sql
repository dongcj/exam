-- phpMyAdmin SQL Dump
-- 主机: localhost
-- 生成日期:


SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `exam`
--

-- --------------------------------------------------------

--
-- 表的结构 `tm_admin`
--

CREATE TABLE IF NOT EXISTS `tm_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `userpass` varchar(50) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `realname` varchar(20) DEFAULT NULL,
  `mobi` varchar(20) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `logintimes` int(11) DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `tm_admin`
--

INSERT INTO `tm_admin` (`id`, `username`, `userpass`, `status`, `roleid`, `realname`, `mobi`, `remark`, `logintimes`, `lastlogin`) VALUES
(1, 'admin', '21232F297A57A5A743894A0E4A801FC3', '1', 1, 'admin', '1399999999', '超级管理员', 425, '2014-06-12 16:08:21');

-- --------------------------------------------------------

--
-- 表的结构 `tm_admin_roles`
--

CREATE TABLE IF NOT EXISTS `tm_admin_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) DEFAULT NULL,
  `roleprivelege` varchar(1000) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `tm_admin_roles`
--

INSERT INTO `tm_admin_roles` (`id`, `rolename`, `roleprivelege`, `remark`, `cdate`) VALUES
(1, '超级管理员', '#MAN_DB#QUESTION_BATCHUP#QUESTION_BATCHOP#QUESTION_ADD#DB_DELETE#DB_MODI#DB_ADD#QUESTION_MODI#QUESTION_DELETE#MAN_PAPER#EXMA_DETAIL#EXAM_DETAIL_DELETE#PAPER_CONFIG#PAPER_DELETE#PAPER_MODI#PAPER_ADD#MAN_EXAM#EXAM_FP#EXAM_MO#MAN_NEWS#NEWSTYPE_DELETE#NEWSTYPE_MODI#NEWSTYPE_ADD#NEWS_DELETE#NEWS_MODI#NEWS_ADD#MAN_USER#USER_BATCHOP#USER_BATCHUP#USER_GROUP_DELETE#USER_GROUP_MODI#USER_GROUP_ADD#USER_DELETE#USER_MODI#USER_ADD#MAN_SYSTEM#ROLE_DELETE#ROLE_MODI#ROLE_ADD#ADMIN_DELETE#ADMIN_MODI#ADMIN_ADD#SYS_USERINFO#SYS_CONFIG#MAN_ANALYSIS#ANA_CJ#ANA_SJ#ANA_KS#MAN_OTHERS#SU_ADMIN#MAN_PLUS#PLUS_DELETE#PLUS_MODI#PLUS_ADD#MAN_LOG#LOG_VIEW', '超级管理员', '2010-11-12 21:13:55'),
(2, '中级管理员', '#MAN_DB#DB_DELETE#DB_ADD#DB_MODI#QUESTION_MODI#QUESTION_DELETE#QUESTION_ADD#MAN_PAPER#EXAM_DETAIL_DELETE#EXMA_DETAIL#PAPER_CONFIG#PAPER_DELETE#PAPER_MODI#PAPER_ADD#MAN_EXAM#EXAM_FP#EXAM_MO#MAN_NEWS#NEWSTYPE_DELETE#NEWSTYPE_MODI#NEWSTYPE_ADD#NEWS_DELETE#NEWS_MODI#NEWS_ADD#MAN_SYSTEM#SYS_USERINFO#MAN_ANALYSIS#ANA_KS#ANA_SJ#ANA_CJ#MAN_PLUS#PLUS_MODI#PLUS_ADD#PLUS_DELETE', '一般操作', '2010-11-12 21:13:55'),
(3, '普通管理员', '#MAN_DB#QUESTION_ADD#DB_DELETE#DB_MODI#DB_ADD#QUESTION_MODI#QUESTION_DELETE#MAN_PAPER#EXAM_DETAIL_DELETE#EXMA_DETAIL#PAPER_CONFIG#PAPER_DELETE#PAPER_MODI#PAPER_ADD#MAN_NEWS#NEWSTYPE_DELETE#NEWSTYPE_MODI#NEWSTYPE_ADD#NEWS_DELETE#NEWS_MODI#NEWS_ADD', '最少的一些操作', '2010-11-12 21:13:55');

-- --------------------------------------------------------

--
-- 表的结构 `tm_admin_roles_settings`
--

CREATE TABLE IF NOT EXISTS `tm_admin_roles_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ptype` int(11) DEFAULT NULL,
  `pname` varchar(20) DEFAULT NULL,
  `pcode` varchar(50) DEFAULT NULL,
  `porder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=58 ;

--
-- 转存表中的数据 `tm_admin_roles_settings`
--

INSERT INTO `tm_admin_roles_settings` (`id`, `ptype`, `pname`, `pcode`, `porder`) VALUES
(1, 0, '用户管理', 'MAN_USER', 5),
(2, 1, '增加用户', 'USER_ADD', 0),
(3, 1, '修改用户资料', 'USER_MODI', 0),
(4, 1, '删除用户', 'USER_DELETE', 0),
(45, 0, '考试管理', 'MAN_EXAM', 3),
(5, 1, '创建用户分组', 'USER_GROUP_ADD', 0),
(6, 1, '修改用户分组', 'USER_GROUP_MODI', 0),
(7, 1, '删除用户分组', 'USER_GROUP_DELETE', 0),
(8, 0, '题库管理', 'MAN_DB', 1),
(9, 8, '创建题库', 'DB_ADD', 0),
(10, 8, '修改题库', 'DB_MODI', 0),
(11, 8, '删除题库', 'DB_DELETE', 0),
(12, 8, '创建试题', 'QUESTION_ADD', 0),
(13, 8, '修改试题', 'QUESTION_MODI', 0),
(14, 8, '删除试题', 'QUESTION_DELETE', 0),
(15, 0, '试卷管理', 'MAN_PAPER', 2),
(16, 15, '创建试卷', 'PAPER_ADD', 0),
(17, 15, '修改试卷', 'PAPER_MODI', 0),
(18, 15, '删除试卷', 'PAPER_DELETE', 0),
(19, 15, '配置试卷', 'PAPER_CONFIG', 0),
(48, 0, '插件管理', 'MAN_PLUS', 9),
(21, 15, '查看考试明细', 'EXMA_DETAIL', 0),
(22, 15, '删除考试明细', 'EXAM_DETAIL_DELETE', 0),
(23, 0, '新闻公告', 'MAN_NEWS', 4),
(24, 23, '发布新闻', 'NEWS_ADD', 0),
(25, 23, '修改新闻', 'NEWS_MODI', 0),
(26, 23, '删除新闻', 'NEWS_DELETE', 0),
(27, 23, '创建分类', 'NEWSTYPE_ADD', 0),
(28, 23, '管理分类', 'NEWSTYPE_MODI', 0),
(29, 23, '删除分类', 'NEWSTYPE_DELETE', 0),
(30, 0, '系统管理', 'MAN_SYSTEM', 6),
(31, 30, '系统设置', 'SYS_CONFIG', 0),
(32, 30, '个人资料修改', 'SYS_USERINFO', 0),
(33, 30, '增加管理员', 'ADMIN_ADD', 0),
(34, 30, '修改管理员', 'ADMIN_MODI', 0),
(35, 30, '删除管理员', 'ADMIN_DELETE', 0),
(36, 30, '创建角色', 'ROLE_ADD', 0),
(37, 30, '修改角色', 'ROLE_MODI', 0),
(38, 30, '删除角色', 'ROLE_DELETE', 0),
(39, 0, '分析系统', 'MAN_ANALYSIS', 7),
(40, 39, '成绩分布', 'ANA_CJ', 0),
(41, 39, '试卷分析', 'ANA_SJ', 0),
(42, 39, '考试分析', 'ANA_KS', 0),
(43, 0, '其他权限', 'MAN_OTHERS', 8),
(44, 43, '超级管理员权限', 'SU_ADMIN', 0),
(46, 45, '考试监控', 'EXAM_MO', 0),
(47, 45, '强制收卷', 'EXAM_FP', 0),
(49, 48, '增加插件', 'PLUS_ADD', 0),
(50, 48, '修改插件', 'PLUS_MODI', 0),
(51, 48, '删除插件', 'PLUS_DELETE', 0),
(52, 0, '系统日志', 'MAN_LOG', 10),
(53, 52, '系统日志查看', 'LOG_VIEW', 0),
(54, 1, '批量导入用户', 'USER_BATCHUP', 0),
(55, 1, '批量管理用户', 'USER_BATCHOP', 0),
(56, 8, '批量管理试题', 'QUESTION_BATCHOP', 0),
(57, 8, '批量导入试题', 'QUESTION_BATCHUP', 0);

-- --------------------------------------------------------

--
-- 表的结构 `tm_config`
--

CREATE TABLE IF NOT EXISTS `tm_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) DEFAULT NULL,
  `confkey` varchar(100) DEFAULT NULL,
  `confval` text,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `tm_config`
--

INSERT INTO `tm_config` (`id`, `cname`, `confkey`, `confval`, `remark`) VALUES
(1, '系统名称', 'sys_sitename', '网络考试系统v1.0', '系统名称'),
(2, '开放注册', 'sys_register', 'on', '是否允许新用户注册'),
(3, '开放用户登陆', 'sys_userlogin', 'on', '是否允许用户登陆'),
(4, '通讯频率', 'sys_communication_rate', '2', '通讯频率'),
(5, '注册码', 'sys_sncode', '1111-1111-1111-1111', '注册码'),
(6, '允许待审用户考试', 'sys_uncheckuser_exam', 'off', '允许待审用户考试');

-- --------------------------------------------------------

--
-- 表的结构 `tm_exam_detail`
--

CREATE TABLE IF NOT EXISTS `tm_exam_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `qid` int(11) DEFAULT NULL,
  `user_answer` varchar(500) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `qtype` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='状态：STATUS：1已批改，0未批改\r\n           试题类型：QTYPE：1单选，2多选，3填空，4判断，5' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `tm_exam_detail`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_exam_info`
--

CREATE TABLE IF NOT EXISTS `tm_exam_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `sdate` datetime DEFAULT NULL,
  `edate` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='状态：STATUS：1已答卷，0未答卷' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `tm_exam_info`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_log`
--

CREATE TABLE IF NOT EXISTS `tm_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logtype` varchar(2) DEFAULT NULL,
  `usertype` varchar(2) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `logtime` datetime DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `tm_log`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_news`
--

CREATE TABLE IF NOT EXISTS `tm_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `title_color` varchar(20) DEFAULT NULL,
  `classid` int(11) DEFAULT NULL,
  `content` text,
  `status` varchar(2) DEFAULT NULL,
  `summary` varchar(200) DEFAULT NULL,
  `totop` int(11) DEFAULT NULL,
  `visit` int(11) DEFAULT NULL,
  `postdate` datetime DEFAULT NULL,
  `photo` varchar(50) DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  `outlink` varchar(200) DEFAULT NULL,
  `newsfrom` varchar(50) DEFAULT NULL,
  `adminid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `tm_news`
--

INSERT INTO `tm_news` (`id`, `title`, `title_color`, `classid`, `content`, `status`, `summary`, `totop`, `visit`, `postdate`, `photo`, `author`, `outlink`, `newsfrom`, `adminid`) VALUES
(5, '公告测试公告测试公告测试公告测试', '000000', 1, '<p>公告测试公告测试公告测试公告测试公告测试公告测试</p>', '1', '', 0, 7, '2014-02-20 11:13:23', '', '本站', '', '本站', 1),
(4, '测试通知：请大家考试遵守纪律', '000000', 2, '<p>通知测试测试测试测通知测试通知测试通知测试通知测试通知测试通知测试通知测试</p>', '1', '通知测试', 1, 6, '2011-04-10 10:42:25', '', '本站', '', '本站', 1);

-- --------------------------------------------------------

--
-- 表的结构 `tm_news_cate`
--

CREATE TABLE IF NOT EXISTS `tm_news_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(50) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  `adminid` int(11) DEFAULT NULL,
  `orderid` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `tm_news_cate`
--

INSERT INTO `tm_news_cate` (`id`, `cname`, `parentid`, `adminid`, `orderid`, `remark`) VALUES
(1, '公告', 0, 0, 0, '公告公告公告公告公告公告'),
(2, '通知', 0, 0, 0, '通知通知通知通知通知');

-- --------------------------------------------------------

--
-- 表的结构 `tm_online`
--

CREATE TABLE IF NOT EXISTS `tm_online` (
  `uid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `lasttime` datetime DEFAULT NULL,
  `exta` varchar(20) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tm_online`
--

INSERT INTO `tm_online` (`uid`, `pid`, `lasttime`, `exta`, `ip`) VALUES
(1, 6, '2011-03-22 21:13:16', '', '192.168.1.101');

-- --------------------------------------------------------

--
-- 表的结构 `tm_paper`
--

CREATE TABLE IF NOT EXISTS `tm_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_name` varchar(100) DEFAULT NULL,
  `adminid` int(11) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `starttime` varchar(20) DEFAULT NULL,
  `endtime` varchar(20) DEFAULT NULL,
  `paper_minute` int(11) DEFAULT NULL,
  `total_score` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `qorder` varchar(2) DEFAULT NULL,
  `postdate` datetime DEFAULT NULL,
  `show_score` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='状态：STATUS：1开放，-1不开放\r\n           试题排序方式：QORDER：0原有顺序，1随机排序\r\n ' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `tm_paper`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_paper_detail`
--

CREATE TABLE IF NOT EXISTS `tm_paper_detail` (
  `pid` int(11) DEFAULT NULL,
  `qid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `orderid` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tm_paper_detail`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_paper_section`
--

CREATE TABLE IF NOT EXISTS `tm_paper_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `section_name` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `per_score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `tm_paper_section`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_paper_usergroup`
--

CREATE TABLE IF NOT EXISTS `tm_paper_usergroup` (
  `paperid` int(11) DEFAULT NULL,
  `usergroupid` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tm_paper_usergroup`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_plus`
--

CREATE TABLE IF NOT EXISTS `tm_plus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(100) DEFAULT NULL,
  `pdesc` varchar(500) DEFAULT NULL,
  `photo` varchar(50) DEFAULT NULL,
  `vurl` varchar(200) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `purl` varchar(100) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='状态1可用' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tm_plus`
--

INSERT INTO `tm_plus` (`id`, `pname`, `pdesc`, `photo`, `vurl`, `status`, `purl`, `cdate`) VALUES
(1, '万年历插件', '万年历插件，方便查询节气、纪念日、节日等。', 'skins/images/plus/calendar.png', 'plug-ins/calendar/calendar.html', '1', 'plug-ins/calendar/', '2011-03-22 14:11:14'),
(2, '实用计算器', '实用计算器', 'skins/images/plus/calculator.gif', 'plug-ins/calculator/index.html', '1', 'plug-ins/calculator/', '2011-03-23 14:09:50');

-- --------------------------------------------------------

--
-- 表的结构 `tm_question`
--

CREATE TABLE IF NOT EXISTS `tm_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dbid` int(11) DEFAULT NULL,
  `qtype` int(11) DEFAULT NULL,
  `qlevel` int(11) DEFAULT NULL,
  `qfrom` int(11) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `content` text,
  `postdate` datetime DEFAULT NULL,
  `skey` text,
  `keydesc` text,
  `adminid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='试题类型：QTYPE：1单选，2多选，3填空，4判断，5问答\r\n           难度级别：QLEVEL：易，5正常' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `tm_question`
--

INSERT INTO `tm_question` (`id`, `dbid`, `qtype`, `qlevel`, `qfrom`, `status`, `content`, `postdate`, `skey`, `keydesc`, `adminid`) VALUES
(1, 11, 1, 5, 1, '1', '<p>PS700为()CPU</p>', '2014-06-12 16:29:58', 'D', '', 1),
(2, 11, 2, 5, 1, '1', '<p>下面哪些属于虚拟带库()</p>', '2014-06-12 16:29:58', 'BD', '', 1),
(3, 11, 3, 5, 1, '1', '<p>P770内置光驱不能实现动态分区漂移</p>', '2014-06-12 16:29:58', 'NO', '', 1),
(4, 11, 4, 5, 1, '1', '<p>Power740的三级缓存是[BlankArea1]MB/core;Power 7+ 740的三级缓存是[BlankArea2]MB/core。新加一个[BlankArea3]</p>', '2014-06-12 16:29:58', '[{"VAL":"4","ID":"1"}, {"VAL":"10","ID":"2"}, {"VAL":"20","ID":"3"}]', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `tm_question_collection`
--

CREATE TABLE IF NOT EXISTS `tm_question_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  `detailid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `tm_question_collection`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_question_db`
--

CREATE TABLE IF NOT EXISTS `tm_question_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dname` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `adminid` int(11) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `tm_question_db`
--

INSERT INTO `tm_question_db` (`id`, `dname`, `remark`, `adminid`, `cdate`, `status`) VALUES
(11, '驾驶员考试题库', '驾驶员考试题库', 1, '2010-12-12 12:18:28', '1');

-- --------------------------------------------------------

--
-- 表的结构 `tm_question_options`
--

CREATE TABLE IF NOT EXISTS `tm_question_options` (
  `salisa` varchar(10) DEFAULT NULL,
  `qid` int(11) DEFAULT NULL,
  `soption` varchar(500) DEFAULT NULL,
  KEY `qid` (`qid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tm_question_options`
--

INSERT INTO `tm_question_options` (`salisa`, `qid`, `soption`) VALUES
('A', 1, '2core 3.8GHz'),
('B', 1, '4core 4.0GHz'),
('C', 1, '2core4.8GHz'),
('D', 1, '4core 3.0GHz'),
('A', 2, 'TS3310'),
('B', 2, 'TS7620'),
('C', 2, 'TS3500'),
('D', 2, 'TS7650G');

-- --------------------------------------------------------

--
-- 表的结构 `tm_systips`
--

CREATE TABLE IF NOT EXISTS `tm_systips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scode` varchar(50) DEFAULT NULL,
  `sdesc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=88 ;

--
-- 转存表中的数据 `tm_systips`
--

INSERT INTO `tm_systips` (`id`, `scode`, `sdesc`) VALUES
(1, 'NO_DATA', '数据不存在。'),
(2, 'USER_EXSIT', '用户已经存在。'),
(3, 'SAVE_ADMIN_OK', '新增管理员成功。'),
(4, 'SAVE_ADMIN_ERR', '新增管理员发生异常，操作失败。'),
(5, 'UPDATE_ADMIN_OK', '更新管理员信息成功。'),
(6, 'UPDATE_ADMIN_ERR', '更新管理员信息发生异常，操作失败。'),
(7, 'DELETE_ADMIN_OK', '删除管理员信息成功。'),
(8, 'DELETE_ADMIN_ERR', '删除管理员信息发生异常，操作失败。'),
(9, 'LOAD_ADMIN_ERR', '加载管理员信息发生异常。'),
(10, 'SAVE_ROLE_OK', '创建管理员角色成功。'),
(11, 'SAVE_ROLE_ERR', '创建管理员角色时发生异常，操作失败。'),
(12, 'UPDATE_ROLE_OK', '更新管理员角色信息成功。'),
(13, 'UPDATE_ROLE_ERR', '更新管理员角色时发生异常，操作失败。'),
(14, 'DELETE_ROLE_OK', '删除管理员角色成功。'),
(15, 'DELETE_ROLE_ERR', '删除管理员角色时发生异常，操作失败。'),
(16, 'LOAD_ROLE_ERR', '加载管理员角色信息时发生异常。'),
(17, 'SAVE_DB_OK', '创建题库成功。'),
(18, 'SAVE_DB_ERR', '创建题库时发生异常，操作失败。'),
(19, 'UPDATE_DB_OK', '更新题库信息成功。'),
(20, 'UPDATE_DB_ERR', '更新题库时发生异常，操作失败。'),
(21, 'DELETE_DB_OK', '删除题库成功。'),
(22, 'DELETE_DB_ERR', '删除题库时发生异常，操作失败。'),
(23, 'LOAD_DB_ERR', '加载题库信息时发生异常。'),
(24, 'SAVE_QUESTION_OK', '创建试题成功。'),
(25, 'SAVE_QUESTION_ERR', '创建试题时发生异常，操作失败。'),
(26, 'UPDATE_QUESTION_OK', '更新试题信息成功。'),
(27, 'UPDATE_QUESTION_ERR', '更新试题时发生异常，操作失败。'),
(28, 'DELETE_QUESTION_OK', '删除试题成功。'),
(29, 'DELETE_QUESTION_ERR', '删除试题时发生异常，操作失败。'),
(30, 'LOAD_QUESTION_ERR', '加载试题信息时发生异常。'),
(31, 'SAVE_USER_OK', '新增用户成功。'),
(32, 'SAVE_USER_ERR', '新增用户发生异常，操作失败。'),
(33, 'UPDATE_USER_OK', '更新用户信息成功。'),
(34, 'UPDATE_USER_ERR', '更新用户信息发生异常，操作失败。'),
(35, 'DELETE_USER_OK', '删除用户信息成功。'),
(36, 'DELETE_USER_ERR', '删除用户信息发生异常，操作失败。'),
(37, 'LOAD_USER_ERR', '加载用户信息发生异常。'),
(38, 'SAVE_PAPER_OK', '新增试卷成功'),
(39, 'SAVE_PAPER_ERR', '新增试卷发生异常，操作失败。'),
(40, 'UPDATE_PAPER_OK', '更新试卷信息成功。'),
(41, 'UPDATE_PAPER_ERR', '更新试卷信息发生异常，操作失败。'),
(42, 'DELETE_PAPER_OK', '删除试卷信息成功。'),
(43, 'DELETE_PAPER_ERR', '删除试卷信息发生异常，操作失败。'),
(44, 'LOAD_PAPER_ERR', '加载试卷信息发生异常。'),
(45, 'UPDATE_PAPER_ERR_001', '更新试题配置发生异常，替换旧的试题关系失败。'),
(46, 'UPDATE_PAPER_ERR_002', '更新试题配置发生异常，创建新的试题关系失败。'),
(47, 'UPDATE_PAPER_ERR_003', '更新试题配置发生异常，参数数量不匹配。'),
(48, 'UPDATE_PAPER_ERR_004', '更新试题配置发生异常，参数丢失。'),
(49, 'SAVE_NEWS_OK', '新增文章成功。'),
(50, 'SAVE_NEWS_ERR', '新增文章发生异常，操作失败。'),
(51, 'UPDATE_NEWS_OK', '更新文章信息成功。'),
(52, 'UPDATE_NEWS_ERR', '更新文章信息发生异常，操作失败。'),
(53, 'DELETE_NEWS_OK', '删除文章信息成功。'),
(54, 'DELETE_NEWS_ERR', '删除文章信息发生异常，操作失败。'),
(55, 'LOAD_NEWS_ERR', '加载文章信息发生异常。'),
(56, 'SAVE_OK', '保存数据成功。'),
(57, 'SAVE_ERR', '保存数据失败。'),
(58, 'UPDATE_OK', '更新数据成功。'),
(59, 'UPDATE_ERR', '更新数据失败。'),
(60, 'DELETE_OK', '删除数据成功。'),
(61, 'DELETE_ERR', '删除数据失败。'),
(62, 'LOAD_ERR', '加载数据失败。'),
(63, 'USERNO_EXSIT', '用户编号已经存在。'),
(64, 'CHECKPAPER_ERR', '提交试卷发生系统异常，请与管理员联系。'),
(65, 'CHECKPAPER_OK', '成功提交试卷。'),
(66, 'DELETE_PAPER_ERR2', '删除试卷失败，请先清空考试记录。'),
(67, 'UPDATE_PAPER_ERR_005', '已经有用户参加该试卷的考试，请先清空考试记录，再进行试题配置。'),
(68, 'NOT_START', '该考试尚未开始，请在规定时间内进入。'),
(69, 'NO_PRIVELEGE', '对不起，您没有进行该操作的权限。'),
(70, 'SAVE_CONFIG_OK', '新增系统参数成功。'),
(71, 'SAVE_CONFIG_ERR', '新增系统参数发生异常，操作失败。'),
(72, 'LOAD_CONFIG_ERR', '加载系统参数发生异常。'),
(73, 'UPDATE_CONFIG_OK', '更新系统参数成功。'),
(74, 'UPDATE_CONFIG_ERR', '更新系统参数发生异常，操作失败。'),
(75, 'ALLREADY_END', '该考试已经结束，请在规定的时间进入。'),
(76, 'VERSION_LIMIT_QES', '对不起，试题数量已经达到最大值。<br/>建议您购买该软件的正版授权码。'),
(77, 'VERSION_LIMIT_USER', '对不起，用户数量已经达到最大值。<br/>建议您购买该软件的正版授权码。'),
(78, 'NO_COPYRIGHT', '对不起，您所使用的注册码没有通过验证。<br/>建议您联系软件提供商，购买正版授权码。'),
(79, 'UNCHECKUSER_NO_EXAM', '对不起，未审核用户没有答卷的权限。'),
(80, 'SFZHM_EXSIT', '身份证号码已存在。'),
(81, 'QUESTION_NO_OPTIONS', '试题中选择题的选项不能为空！请重新修改试题后再上传。'),
(83, 'QUESTION_HAS_OPTIONS', '试题中非选择题，请将选项这一栏置空！'),
(84, 'QUESTION_MUST_YESORNO', '试题中判断题，答案只能为YES或NO（不区分大小写）！'),
(85, 'QUESTION_ANS_NOMATCH', '试题中的填空题的空位数与答案的个数不匹配！'),
(86, 'QUESTION_NO_SATISFY', '所有试题必须填写：题库ID，试题类型，题干内容及答案！'),
(87, 'QUESTION_OF_COMPLETION_NO_BLANK', '试题中的填空题必须要有答题的空格(使用“______”表示)！');

-- --------------------------------------------------------

--
-- 表的结构 `tm_test`
--

CREATE TABLE IF NOT EXISTS `tm_test` (
  `a` char(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tm_test`
--


-- --------------------------------------------------------

--
-- 表的结构 `tm_user`
--

CREATE TABLE IF NOT EXISTS `tm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userno` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `userpass` varchar(50) DEFAULT NULL,
  `photo` varchar(50) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `regdate` datetime DEFAULT NULL,
  `realname` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mobi` varchar(20) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `logintimes` int(11) DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `sfzhm` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=104 ;

--
-- 转存表中的数据 `tm_user`
--

INSERT INTO `tm_user` (`id`, `userno`, `username`, `userpass`, `photo`, `status`, `regdate`, `realname`, `email`, `mobi`, `remark`, `gid`, `logintimes`, `lastlogin`, `sfzhm`) VALUES
(87, '11222', 'admin', '21232F297A57A5A743894A0E4A801FC3', '', '1', '2014-02-24 21:38:05', 'ntwk', '', '', '', 6, 64, '2014-06-12 09:02:50', '420821198310093098');

-- --------------------------------------------------------

--
-- 表的结构 `tm_user_groups`
--

CREATE TABLE IF NOT EXISTS `tm_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `tm_user_groups`
--

INSERT INTO `tm_user_groups` (`id`, `groupname`, `remark`) VALUES
(6, '计算机软件', '计算机软件'),
(7, '财务', '财务'),
(8, '人力资源', '人力资源');
