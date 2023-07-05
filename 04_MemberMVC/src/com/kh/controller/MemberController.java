package com.kh.controller;

import java.sql.SQLException;

import com.kh.model.dao.MemberDAO;
import com.kh.model.vo.Member;

public class MemberController {

	private MemberDAO dao = new MemberDAO();
	
	public boolean joinMembership(Member m) {

		// id가 없다면 회원가입 후 true 반환
		// 없다면 false 값 반환
		
		
		try {
			if(dao.getMember(m.getId()) == null) {
				dao.registerMember(m);
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;

	}
	
	public String login(String id, String password) {

		
		Member m = new Member();
		m.setId(id);
		m.setPassword(password);
		
		try {
			Member result = dao.login(m);
			if(result != null) {// 로그인 성공하면 이름 반환
				return result.getName();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 실패하면 null 반환
		return null;
		
		
//		try {
//			if(dao.getMember(id).getId().equals(id) &&
//					dao.getMember(id).getPassword().equals(password)){
//				return dao.getMember(id).getName();
//			}
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		
	}
	
	public boolean changePassword(String id, String oldPw, String newPw) {

		
		
		
		Member m = new Member();
		m.setId(id);
		m.setPassword(oldPw);
		try {
			if(dao.login(m) != null) {
				// 로그인 했을 때 null이 아닌 경우
				m.setPassword(newPw);
				dao.updatePassword(m);
				return true;
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// 비밀번호 변경 후 true 반환, 아니라면 false 반환
		return false;
		
//		try {
//			if(dao.getMember(id).getId().equals(id) &&
//					dao.getMember(id).getPassword().equals(oldPw)){
//				Member changePw = new Member(id, newPw, dao.getMember(id).getName());
//				
//				dao.updatePassword(changePw);
//				return true;
//			}
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
	}
	
	public void changeName(String id, String name) {
		
		
		Member m = new Member();
		m.setId(id);
		m.setName(name);
		try {
			dao.updateName(m);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
//		try {
//			
//			Member changeName = new Member(id, dao.getMember(id).getPassword(), name);
//			
//			dao.updateName(changeName);
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
	}


}