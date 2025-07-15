<%@page import="db.MemberDao"%>
<%@page import="db.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	
	MemberDto dto = new MemberDto();
	dto.setNum(num);
	dto.setName(name);
	dto.setAddr(addr);
	MemberDao dao = new MemberDao();
	boolean success = dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/update.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
	<div class="container">
		<%
		if (success) {%>
			<p class="alert alert-success mt-5"><i class="bi bi-check-circle-fill"></i>수정 성공</p>
			<a class="alert-link" href="${pageContext.request.contextPath}/member/list.jsp">확인</a>
		<%} else {%>
			<p class="alert alert-danger mt-5"><i class="bi bi-x-circle-fill"></i> 수정 실패</p>
			<a class="alert-link" href="${pageContext.request.contextPath}/member/updateform.jsp?num=<%=num%>">다시 수정하기</a>
		<%}%>
	</div>
	
</body>
</html>