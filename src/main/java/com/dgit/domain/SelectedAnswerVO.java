package com.dgit.domain;

public class SelectedAnswerVO {
	private int sa_no;
	private TestNameVO testName;
	private TestQuestionVO question;
	private UserVO user;
	private int sa_answer;
	private String sa_date;
	
	public int getSa_no() {
		return sa_no;
	}
	public void setSa_no(int sa_no) {
		this.sa_no = sa_no;
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
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public int getSa_answer() {
		return sa_answer;
	}
	public void setSa_answer(int sa_answer) {
		this.sa_answer = sa_answer;
	}
	public String getSa_date() {
		return sa_date;
	}
	public void setSa_date(String sa_date) {
		this.sa_date = sa_date;
	}
}
