package com.dgit.domain;

import java.util.Date;

public class NoteVO {
	private int note_no;
	private UserVO user;
	private int tno;
	private int tq_no;
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
	public int getTno() {
		return tno;
	}
	public void setTno(int tno) {
		this.tno = tno;
	}
	public int getTq_no() {
		return tq_no;
	}
	public void setTq_no(int tq_no) {
		this.tq_no = tq_no;
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