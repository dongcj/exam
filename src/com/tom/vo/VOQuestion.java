package com.tom.vo;

import java.util.List;

public class VOQuestion {
	private String questionContent;
	private String questionType;
	private String questionKey;
	private int questionId;
	private String questionScore;
	private List<VOOption> questionOptions;

	public String getQuestionScore() {
		return this.questionScore;
	}

	public void setQuestionScore(String questionScore) {
		this.questionScore = questionScore;
	}

	public int getQuestionId() {
		return this.questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getQuestionContent() {
		return this.questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public String getQuestionType() {
		return this.questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	public String getQuestionKey() {
		return this.questionKey;
	}

	public void setQuestionKey(String questionKey) {
		this.questionKey = questionKey;
	}

	public List<VOOption> getQuestionOptions() {
		return this.questionOptions;
	}

	public void setQuestionOptions(List<VOOption> questionOptions) {
		this.questionOptions = questionOptions;
	}
}