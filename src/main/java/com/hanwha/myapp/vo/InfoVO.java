package com.hanwha.myapp.vo;

public class InfoVO {
	private int foodid;
	private String name;
	private double servingwt;
	private double kcal;
	private double carbo;
	private double protein;
	private double fat;
	private String company;
	
	// 회원의 음식 정보 삭제를 위한 noteid
	private int noteid;
	
	// 음식 섭취량 정보
	private double amount;
	
	// 일주일치 칼로리 총합
	private double weekKcal;
	// 일주일치 날짜
	private String notedate;
	
	public String getNotedate() {
		return notedate;
	}

	public void setNotedate(String notedate) {
		this.notedate = notedate;
	}

	public double getWeekKcal() {
		return weekKcal;
	}

	public void setWeekKcal(double weekKcal) {
		this.weekKcal = weekKcal;
	}

	public int getFoodid() {
		return foodid;
	}

	public void setFoodid(int foodid) {
		this.foodid = foodid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getServingwt() {
		return servingwt;
	}

	public void setServingwt(double servingwt) {
		this.servingwt = servingwt;
	}

	public double getKcal() {
		return kcal;
	}

	public void setKcal(double kcal) {
		this.kcal = kcal;
	}

	public double getCarbo() {
		return carbo;
	}

	public void setCarbo(double carbo) {
		this.carbo = carbo;
	}

	public double getProtein() {
		return protein;
	}

	public void setProtein(double protein) {
		this.protein = protein;
	}

	public double getFat() {
		return fat;
	}

	public void setFat(double fat) {
		this.fat = fat;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public int getNoteid() {
		return noteid;
	}

	public void setNoteid(int noteid) {
		this.noteid = noteid;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}
}
