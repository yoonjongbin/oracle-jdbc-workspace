package com.youtube.impl;

import com.youtube.model.Video;

public interface VideoControllerImpl {
	public Video upload(); // 영상 업로드
	public Video[] videoList(); // 동영상 목록
	public Video viewVideo(); // 동영상 1개 보기
	public Video updateVideo(); // 동영상 수정
	public boolean deleteVideo(); // 동영상 삭제
}
