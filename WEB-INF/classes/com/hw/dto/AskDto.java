package com.hw.dto;

public class AskDto {
	private String id;
	private String title;
	private String content;
	private String askDate;
	private String answer;
	private String answerDate;
	
	public AskDto(){}
	
	public AskDto(String id, String title, String content, String askDate, String answer, String answerDate) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.askDate = askDate;
		this.answer = answer;
		this.answerDate = answerDate;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAskDate() {
		return askDate;
	}
	public void setAskDate(String askDate) {
		this.askDate = askDate;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(String answerDate) {
		this.answerDate = answerDate;
	}
	
}
