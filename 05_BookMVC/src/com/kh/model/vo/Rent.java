package com.kh.model.vo;

import java.util.Date;

public class Rent {
	private int rentNo;
	private Member rentMem;
	private Book rentBookNo;
	private Date rentDate;
	public Rent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Rent(int rentNo, Member rentMemNo, Book rentBookNo, Date rentDate) {
		super();
		this.rentNo = rentNo;
		this.rentMem = rentMemNo;
		this.rentBookNo = rentBookNo;
		this.rentDate = rentDate;
	}
	public int getRentNo() {
		return rentNo;
	}
	public void setRentNo(int rentNo) {
		this.rentNo = rentNo;
	}
	public Member getRentMemNo() {
		return rentMem;
	}
	public void setRentMemNo(Member rentMemNo) {
		this.rentMem = rentMemNo;
	}
	public Book getRentBookNo() {
		return rentBookNo;
	}
	public void setRentBookNo(Book rentBookNo) {
		this.rentBookNo = rentBookNo;
	}
	public Date getRentDate() {
		return rentDate;
	}
	public void setRentDate(Date rentDate) {
		this.rentDate = rentDate;
	}
	
	
}
