package com.hanwha.myapp.vo;

public class UserNoteVO {
	private int noteid;
	private String userid;
	private int foodid;
	private String notedate;
	
	public int getNoteid() {
		return noteid;
	}
	public void setNoteid(int noteid) {
		this.noteid = noteid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getFoodid() {
		return foodid;
	}
	public void setFoodid(int foodid) {
		this.foodid = foodid;
	}
	public String getNotedate() {
		return notedate;
	}
	public void setNotedate(String notedate) {
		this.notedate = notedate;
	}
}
