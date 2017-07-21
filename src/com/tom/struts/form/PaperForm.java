package com.tom.struts.form;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class PaperForm extends ActionForm {
	private String endtime;
	private Integer id;
	private String starttime;
	private String remark;
	private String status;
	private Integer total_score;
	private Integer paper_minute;
	private String paper_name;
	private String show_score;
	private Integer adminid;
	private String qorder;

	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
	}

	public String getEndtime() {
		return this.endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStarttime() {
		return this.starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getTotal_score() {
		return this.total_score;
	}

	public void setTotal_score(Integer total_score) {
		this.total_score = total_score;
	}

	public Integer getPaper_minute() {
		return this.paper_minute;
	}

	public void setPaper_minute(Integer paper_minute) {
		this.paper_minute = paper_minute;
	}

	public String getPaper_name() {
		return this.paper_name;
	}

	public void setPaper_name(String paper_name) {
		this.paper_name = paper_name;
	}

	public String getShow_score() {
		return this.show_score;
	}

	public void setShow_score(String show_score) {
		this.show_score = show_score;
	}

	public Integer getAdminid() {
		return this.adminid;
	}

	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}

	public String getQorder() {
		return this.qorder;
	}

	public void setQorder(String qorder) {
		this.qorder = qorder;
	}
}