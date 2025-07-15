<%@page import="db.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="db.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<BookDto> list = new BookDao().selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/book/list.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
</head>
<body>
<jsp:include page="/WEB-INF/include/navbar.jsp">
	<jsp:param name="thisPage" value="book"/>
</jsp:include>
	<h1>책 목록</h1>
	<p><a href="${pageContext.request.contextPath}/book/insertform.jsp">책 추가하기</a></p>
	<table class="table table-striped">
	<thead class="table-dark">
		<tr>
			<td>도서번호</td>
			<td>제목</td>
			<td>작가</td>
			<td>출판사</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
	</thead>
	<%
	for(BookDto tmp : list) {%>
		<tr>
			<td><%=tmp.getNum()%></td>
			<td><%=tmp.getTitle()%></td>
			<td><%=tmp.getAuthor()%></td>
			<td><%=tmp.getPublisher()%></td>
			<td><a href="${pageContext.request.contextPath}/book/updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
			<td><a href="${pageContext.request.contextPath}/book/delete.jsp?num=<%=tmp.getNum()%>">삭제</a></td>
		</tr>
	<%}%>
	
	
	</table>

</body>
</html>