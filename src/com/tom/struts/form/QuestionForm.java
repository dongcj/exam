package com.tom.struts.form;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class QuestionForm extends ActionForm {
	private String content;
	private Integer id;
	private Integer qlevel;
	private String status;
	private String skey;
	private String keydesc;
	private Integer qtype;
	private Integer dbid;
	private Integer qfrom;
	private Integer adminid;

	public Integer getAdminid() {
		return this.adminid;
	}

	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}

	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getQlevel() {
		return this.qlevel;
	}

	public void setQlevel(Integer qlevel) {
		this.qlevel = qlevel;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSkey() {
		return this.skey;
	}

	public void setSkey(String skey) {
		this.skey = skey;
	}

	public String getKeydesc() {
		return this.keydesc;
	}

	public void setKeydesc(String keydesc) {
		this.keydesc = keydesc;
	}

	public Integer getQtype() {
		return this.qtype;
	}

	public void setQtype(Integer qtype) {
		this.qtype = qtype;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getQfrom() {
		return this.qfrom;
	}

	public void setQfrom(Integer qfrom) {
		this.qfrom = qfrom;
	}
}