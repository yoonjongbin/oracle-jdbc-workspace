package person;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;
import config.ServerInfo;

public class PersonTest implements ServerInfo {

	public static Properties p; 
	public static Connection conn;
	public static PreparedStatement st;
	
	public static void main(String[] args) {
		
		PersonTest pt = new PersonTest();
		
		try {
			
			p = new Properties();
			p.load(new FileInputStream("src/config/jdbc.properties"));
			
			
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("Driver Loading....!!");
			
			
			// 2. 디비 연결
			conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
			System.out.println("DB Connection...!!");
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		pt.addPerson("김강우", "서울");
//		pt.addPerson("고아라", "제주도");
//		pt.addPerson("강태주", "경기도");
//		
//		pt.searchAllPerson();
//		
//		pt.removePerson(3);	// 강태주 삭제
//		
//		pt.updatePerson(1, "제주도");
//		
//		pt.viewPerson(1);

	}
	
	
	
	// 변동적인 반복..... 비즈니스 로직.... DAO(Database Access Object)
	public void addPerson(String name, String address) {
		// 3. Statement 객체 생성 - INSERT
		
		String query = p.getProperty("jdbc.sql.insert");
		
		try {
			st =conn.prepareStatement(query);
			
			st.setString(1, name);
			st.setString(2, address);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 추가!!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void removePerson(int id) {
		// 3. Statement 객체 생성 - DELETE
		String query = p.getProperty("jdbc.sql.delete");
		try {
			st =conn.prepareStatement(query);
			
			st.setInt(1, id);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 삭제!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void updatePerson(int id, String address) {
		// 3. Statement 객체 생성 - UPDATE
		
				String query = p.getProperty("jdbc.sql.update");
				
				try {
					st =conn.prepareStatement(query);
					
					st.setString(1, address);
					st.setInt(2, id);
					
					int result = st.executeUpdate();
					System.out.println(result + "명 업데이트!!");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
	}
	
	public void searchAllPerson() {
		// 3. Statement 객체 생성 - SELECTALL
		
				String query = p.getProperty("jdbc.sql.selectall");
				
				try {
					st =conn.prepareStatement(query);
					
					ResultSet rs =st.executeQuery();
					
					while(rs.next()) {
						int Id = rs.getInt("ID");
						String Name = rs.getString("NAME");
						String Address = rs.getString("ADDRESS");
						
						
						System.out.print(Id + "/" + Name + "/" + Address + "\n");
						
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	}
	
	public void viewPerson(int id) {
		// 3. Statement 객체 생성 - SELECT
		
				String query = p.getProperty("jdbc.sql.select");
				
				try {
					st =conn.prepareStatement(query);
					
					st.setInt(1, id);
					
					ResultSet rs =st.executeQuery();
					
					while(rs.next()) {
						int Id = rs.getInt("ID");
						String Name = rs.getString("NAME");
						String Address = rs.getString("ADDRESS");
						
						
						System.out.print(Id + "/" + Name + "/" + Address + "\n");
						
					}
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	}

}
