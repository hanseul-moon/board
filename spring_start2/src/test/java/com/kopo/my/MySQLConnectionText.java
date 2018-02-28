
import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.*;

public class MySQLConnectionText {
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://192.168.23.95:33060/kopoctc";	//localhost�� 127.0.0.1 �� ���� ������ �ȵȴ�. mysql�� ����ӽ� ���ο� �ֱ� ������...
	private static final String USER = "root";
	private static final String PW = "kopoctc10";
	
	@Test
	public void testConnection() throws Exception{
		Class.forName(DRIVER);
		try(Connection con = DriverManager.getConnection(URL, USER, PW)){			
			System.out.println(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
