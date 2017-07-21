package com.tom.struts.form;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ConfigForm extends ActionForm {
	private String confval;
	private String remark;
	private String confkey;
	private int conftype;
	private String vals;

	public int getConftype() {
		return this.conftype;
	}

	public void setConftype(int conftype) {
		this.conftype = conftype;
	}

	public String getVals() {
		return this.vals;
	}

	public void setVals(String vals) {
		this.vals = vals;
	}

	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
	}

	public String getConfval() {
		return this.confval;
	}

	public void setConfval(String confval) {
		this.confval = confval;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getConfkey() {
		return this.confkey;
	}

	public void setConfkey(String confkey) {
		this.confkey = confkey;
	}
}