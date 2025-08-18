<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/book/list.jsp</title>
</head>
<body>
	<a href="${pageContext.request.contextPath}/book/new-form">책 등록하기</a>
	<br />
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작가</th>
			<th>출판사</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="tmp" items="${list }">
			<tr>
				<td>${tmp.num }</td>
				<td>${tmp.title }</td>
				<td>${tmp.author }</td>
				<td>${tmp.publisher }</td>
				<td><a href="${pageContext.request.contextPath}/book/edit?num=${tmp.num }">수정</a></td>
				<td><a href="${pageContext.request.contextPath}/book/delete?num=${tmp.num }">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
