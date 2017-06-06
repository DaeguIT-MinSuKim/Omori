package com.dgit.domain;

public class TestNameVO {
	private int tno;
	private String tname;
	private String tdate;
	
	public int getTno() {
		return tno;
	}
	public void setTno(int tno) {
		this.tno = tno;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTdate() {
		return tdate;
	}
	public void setTdate(String tdate) {
		this.tdate = tdate;
	}
	
	public String[] getSubjectNames(){
		String[] arrSub = new String[]{};
		if (tname.contains("정보처리기사")) {
			arrSub = new String[]{"데이터베이스", "전자계산기구조", "운영체제", "소프트웨어공학", "데이터통신"};
		}else if(tname.contains("컴퓨터활용능력")){
			
		}
		return arrSub;
	}
}
