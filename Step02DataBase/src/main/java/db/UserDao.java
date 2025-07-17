package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class UserDao {
	
	private static UserDao dao;
	
	// static 초기화 블럭 (클래스가 최초로 사용될 때 한번 실행되는 블럭
	static {
		// static 초기화 작업을 여기서 한다 (UserDao 객체를 생성해서 static 필드에 담는다)
		dao = new UserDao();
	}
	
	// 외부에서 UserDao 객체를 생성하지 못하도록 생성자를 private로 막는다.
	private UserDao () {}
	
	// UserDao 객체의 참조값을 리턴해주는 public static 메서드
	public static UserDao getInstance() {
		// static 필드에 저장된 dao의 참조값을 리턴
		return dao;
	}
	
	// 이메일과 프로필을 수정하는 메서드
	public boolean updateEmailProfile(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					UPDATE users
					SET email=?, profileImage=?, updatedAt=SYSDATE
					WHERE userName = ?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getProfileImage());
			pstmt.setString(3, dto.getUserName());
			
			rowCount = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 이메일을 수정하는 메서드
	public boolean updateEmail(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					UPDATE users
					SET email=?, updatedAt=SYSDATE
					WHERE userName = ?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getUserName());
			
			rowCount = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 비밀번호 수정 반영하는 메서드
	public boolean updatePassword(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					UPDATE users
					SET password = ?, UPDATEDAT = SYSDATE
					WHERE userName = ?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPassword());
			pstmt.setString(2, dto.getUserName());
			
			rowCount = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public boolean insert(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO users(num, userName, password, email, updatedAt, createdAt)
					VALUES(users_seq.NEXTVAL, ?, ?, ?, SYSDATE, SYSDATE)
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserName());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getEmail());
			
			rowCount = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public UserDto getByUserName(String userName) {
		UserDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT num, password, email, profileImage, role, updatedAt, createdAt
					FROM users
					WHERE userName = ?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDto();
				dto.setNum(rs.getLong("num"));
				dto.setUserName(userName);
				dto.setPassword(rs.getString("password"));
				dto.setEmail(rs.getString("email"));
				dto.setProfileImage(rs.getString("profileImage"));
				dto.setRole(rs.getString("role"));
				dto.setUpdatedAt(rs.getString("updatedAt"));
				dto.setCreatedAt(rs.getString("createdAt"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
}

