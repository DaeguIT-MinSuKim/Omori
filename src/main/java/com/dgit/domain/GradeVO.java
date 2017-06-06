package com.dgit.domain;

public class GradeVO {
	private int g_no;
	private UserVO user;
	private TestNameVO testName;
	private int grade;
	private String g_low;
	private int g_low_grade;
	private String g_high;
	private int g_high_grade;
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
	public String getG_low() {
		return g_low;
	}
	public void setG_low(String g_low) {
		this.g_low = g_low;
	}
	public int getG_low_grade() {
		return g_low_grade;
	}
	public void setG_low_grade(int g_low_grade) {
		this.g_low_grade = g_low_grade;
	}
	public String getG_high() {
		return g_high;
	}
	public void setG_high(String g_high) {
		this.g_high = g_high;
	}
	public int getG_high_grade() {
		return g_high_grade;
	}
	public void setG_high_grade(int g_high_grade) {
		this.g_high_grade = g_high_grade;
	}
	public String getG_date() {
		return g_date;
	}
	public void setG_date(String g_date) {
		this.g_date = g_date;
	}
}