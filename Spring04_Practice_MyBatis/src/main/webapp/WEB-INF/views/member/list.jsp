<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/list.jsp</title>
</head>
<body>
	<ul>
		<c:forEach var="tmp" items="${list }">
			<li>${tmp.num} || ${tmp.name } || ${tmp.addr }
			<a href="/member/updateForm?num=${tmp.num }">수정</a>
			<a href="/member/deleteByNum?num=${tmp.num }">삭제</a>
			</li>
		</c:forEach>
	</ul>
	<a href="${pageContext.request.contextPath}/">메인으로</a>

</body>
</html>