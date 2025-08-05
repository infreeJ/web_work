package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {
	private static CommentDao dao;
	static {
		dao = new CommentDao();
	}
	
	private CommentDao() {};
	
	public static CommentDao getInstance() {
		return dao;
	}
	
	
	
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					UPDATE comments
					SET deleted = 'yes'
					WHERE num = ?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
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
	
	
	public boolean update(CommentDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					UPDATE comments
					SET content = ?
					WHERE num = ?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getNum());
			
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
	
	
	
	public List<CommentDto> selectList(int parentNum) {
		List<CommentDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT c.num, c.writer, c.targetWriter, c.content, c.deleted, c.groupNum, 
						   u.profileImage,
						   CASE
						     WHEN SYSDATE - c.createdAt < 1/1440 THEN '1분 전'
						     WHEN SYSDATE - c.createdAt < 10/1440 THEN '10분 전'
						     WHEN SYSDATE - c.createdAt < 365 THEN
						       TO_CHAR(TRUNC(SYSDATE - c.createdAt)) || '일 전'
						     WHEN SYSDATE - c.createdAt < 730 THEN '1년 전'
						     ELSE '2년 이상'
						   END AS createdAt,
						   (SELECT COUNT(*)
						   FROM comments
						   WHERE groupNum = c.num AND num != groupNum) AS replyCount
					FROM comments c
					INNER JOIN users u ON c.writer = u.userName
					WHERE c.parentNum=?
					ORDER BY c.groupNum ASC, c.num ASC	
				""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, parentNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentDto dto = new CommentDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTargetWriter(rs.getString("targetWriter"));
				dto.setContent(rs.getString("content"));
				dto.setDeleted(rs.getString("deleted"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setCreatedAt(rs.getString("createdAt"));
				dto.setProfileImage(rs.getString("profileImage"));
				dto.setReplyCount(rs.getInt("ReplyCount"));
				list.add(dto);
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
		return list;
	}
	
	
	
	public boolean insert(CommentDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO comments(num, writer, targetWriter, content, parentNum, groupNum)
					VALUES(?, ?, ?, ?, ?, ?)
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getTargetWriter());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getParentNum());
			pstmt.setInt(6, dto.getGroupNum());
			
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
	
	
	
	// 저장할 댓글의 글번호를 리턴해주는 메서드
	public int getSequence () {
		// 글 번호를 저장할 지역변수 선언
		int num = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT comments_seq.NEXTVAL AS num
					FROM DUAL
					""";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt("num");
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
		return num;
	}
}
