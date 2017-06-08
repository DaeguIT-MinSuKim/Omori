package com.dgit.domain;

import java.util.Date;

public class NowGradeVO {
	private int ng_no;
	private UserVO user;
	private int tno;
	private String tq_subject;
	private int nowgrade;
	private int ng_count;
	private Date ng_date;
	
	public int getNg_no() {
		return ng_no;
	}
	public void setNg_no(int ng_no) {
		this.ng_no = ng_no;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public int getTno() {
		return tno;
	}
	public void setTno(int tno) {
		this.tno = tno;
	}
	public String getTq_subject() {
		return tq_subject;
	}
	public void setTq_subject(String tq_subject) {
		this.tq_subject = tq_subject;
	}
	public int getNowgrade() {
		return nowgrade;
	}
	public void setNowgrade(int nowgrade) {
		this.nowgrade = nowgrade;
	}
	public int getNg_count() {
		return ng_count;
	}
	public void setNg_count(int ng_count) {
		this.ng_count = ng_count;
	}
	public Date getNg_date() {
		return ng_date;
	}
	public void setNg_date(Date ng_date) {
		this.ng_date = ng_date;
	}
}
