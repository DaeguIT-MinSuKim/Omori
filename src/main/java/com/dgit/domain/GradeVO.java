package com.dgit.domain;

import java.util.Date;

public class GradeVO {
	private int g_no;
	private UserVO user;
	private TestNameVO testName;
	private int grade;
	private String g_subject;
	private int g_subject_grade;
	private String g_date;
	
	public int getG_no() {
		return g_no;
	}
	public void setG_no(int g_no) {
		this.g_no = g_no;
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
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getG_subject() {
		return g_subject;
	}
	public void setG_subject(String g_subject) {
		this.g_subject = g_subject;
	}
	public int getG_subject_grade() {
		return g_subject_grade;
	}
	public void setG_subject_grade(int g_subject_grade) {
		this.g_subject_grade = g_subject_grade;
	}
	public String getG_date() {
		return g_date;
	}
	public void setG_date(String g_date) {
		this.g_date = g_date;
	}
	
}