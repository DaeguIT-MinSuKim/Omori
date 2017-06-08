package com.dgit.domain;

import java.util.Date;

public class SelectedAnswerVO {
	private int sa_no;
	private UserVO user;
	private int tq_no;
	private int sa_answer;
	private Date sa_date;
	
	public int getSa_no() {
		return sa_no;
	}
	public void setSa_no(int sa_no) {
		this.sa_no = sa_no;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public int getTq_no() {
		return tq_no;
	}
	public void setTq_no(int tq_no) {
		this.tq_no = tq_no;
	}
	public int getSa_answer() {
		return sa_answer;
	}
	public void setSa_answer(int sa_answer) {
		this.sa_answer = sa_answer;
	}
	public Date getSa_date() {
		return sa_date;
	}
	public void setSa_date(Date sa_date) {
		this.sa_date = sa_date;
	}
	
}
