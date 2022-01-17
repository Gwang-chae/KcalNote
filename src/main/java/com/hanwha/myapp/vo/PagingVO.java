package com.hanwha.myapp.vo;

public class PagingVO {
	private int onePageRecord = 20;
	private int pageNum = 1;
	private int totalRecord;
	private int totalPage;
	private int selectRecord;
	private int onePageCount = 5;
	private int startPageNum = 1;
	private int pickRecord;
	
	private String searchKey;
	private String searchWord;
	private String searchBoardWord;
	
	public String getSearchBoardWord() {
		return searchBoardWord;
	}
	public void setSearchBoardWord(String searchBoardWord) {
		this.searchBoardWord = searchBoardWord;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		startPageNum = ((pageNum - 1) / onePageCount) * onePageCount + 1;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		if (totalRecord%onePageRecord == 0) {
			totalPage = totalRecord /onePageRecord;
		}else {
			totalPage = (totalRecord / onePageRecord) + 1;
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getSelectRecord() {
		selectRecord = pageNum * onePageRecord;
		return selectRecord;
	}
	public void setSelectRecord(int selectRecord) {
		this.selectRecord = selectRecord;
	}
	public int getOnePageCount() {
		return onePageCount;
	}
	public void setOnePageCount(int onePageCount) {
		this.onePageCount = onePageCount;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getPickRecord() {
		int modRecord = totalRecord % onePageRecord;
		if (pageNum == totalPage && modRecord != 0) {
			pickRecord = modRecord;
		}else {
			pickRecord = onePageRecord;
		}
		return pickRecord;
	}
	public void setPickRecord(int pickRecord) {
		this.pickRecord = pickRecord;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}
