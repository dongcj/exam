package com.tom.struts.form;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class NewsForm extends ActionForm {
	private String summary;
	private String status;
	private String outlink;
	private Integer totop;
	private Integer visit;
	private Integer adminid;
	private String photo;
	private Integer id;
	private String content;
	private String author;
	private String newsfrom;
	private String title;
	private String title_color;
	private Integer classid;

	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
	}

	public String getSummary() {
		return this.summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOutlink() {
		return this.outlink;
	}

	public void setOutlink(String outlink) {
		this.outlink = outlink;
	}

	public Integer getTotop() {
		return this.totop;
	}

	public void setTotop(Integer totop) {
		this.totop = totop;
	}

	public Integer getVisit() {
		return this.visit;
	}

	public void setVisit(Integer visit) {
		this.visit = visit;
	}

	public Integer getAdminid() {
		return this.adminid;
	}

	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getNewsfrom() {
		return this.newsfrom;
	}

	public void setNewsfrom(String newsfrom) {
		this.newsfrom = newsfrom;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle_color() {
		return this.title_color;
	}

	public void setTitle_color(String title_color) {
		this.title_color = title_color;
	}

	public Integer getClassid() {
		return this.classid;
	}

	public void setClassid(Integer classid) {
		this.classid = classid;
	}
}