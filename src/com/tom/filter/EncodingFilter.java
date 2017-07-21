package com.tom.filter;

import com.tom.security.IPChecker;
import com.tom.util.DBUtil;
import com.tom.util.Util;
import java.io.PrintStream;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class EncodingFilter implements Filter {
	private static String USER_KEY_FILE = null;
	private static Logger log = Logger.getLogger(EncodingFilter.class);

	public void init(FilterConfig conf) {
		String basepath = conf.getServletContext().getRealPath(
				"/WEB-INF/authorization.dat");
		basepath = basepath.replaceAll("\\\\", "\\\\\\\\");
		basepath = basepath.replaceAll("/", "//");
		try {
			System.out.println("HCF Exam Loading...");
			com.tom.util.SystemCode.SERVERIP = IPChecker.getLocalIP();
			USER_KEY_FILE = Util.readFileByLines(basepath);
			com.tom.util.SystemCode.uk = USER_KEY_FILE;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) {
		try {
			try {
				DBUtil.closeConnection();
			} catch (Exception e) {
				log.error("Release Connection Error...");
				e.printStackTrace();
			}

			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse res = (HttpServletResponse) response;
			HttpSession session = req.getSession();

			req.setCharacterEncoding("UTF-8");
			res.setCharacterEncoding("UTF-8");

			String uri = req.getRequestURI();
			String path = req.getContextPath();
			String query = req.getQueryString();
			String url = uri
					+ (query == null ? "" : new StringBuilder("?")
							.append(query).toString());
			if (((session.getAttribute("TomUser") == null) || (session
					.getAttribute("TomUserType") == null))
					&& (!isURLRegister(url))) {
				toPage(request, response, path, "login.jsp", "1");
				// toPage(request, response, path, "examiner.jsp", "1");

				return;
			}

			chain.doFilter(req, res);
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}

	public void destroy() {
	}

	private void toPage(ServletRequest request, ServletResponse response,
			String path, String page, String totop) {
		String html = "<script>location.href='" + path + "/" + page
				+ "';</script>";
		PrintWriter out = null;
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		try {
			out = response.getWriter();
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		out.println(html);
		out.flush();
		out.close();
	}

	private boolean isURLRegister(String url) {
		return (url.contains("login.jsp")) || (url.contains("admin.jsp"))
				|| (url.contains("examiner.jsp"))
				|| (url.contains("process.do?action=login"))
				|| (url.contains("process.do?action=logout"))
				|| (url.contains("checkcode.jsp"))
				|| (url.contains("register.jsp"))
				|| (url.contains("ajax.do?action=checkUser"))
				|| (url.contains("ajax.do?action=register"))
				|| (url.contains("ajax.do?action=getUserGroups"));
	}
}