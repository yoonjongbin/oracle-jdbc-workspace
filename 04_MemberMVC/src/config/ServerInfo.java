package config;

public interface ServerInfo {
	
	/*
	 * 디비 서버 정보의 상수 값으로 구성된 인터페이스
	 * */
	
	String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	String USER = "jdbc";
	String PASSWORD = "jdbc";
}
