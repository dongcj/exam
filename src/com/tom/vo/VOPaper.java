package com.tom.vo;

import java.util.List;

public class VOPaper {
	private int paperId;
	private String paperName;
	private String paperStatus;
	private int paperMinute;
	private int paperTotalScore;
	private String paperTitle;
	private String paperStart;
	private String paperEnd;
	private String qorder;
	private String showScore;
	private List<VOSection> paperSections;

	public String getShowScore() {
		return this.showScore;
	}

	public void setShowScore(String showScore) {
		this.showScore = showScore;
	}

	public String getQorder() {
		return this.qorder;
	}

	public void setQorder(String qorder) {
		this.qorder = qorder;
	}

	public String getPaperStart() {
		return this.paperStart;
	}

	public void setPaperStart(String paperStart) {
		this.paperStart = paperStart;
	}

	public String getPaperEnd() {
		return this.paperEnd;
	}

	public void setPaperEnd(String paperEnd) {
		this.paperEnd = paperEnd;
	}

	public String getPaperTitle() {
		return this.paperTitle;
	}

	public void setPaperTitle(String paperTitle) {
		this.paperTitle = paperTitle;
	}

	public int getPaperId() {
		return this.paperId;
	}

	public void setPaperId(int paperId) {
		this.paperId = paperId;
	}

	public String getPaperName() {
		return this.paperName;
	}

	public void setPaperName(String paperName) {
		this.paperName = paperName;
	}

	public String getPaperStatus() {
		return this.paperStatus;
	}

	public void setPaperStatus(String paperStatus) {
		this.paperStatus = paperStatus;
	}

	public int getPaperMinute() {
		return this.paperMinute;
	}

	public void setPaperMinute(int paperMinute) {
		this.paperMinute = paperMinute;
	}

	public int getPaperTotalScore() {
		return this.paperTotalScore;
	}

	public void setPaperTotalScore(int paperTotalScore) {
		this.paperTotalScore = paperTotalScore;
	}

	public List<VOSection> getPaperSections() {
		return this.paperSections;
	}

	public void setPaperSections(List<VOSection> paperSections) {
		this.paperSections = paperSections;
	}
}