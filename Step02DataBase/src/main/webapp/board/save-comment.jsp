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