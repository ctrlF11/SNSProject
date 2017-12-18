package org.zerock.web;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySQLConnectionTest {
	private static final String Driver = 
			// mysql driver 5
			// "com.mysql.jdbc.Driver";
			// mysql driver 6
			"com.mysql.cj.jdbc.Driver";
	private static final String Url = 
			"jdbc:mysql://ctrlf11.cqfwljmig7zs.ap-northeast-2.rds.amazonaws.com/ctrlf11?useSSL=false&serverTimezone=UTC";
	private static final String User = 
			"BaeNuri";
	private static final String Pw = 
			"clftjdtkdlek77!";
	@Test
	public void testConnection() throws Exception {
		Class.forName(Driver);
		try(Connection conn = DriverManager.getConnection(Url, User, Pw)) {
				System.out.println(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
