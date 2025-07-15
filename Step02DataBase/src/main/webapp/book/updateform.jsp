<%@page import="db.BookDto"%>
<%@page import="db.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BookDto dto = new BookDao().select(num);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="${pageContext.request.contextPath}/book/update.jsp">
			<label for="num"></label>
				<input type="text" name="num" id="num" value=<%=dto.getNum()%> readonly="readonly">
			<br/>
			<label for="title"></label>
				<input type="text" name="title" id="title" value=<%=dto.getTitle()%>>
			<br/>
			<label for="author"></label>
				<input type="text" name="author" id="author" value=<%=dto.getAuthor()%>>
			<br/>
			<label for="publisher"></label>
				<input type="text" name="publisher" id="publisher" value=<%=dto.getPublisher()%>>
			<br/>
			<button type="submit">제출</button>
		</form>
	</div>
</body>
</html>