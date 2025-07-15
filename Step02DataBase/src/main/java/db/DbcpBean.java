package db;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DbcpBean {
	public Connection getConn() { // Connection 객체를 리턴하는 메서드
		Connection conn=null;
		try {
			//Tomcat 서버가 관리하는 Connection 객체를 지역변수에 저장
			Context initContext = new InitialContext();
			//Servers/context.xml 문서에 설정된 jdbc/myoracle 이름의 datasource 를 얻어온다.
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			//얻어온 datasource 객체를 이용해서 Connection 객체의 참조값을 지역변수에 저장
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			conn = ds.getConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
