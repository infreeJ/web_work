<%@page import="db.MemberDao"%>
<%@page import="db.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	MemberDto dto = new MemberDto();
	dto.setName(request.getParameter("name"));
	dto.setAddr(request.getParameter("addr"));
	MemberDao dao = new MemberDao();
	boolean success = dao.insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/insert.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
	<div class="container">
		<% if (success) {%>
			<p class="alert alert-success mt-5"><i class="bi bi-check-circle-fill"></i> <%=dto.getName() + "님의 정보를 성공적으로 저장했습니다." %></p>
			<a class="alert-link" href="${pageContext.request.contextPath}/member/list.jsp">확인</a>
		<%} else {%>
			<p class="alert alert-danger mt-5"><i class="bi bi-x-circle-fill"></i> 정보 저장에 실패했습니다.</p>
			<a class="alert-link" href="${pageContext.request.contextPath}/member/insertform.jsp">다시 입력하기</a>
		<%}%>
	</div>
	
</body>
</html>