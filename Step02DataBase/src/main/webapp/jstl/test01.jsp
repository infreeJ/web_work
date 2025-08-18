<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	// 이 부분은 Servlet이라고 가정
	// 테스트를 위해 sample 데이터를 request scope에 담는다.
	List<String> names = new ArrayList<>();
	names.add("김구라");
	names.add("해골");
	names.add("원숭이");
	// "list" 라는 키값으로 request scope에 ArrayList 객체 담아두기
	request.setAttribute("list", names);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl/test01.jsp</title>
</head>
<body>
	<h1>스크립틀릿을 활용하여 목록 출력</h1>
	<%
	// request scope에 "list" 라는 키값으로 저장된 친구 목록 얻어내기
	List<String> list = (List<String>)request.getAttribute("list");
	%>
	
	<ul>
		<%for(String tmp : list) { %>
		<li><%=tmp %></li>
		<%} %>
	</ul>
	
	<!-- ------------------- -->
	
	<h1>El과 JSTL을 활용해서 위와 동일한 동작</h1>
	<ul>
		<c:forEach var="tmp" items="${list }" varStatus="status">
			<li>${tmp } <strong>순서 : ${status.count }</strong></li>
		</c:forEach>
	</ul>
	
	<!-- ------------------- -->
	
	<h1>목록 첫 번째 순서인지 여부</h1>
	<ul>
		<c:forEach var="tmp" items="${list }" varStatus="status">
			<li>${tmp } <strong>첫 번째 : ${status.first }</strong>
				<c:if test="${status.first }">
					제일 잘생긴 친구
				</c:if>
			</li>
		</c:forEach>
	</ul>
	
	<!-- ------------------- -->
	
	<h1>목록 마지막 순서인지 여부</h1>
	<ul>
		<c:forEach var="tmp" items="${list }" varStatus="status">
			<li>${tmp } <strong>첫 번째 : ${status.last }</strong></li>
		</c:forEach>
	</ul>
</body>
</html>





