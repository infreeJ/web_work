<%@page import="db.NotificationDao"%>
<%@page import="db.UserDao"%>
<%@page import="db.UserDto"%>
<%@page import="db.NotificationDto"%>
<%@page import="db.CommentDto"%>
<%@page import="db.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    int parentNum = Integer.parseInt(request.getParameter("parentNum"));
    String targetWriter = request.getParameter("targetWriter");
    String content = request.getParameter("content");
    	
    String writer = (String)session.getAttribute("userName");
    
    	
    	// 저장할 댓글의 댓글 번호를 미리 얻어낸다.
    	int num = CommentDao.getInstance().getSequence();
    	CommentDto dto = new CommentDto();
    	dto.setNum(num);
    	dto.setWriter(writer);
    	dto.setTargetWriter(targetWriter);
    	dto.setContent(content);
    	dto.setParentNum(parentNum);
    	dto.setGroupNum(num);
    	
    	boolean isSuccess = CommentDao.getInstance().insert(dto);
    	
    	
    	// 댓글 작성이 성공했다면
    	if(isSuccess) {
    		NotificationDto notiDto = new NotificationDto();
    		UserDto userDto = null;
    		
    		// 알림을 받을 사용자의 id 가져오기
    		userDto = UserDao.getInstance().getByUserName(targetWriter);
    		long recipient_id = userDto.getNum();
    		notiDto.setRecipient_id(recipient_id);

    		// 알림을 보내는 사용자의 id 가져오기
    		userDto = UserDao.getInstance().getByUserName(writer);
    		long sender_id = userDto.getNum();
    		notiDto.setSender_id(sender_id);
    		
			// 댓글 폼에서 가져오는 파라미터 잘 활용해서 NotificationDto에 저장
    		notiDto.setType("comment");
    		notiDto.setTarget_type("board");
    		notiDto.setTarget_id(parentNum);
    		notiDto.setMessage(content);
    		
    		// 알림 생성 성공 여부 확인
    		boolean isNotiSuccess = NotificationDao.getInstance().commentInsert(notiDto);
    		if (isNotiSuccess) System.out.println("알림 생성 성공");
    	}
    	
    	
    	
    	// 리다이렉트 : 원래글 자세히 보기 페이지로 다시 요청을 하라고 응답
    	String cPath = request.getContextPath();
    	response.sendRedirect(cPath + "/board/view.jsp?num=" + parentNum);
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/save-comment.jsp</title>
</head>
<body>

</body>
</html>