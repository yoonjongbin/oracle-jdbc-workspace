package transaction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.ServerInfo;

public class TransactionTest2 {

	public static void main(String[] args) {
		

		try {
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			
			// 2. 데이터베이스 연결
			
			Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
			conn.setAutoCommit(false);
			String query = "SELECT * FROM bank";
			
			PreparedStatement st = conn.prepareStatement(query);
			ResultSet rs = st.executeQuery();
			
			System.out.println("================== 은행조회 ==================");
			while(rs.next()) {
				System.out.println(rs.getString("name") + " / " + rs.getString("bankname") + " / " + rs.getInt("balance"));
			}
			
			System.out.println("=============================================");
		
			/*
			 * 민소 -> 도경 : 50만원씩 이체
			 * 이 관련 모든 쿼리를 하나로 묶는다.. 하나의 단일 트랙잭션
			 * setAutocommit(), commit(), rollback().. 등등
			 * 사용을 해서 민소님의 잔액이 마이너스가 되면 취소!
			 * 
			 * */
			
			String query2 = "UPDATE BANK SET BALANCE = BALANCE - ? WHERE NAME = ?";
			PreparedStatement st2 = conn.prepareStatement(query2);
			st2.setInt(1, 500000);
			st2.setString(2, "김민소");
			String query3 = "UPDATE BANK SET BALANCE = BALANCE + ? WHERE NAME = ?";
			PreparedStatement st3 = conn.prepareStatement(query3);
			st3.setInt(1, 500000);
			st3.setString(2, "김도경");
			int result2 = st2.executeUpdate();
			int result3 = st3.executeUpdate();
			
			String query4 = "SELECT BALANCE FROM BANK WHERE NAME = '김민소'";
			PreparedStatement st4 = conn.prepareStatement(query4);
			ResultSet rs4 = st4.executeQuery();
	           if(rs4.next()) {
	        	   if(rs4.getInt("balance") < 0) {
	   				conn.rollback();
	   				System.out.println("민소 돈없다");
	   			}else {
	   				conn.commit();
	   				System.out.println("민소 돈 있다");
	   			}
	           }
			
		
		
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
