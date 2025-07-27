package db;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class NotificationDao {
	private static NotificationDao dao;
	static {
		dao = new NotificationDao();
	}
	
	private NotificationDao() {}
	
	public static NotificationDao getInstance() {
		return dao;
	}
	
	
	
	
	public boolean commentInsert(NotificationDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO notification(num, recipient_id, sender_id, type, target_type, target_id, message)
					VALUES(notification_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, dto.getRecipient_id());
			pstmt.setLong(2, dto.getSender_id());
			pstmt.setString(3, dto.getType());
			pstmt.setString(4, dto.getTarget_type());
			pstmt.setInt(5, dto.getTarget_id());
			pstmt.setString(6, dto.getMessage());
			
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
}
