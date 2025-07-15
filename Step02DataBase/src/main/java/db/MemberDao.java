package db;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.util.DbcpBean;

public class MemberDao {
	public List<MemberDto> select() {
		List<MemberDto> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT num, name, addr
					FROM member
					""";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDto dto = new MemberDto();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				list.add(dto);
			}
			
		} catch (Exception e) {
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
		return list;
	}
	
	
	public MemberDto getByNum(int num) { // 1개의 인자를 받는 메서드
		
		MemberDto dto = null; // 회원 정보를 담을 변수 선언
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DBConnector().getConn();
			String sql = """
					SELECT name, addr
					FROM member
					WHERE num = ?
					""";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num); // 받은 인자를 바인딩

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto = new MemberDto(); // dto 변수에 객체를 넣고
				dto.setNum(num);
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr")); // 데이터 삽입
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto; // 회원 정보 리턴
	}
	
	
	public boolean insert(MemberDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = "INSERT INTO member(num, name, addr) VALUES(member_seq.NEXTVAL, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getAddr());
			
			
			rowCount = pstmt.executeUpdate();
			
			if (rowCount > 0) {
				System.out.println(rowCount+"개 작업 성공");
			} else {
				System.out.println("작업 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public boolean delete(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = "DELETE FROM member WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			
			rowCount = pstmt.executeUpdate();
			
			if (rowCount > 0) {
				System.out.println(rowCount+"개 작업 성공");
			} else {
				System.out.println("작업 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean update(MemberDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = "UPDATE member SET name=?, addr=? WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getAddr());
			pstmt.setInt(3, dto.getNum());
			
			
			rowCount = pstmt.executeUpdate();
			
			if (rowCount > 0) {
				System.out.println(rowCount+"개 작업 성공");
			} else {
				System.out.println("작업 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
}
