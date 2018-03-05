package com.kopo.domain;

public class Criteria {

	private int page;
	private int perPageNum;
	private int pageStart;
	
	public Criteria() {
		this.setPage(1);
		this.setPerPageNum(10);
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() {
		
		pageStart = (this.page - 1) * perPageNum;
		return pageStart;
	}
	
	@Override
	public String toString() {
		return "Critera [page=" + page + ", "
				+ "perPageNum=" + perPageNum + "]";
	}
}
