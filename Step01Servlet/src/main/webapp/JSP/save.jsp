<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 1. form 전송되는 숫자를 읽어와서 실제로 정수로 만들어준다.
	// 2. 해당 숫자가 짝수이면 "전송한 숫자 x는 짝수입니다."
	//    해당 숫자가 홀수이면 "전송한 숫자 x는 홀수입니다."
	//    를 콘솔창이 아닌 클라이언트 웹브라우저에 출력하기

	int num = Integer.parseInt(request.getParameter("inputNum"));

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jsp/save.jsp</title>
</head>
<body>
	<h3>if else문 이용</h3>
	<%
	if(num % 2 == 0) {%>
		<p>전송한 숫자 <%=num%>는 짝수입니다.</p>
	<%} else {%>
		<p>전송한 숫자 <%=num%>는 홀수입니다.</p>
	<%}%>
	
	<h3>3항 연산자 이용</h3>
	<%String result = num % 2 == 0 ? "짝수" : "홀수";%>
	<p>전송한 숫자 <%=num%>는 <%=result%>입니다.</p>
	
</body>
</html>










