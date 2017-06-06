package com.dgit.domain;

import java.util.List;

public class TestQuestionVO {
	private int tq_no;
	private TestNameVO testName;
	private String tq_subject;
	private int tq_subject_no;
	private int tq_small_no;
	private String tq_question;
	private int tq_answer;
	private int tq_per;
	private List<TestExampleVO> exampleList;
	private List<ImageVO> imageList;
	
	public int getTq_no() {
		return tq_no;
	}
	public void setTq_no(int tq_no) {
		this.tq_no = tq_no;
	}
	public TestNameVO getTestName() {
		return testName;
	}
	public void setTestName(TestNameVO testName) {
		this.testName = testName;
	}
	public String getTq_subject() {
		return tq_subject;
	}
	public void setTq_subject(String tq_subject) {
		this.tq_subject = tq_subject;
	}
	public int getTq_subject_no() {
		return tq_subject_no;
	}
	public void setTq_subject_no(int tq_subject_no) {
		this.tq_subject_no = tq_subject_no;
	}
	public int getTq_small_no() {
		return tq_small_no;
	}
	public void setTq_small_no(int tq_small_no) {
		this.tq_small_no = tq_small_no;
	}
	public String getTq_question() {
		return tq_question;
	}
	public void setTq_question(String tq_question) {
		this.tq_question = tq_question;
	}
	public int getTq_answer() {
		return tq_answer;
	}
	public void setTq_answer(int tq_answer) {
		this.tq_answer = tq_answer;
	}
	public int getTq_per() {
		return tq_per;
	}
	public void setTq_per(int tq_per) {
		this.tq_per = tq_per;
	}
	public List<TestExampleVO> getExampleList() {
		return exampleList;
	}
	public void setExampleList(List<TestExampleVO> exampleList) {
		this.exampleList = exampleList;
	}
	public List<ImageVO> getImageList() {
		return imageList;
	}
	public void setImageList(List<ImageVO> imageList) {
		this.imageList = imageList;
	}
	
}