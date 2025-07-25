<%@page import="db.CommentDto"%>
<%@page import="db.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 폼 전송되는 수정할 정보를 얻어온다
	int num = Integer.parseInt(request.getParameter("num"));
	String content = request.getParameter("content");
	
	// 원글의 글번호
	int parentNum = Integer.parseInt(request.getParameter("parentNum"));
	
	CommentDto dto = new CommentDto();
	dto.setNum(num);
	dto.setContent(content);
	
	boolean isSccess = CommentDao.getInstance().update(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/comment-update.jsp</title>
</head>
<body>


	<script>
		<%if(isSccess) {%>
			alert("수정했습니다.")
			location.href="${pageContext.request.contextPath}/board/view.jsp?num=<%=parentNum%>"
		<%} else {%>
			alert("수정 실패")
			location.href="${pageContext.request.contextPath}/board/view.jsp?num=<%=parentNum%>"
		<%}%>
	</script>
</body>
</html>












