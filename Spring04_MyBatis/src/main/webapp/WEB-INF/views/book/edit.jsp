<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/book/updateForm</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/book/update" method="post">
		<input type="hidden" name="num" value="${dto.num }"/>
		<label for="title"></label>
		<input type="text" name="title" value="${dto.title }"/>
		<br />
		<label for="author"></label>
		<input type="text" name="author" value="${dto.author }"/>
		<br />
		<label for="publisher"></label>
		<input type="text" name="publisher" value="${dto.publisher }"/>
		<br />
		<button type="submit">수정</button>
		<button type="reset">취소</button>
	</form>
</body>
</html>
