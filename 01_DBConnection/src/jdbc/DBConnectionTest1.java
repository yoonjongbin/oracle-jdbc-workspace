package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class DBConnectionTest1 {

	/*
	 * JDBC(Java Database Connectivity)
	 * 
	 * - 자바에서 표준화된 방법으로 다양한 데이터베이스에 접속할 수 있도록
	 * 	 설계된 인터페이스
	 * 
	 * */
	
	public static void main(String[] args) {
		// JDBC 작업 4단계
		
		// 1. 드라이버를 로딩
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading....!!");
			
			// 2. 데이터베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "kh", "kh");
			System.out.println("DB Connection...!!");
			
			// 3. Statement 객체 생성 -- SELECT
			String query = "SELECT * FROM EMPLOYEE";
			PreparedStatement st = conn.prepareStatement(query);
			
			// 4. 쿼리문 실행
			ResultSet rs =st.executeQuery();
			
			while(rs.next()) {
				String empId = rs.getString("emp_id");
				String empName = rs.getString("emp_Name");
				String deptCode = rs.getString("dept_code");
				String jobCode = rs.getString("job_code");
				int salary = rs.getInt("salary");
				float bonus = rs.getFloat("bonus");
				Date hireDate = rs.getDate("hire_Date");
				char entYn = rs.getString("ent_yn").charAt(0);
				
				
				System.out.print(empId + "/" + empName + "/" + deptCode + "/" + jobCode + "/" + salary + "/" + bonus + "/" + hireDate + "/" + entYn + "\n");
				
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
		
		
		
	}

}
