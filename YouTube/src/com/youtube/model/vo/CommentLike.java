package com.youtube.model.vo;

import java.util.Date;

public class CommentLike {
	private int commLikeCode;
	private Date commLikeDate;
	public CommentLike() {
		super();
		
	}
	public CommentLike(int commLikeCode, Date commLikeDate) {
		super();
		this.commLikeCode = commLikeCode;
		this.commLikeDate = commLikeDate;
	}
	public int getCommLikeCode() {
		return commLikeCode;
	}
	public void setCommLikeCode(int commLikeCode) {
		this.commLikeCode = commLikeCode;
	}
	public Date getCommLikeDate() {
		return commLikeDate;
	}
	public void setCommLikeDate(Date commLikeDate) {
		this.commLikeDate = commLikeDate;
	}
	@Override
	public String toString() {
		return "CommentLike [commLikeCode=" + commLikeCode + ", commLikeDate=" + commLikeDate + "]";
	}
	
	
}
