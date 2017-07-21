package com.tom.vo;

import java.util.List;

public class VOSection {
	private int sectionId;
	private String sectionName;
	private String sectionRemark;
	private List<VOQuestion> sectionQuestions;

	public String getSectionRemark() {
		return this.sectionRemark;
	}

	public void setSectionRemark(String sectionRemark) {
		this.sectionRemark = sectionRemark;
	}

	public int getSectionId() {
		return this.sectionId;
	}

	public void setSectionId(int sectionId) {
		this.sectionId = sectionId;
	}

	public List<VOQuestion> getSectionQuestions() {
		return this.sectionQuestions;
	}

	public void setSectionQuestions(List<VOQuestion> sectionQuestions) {
		this.sectionQuestions = sectionQuestions;
	}

	public String getSectionName() {
		return this.sectionName;
	}

	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}
}