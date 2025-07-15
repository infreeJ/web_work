<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 여기는 Java coding 영역입니다.
	// servlet의 service() 메서드 안쪽 영역이라고 생각하면 된다.
	
	String uri = request.getRequestURI();
	
	// 입력할 이름 추출
	String name = request.getParameter("name");
	// 입력할 메시지 추출
	String msg = request.getParameter("msg");
	// 콘솔창에 출력해보기
	System.out.println(uri + name + " : " + msg);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/send.jsp</title>
</head>
<body>
	<h1>JSP 페이지에서 응답</h1>
	<p>보낸 사람의 이름 : <%=name%></p>
	<p>보낸 내용 : <%=msg %></p>
</body>
</html>