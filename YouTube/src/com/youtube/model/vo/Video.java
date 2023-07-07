package com.youtube.model.vo;

import java.util.Date;

public class Video {
	private int videoCode;
	private String videoTitle;
	private String videoDesc;
	private Date videoDate;
	private int videoViews;
	private String videoUrl;
	private String videoPhoto;
	private int categoryCode; 
	private int channelCode;
	private String memberId;
	public Video() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Video(int videoCode, String videoTitle, String videoDesc, Date videoDate, int videoViews, String videoUrl,
			String videoPhoto, int categoryCode, int channelCode, String memberId) {
		super();
		this.videoCode = videoCode;
		this.videoTitle = videoTitle;
		this.videoDesc = videoDesc;
		this.videoDate = videoDate;
		this.videoViews = videoViews;
		this.videoUrl = videoUrl;
		this.videoPhoto = videoPhoto;
		this.categoryCode = categoryCode;
		this.channelCode = channelCode;
		this.memberId = memberId;
	}
	public int getVideoCode() {
		return videoCode;
	}
	public void setVideoCode(int videoCode) {
		this.videoCode = videoCode;
	}
	public String getVideoTitle() {
		return videoTitle;
	}
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}
	public String getVideoDesc() {
		return videoDesc;
	}
	public void setVideoDesc(String videoDesc) {
		this.videoDesc = videoDesc;
	}
	public Date getVideoDate() {
		return videoDate;
	}
	public void setVideoDate(Date videoDate) {
		this.videoDate = videoDate;
	}
	public int getVideoViews() {
		return videoViews;
	}
	public void setVideoViews(int videoViews) {
		this.videoViews = videoViews;
	}
	public String getVideoUrl() {
		return videoUrl;
	}
	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	public String getVideoPhoto() {
		return videoPhoto;
	}
	public void setVideoPhoto(String videoPhoto) {
		this.videoPhoto = videoPhoto;
	}
	public int getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}
	public int getChannelCode() {
		return channelCode;
	}
	public void setChannelCode(int channelCode) {
		this.channelCode = channelCode;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	@Override
	public String toString() {
		return "Video [videoCode=" + videoCode + ", videoTitle=" + videoTitle + ", videoDesc=" + videoDesc
				+ ", videoDate=" + videoDate + ", videoViews=" + videoViews + ", videoUrl=" + videoUrl + ", videoPhoto="
				+ videoPhoto + ", categoryCode=" + categoryCode + ", channelCode=" + channelCode + ", memberId="
				+ memberId + "]";
	}
	
	
}
