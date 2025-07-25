<%@page import="db.CommentDao"%>
<%@page import="db.CommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 삭제할 댓글 번호
	int num = Integer.parseInt(request.getParameter("num"));
	
	// 리다이렉트 이동에 필요한 글번호
	int parentNum = Integer.parseInt(request.getParameter("parentNum"));

	
	CommentDao.getInstance().delete(num);
	
	
	// 삭제 후 리다이렉트 이동
	String cPath = request.getContextPath();
	response.sendRedirect(cPath + "/board/view.jsp?num=" + parentNum);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/comment-delete.jsp</title>
</head>
<body>

</body>
</html>