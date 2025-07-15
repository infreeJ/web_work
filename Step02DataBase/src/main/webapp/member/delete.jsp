<%@page import="db.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num = Integer.parseInt(request.getParameter("num"));
	MemberDao dao = new MemberDao();
	dao.delete(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/delete.jsp</title>
</head>
<body>


	<script>
		alert("삭제 완료")
		location.href="${pageContext.request.contextPath}/member/list.jsp";
	</script>
</body>
</html>