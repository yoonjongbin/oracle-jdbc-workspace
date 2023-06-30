package com.youtube.impl;

import com.youtube.model.User;

public interface UserControllerImpl {

	public boolean login(); // 로그인
	public boolean signUp(); // 회원가입
	public User viewProfile(); // 프로필 보기
	public User updateProfile(); // 프로필 수정
	public boolean deleteProfile(); // 계정 삭제
	
}
