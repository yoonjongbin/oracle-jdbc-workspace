package jdbc;

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

public class DB_ConnectionTest4 implements ServerInfo {

		
		public static void main(String[] args) {
			
			try {
				
				Properties p = new Properties();
				p.load(new FileInputStream("src/config/jdbc.properties"));
				
				
				// 1. 드라이버 로딩
				Class.forName(ServerInfo.DRIVER_NAME);
				System.out.println("Driver Loading....!!");
				
				
				// 2. 디비 연결
				Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
				System.out.println("DB Connection...!!");
				
				
				// 3. Statement 객체 생성 - DELETE
				String query = p.getProperty("jdbc.sql.delete");
				PreparedStatement st =conn.prepareStatement(query);
				
				// 4. 쿼리문 실행
				
				st.setInt(1, 2);
				
				int result = st.executeUpdate();
				System.out.println(result + "명 삭제!");
				
				// 결과가 잘 나오는지 확인 - SELECT
				query = p.getProperty("jdbc.sql.select");
				st =conn.prepareStatement(query);
				
				ResultSet rs =st.executeQuery();
				
				while(rs.next()) {
					int empId = rs.getInt("emp_id");
					String empName = rs.getString("emp_Name");
					String deptTitle = rs.getString("dept_Title");
					Date hireDate = rs.getDate("hire_Date");
					
					
					System.out.print(empId + "/" + empName + "/" + deptTitle + "/" + hireDate + "\n");
					
				}
				
				
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
	}

}
