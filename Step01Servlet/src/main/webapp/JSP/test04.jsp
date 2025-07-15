<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// context path를 HttpServletRequest 객체의 메서드를 이용해서 얻어내기
	String contextPath = request.getContextPath();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test04.jsp</title>
</head>
<body>
	<h1>Context Path 얻어내서 사용하기</h1>
	<a href="/Step01Servlet/index.html">인덱스</a><br />
	<a href="<%=contextPath%>/index.html">인덱스</a>
	<h1>Expression Language를 활용</h1>
	<a href="${pageContext.request.contextPath}/index.html">인덱스</a>
	<img src="${pageContext.request.contextPath}/images/Spain.png">
	
	<script>
		function printMsg(msg) {
			const result = `매개변수에 전달된 내용 : ${msg}`
			console.log("result")
		}
	</script>
</body>
</html>








