package com.dgit.domain;

import java.util.Date;

public class NoteVO {
	private int note_no;
	private UserVO user;
	private TestNameVO testName;
	private TestQuestionVO question;
	private String note_content;
	private String note_memo;
	private Date note_date;
	
	public int getNote_no() {
		return note_no;
	}
	public void setNote_no(int note_no) {
		this.note_no = note_no;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public TestNameVO getTestName() {
		return testName;
	}
	public void setTestName(TestNameVO testName) {
		this.testName = testName;
	}
	public TestQuestionVO getQuestion() {
		return question;
	}
	public void setQuestion(TestQuestionVO question) {
		this.question = question;
	}
	public String getNote_content() {
		return note_content;
	}
	public void setNote_content(String note_content) {
		this.note_content = note_content;
	}
	public String getNote_memo() {
		return note_memo;
	}
	public void setNote_memo(String note_memo) {
		this.note_memo = note_memo;
	}
	public Date getNote_date() {
		return note_date;
	}
	public void setNote_date(Date note_date) {
		this.note_date = note_date;
	}
}