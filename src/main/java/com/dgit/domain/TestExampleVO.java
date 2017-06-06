package com.dgit.domain;

public class TestExampleVO {
	private int te_no;
	private TestQuestionVO question;
	private int te_small_no;
	private String te_content;
	
	public int getTe_no() {
		return te_no;
	}
	public void setTe_no(int te_no) {
		this.te_no = te_no;
	}
	public TestQuestionVO getQuestion() {
		return question;
	}
	public void setQuestion(TestQuestionVO question) {
		this.question = question;
	}
	public int getTe_small_no() {
		return te_small_no;
	}
	public void setTe_small_no(int te_small_no) {
		this.te_small_no = te_small_no;
	}
	public String getTe_content() {
		return te_content;
	}
	public void setTe_content(String te_content) {
		this.te_content = te_content;
	}
}