<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	// session.removeAttribute("userName");
	// session.removeAttribute("role");
	session.invalidate(); // 저장된 모든 정보 삭제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("로그아웃 완료");
		location.href = "${pageContext.request.contextPath}/"
	</script>
</body>
</html>
