<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jstl/test02.jsp</title>
</head>
<body>
	<c:if test="true">
		<p>test가 true라면</p>
	</c:if>
	<c:if test="false">
		<p>test가 false라면</p>
	</c:if>
	<c:if test="${10%2 == 0 }">
		<p>10은 짝수입니다.</p>
	</c:if>
	<c:if test="${10%2 eq 0 }">
		<p>10은 짝수입니다.</p>
	</c:if>
	<c:if test="${20 > 10 }">
		<p>20은 10보다 크다.</p>
	</c:if>
	<c:if test="${20 gt 10 }">
		<p>20은 10보다 크다.</p>
	</c:if>
	<c:if test="${10 != 20 }">
		<p>10과 20은 다르다 ${10 ne 20 }</p>
	</c:if>
</body>
</html>
