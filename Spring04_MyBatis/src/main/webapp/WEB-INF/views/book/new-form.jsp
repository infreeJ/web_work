<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/book/insertForm</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/book/save" method="post">
		<label for="title">제목</label>
		<input type="text" name="title"/>
		<br />
		<label for="author">작가</label>
		<input type="text" name="author"/>
		<br />
		<label for="publisher">출판사</label>
		<input type="text" name="publisher"/>
		<br />
		<button type="submit">수정</button>
		<button type="reset">취소</button>
	</form>
</body>
</html>
