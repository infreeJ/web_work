<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// request 객체의 특정 key값으로 담긴 정보 추출
	String orgFileName = (String)request.getAttribute("orgFileName");
	String saveFileName = (String)request.getAttribute("saveFileName");
	long fileSize = (long)request.getAttribute("fileSize");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/윤제.jsp</title>
</head>
<body>
	<div class="container">
		<p>윤제가 응답합니다</p>
		<p>원본 파일명 : <%=orgFileName %></p>
		<p>저장된 파일명 : <%=saveFileName %></p>
		<p>파일 크기 : <%=fileSize %></p>
		
		<%-- EL을 이용하면 casting 없이 바로 추출할 수도 있다 --%>
		<p>원본 파일명 : ${requestScope.orgFileName }</p>
		<p>저장된 파일명 : ${requestScope.saveFileName }</p>
		<%-- requestScope. 생략가능 --%>
		<p>파일 크기 : ${fileSize }</p>
		
		
		<a href="${pageContext.request.contextPath}/test/download?orgFileName=${orgFileName}&saveFileName=${saveFileName}&fileSize=${fileSize}">다운로드</a>
	</div>
</body>
</html>