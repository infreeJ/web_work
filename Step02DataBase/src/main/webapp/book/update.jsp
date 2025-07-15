<%@page import="db.BookDao"%>
<%@page import="db.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String author = request.getParameter("author");
	String publisher = request.getParameter("publisher");
	
	BookDto dto = new BookDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setAuthor(author);
	dto.setPublisher(publisher);
	
	boolean isSuccess = new BookDao().update(dto);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>book/update.jsp</title>
</head>
<body>
	<%
	if(isSuccess) {%>
		<p>수정 성공</p>
		<p><a href="${pageContext.request.contextPath}/book/list.jsp">확인</a></p>
	<%} else {%>
		<p>수정 실패</p>
		<p><a href="${pageContext.request.contextPath}/book/updateform.jsp?num=<%=num%>">다시 수정하기</a></p>
	<%}%>
	
	<script>
	<%if(isSuccess) {%>
		alert("성공적으로 변경됐습니다.")
		location.href = "${pageContext.request.contextPath}/book/list.jsp"
	<%} else {%>
		alert("수정 실패")
		location.href = "${pageContext.request.contextPath}/book/updateform.jsp?num=<%=num%>"
	<%}%>
	</script>
</body>
</html>







