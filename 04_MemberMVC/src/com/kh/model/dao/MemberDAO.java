package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.model.vo.Member;

import config.ServerInfo;
import jdbc.MemberTest;

/*
 * dao란?
 * 
 * Database Access Object의 약자로 디비에 접근하는 로직
 * (일명 비즈니스 로직)을 담고 있는 객체
 * */


public class MemberDAO implements MemberDAOTemplate {
	private Properties p = new Properties();
	
	public static void main(String[] args) {

		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("driver loading....");
			
			MemberTest mt = new MemberTest();
			Member m = new Member("user01", "123456", "user1234");
			mt.registerMember(m);
//			System.out.println("회원가입!");
			
//			m.setPassword("123456");
//			mt.updatePassword(m);
//			System.out.println("비밀번호 변경!");
//		
//			m.setName("user1234");
//			mt.updateName(m);
//			System.out.println("이름 변경!");
			
			if(mt.getMember(m.getId()) == null)
				System.out.println("회원을 조회할 수 없습니다.");
			else
				System.out.println(mt.getMember(m.getId()));
			
			if(mt.login(m) == null)
				System.out.println("로그인 실패");
			else {
				
				System.out.println(mt.login(m).getName()+"님 환영합니다!");
			}
				
				
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	
	public MemberDAO() {
		
	}

	public Connection getConnect() throws SQLException {
		
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		
		return conn;
	}
	
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		if(st !=null) {
			st.close();
			conn.close();
		}
		
	}
	
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		if(rs != null) {
			rs.close();
			st.close();
			conn.close();
			
		}
	}
	
	public void registerMember(Member vo) throws SQLException {
		
		
		
		Connection conn = null;
		PreparedStatement st = null;
		
		try{
			conn = getConnect();
			conn.setAutoCommit(false);
			
			String query = "INSERT INTO MEMBER(ID, PASSWORD, NAME) VALUES(?, ?, ?)";
			
			st = conn.prepareStatement(query);
			
			st.setString(1, vo.getId());
			st.setString(2, vo.getPassword());
			st.setString(3, vo.getName());
				
			int result = st.executeUpdate();
			System.out.println(result + "명 추가");
			conn.commit();
			
			
			
			
		} catch(SQLException e) {
			e.printStackTrace();
			conn.rollback();
		}finally {
			conn.setAutoCommit(true);
			closeAll(st, conn);
		}
		
		
	}
	
	public void updatePassword(Member vo) throws SQLException { 
		Connection conn = null;
		PreparedStatement st = null;
		try{
			conn = getConnect();
			conn.setAutoCommit(false);
			String query = "UPDATE MEMBER SET PASSWORD = ? WHERE ID = ?";
			st = conn.prepareStatement(query);
			
			st.setString(1, vo.getPassword());
			st.setString(2, vo.getId());
			
			int result = st.executeUpdate();
			System.out.println(result + "명 수정");
			conn.commit();
		} catch(SQLException e) {
			e.printStackTrace();
			conn.rollback();
		}finally {
			conn.setAutoCommit(true);
			closeAll(st, conn);
		}
	}
	
	public void updateName(Member vo) throws SQLException {
		Connection conn = null;
		PreparedStatement st = null;
		
		try{
			conn = getConnect();
			conn.setAutoCommit(false);
			String query = "UPDATE MEMBER SET NAME = ? WHERE ID = ?";
			st = conn.prepareStatement(query);
			
			st.setString(1, vo.getName());
			st.setString(2, vo.getId());
			
			int result = st.executeUpdate();
			System.out.println(result + "명 수정");
			conn.commit();
		} catch(SQLException e) {
			e.printStackTrace();
			conn.rollback();
		}finally {
			conn.setAutoCommit(true);
			closeAll(st, conn);
		}
	}
	
	public Member getMember(String id) throws SQLException {
		
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try{
			conn = getConnect();
			String query = "SELECT * FROM MEMBER WHERE ID = ?";
			st = conn.prepareStatement(query);
			
			st.setString(1, id);
			
			rs = st.executeQuery();
			
			if(rs.next()) {
				Member viewMem = new Member(rs.getString("id"), rs.getString("password"), rs.getString("name"));
				
				return viewMem;
			}
			

		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			conn.setAutoCommit(true);
			closeAll(rs, st, conn);
		}
		
		return null;
	}
	
	public Member login(Member vo) throws SQLException {
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try{
			conn = getConnect();
			String query = "SELECT * FROM MEMBER WHERE ID = ? AND PASSWORD = ?";
			st = conn.prepareStatement(query);
			
			st.setString(1, vo.getId());
			st.setString(2, vo.getPassword());
			
			rs = st.executeQuery();
			
			if(rs.next()) {
				Member Mem = new Member(rs.getString("id"), rs.getString("password"), rs.getString("name"));
				
				return Mem;
			}
			
			return null;
			
			

		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			conn.setAutoCommit(true);
			closeAll(rs, st, conn);
		}
		
		
		return null;
	}

}
