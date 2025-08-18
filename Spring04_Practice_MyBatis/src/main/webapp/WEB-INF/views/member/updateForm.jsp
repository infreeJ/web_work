<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/updateForm</title>
</head>
<body>
	<form action="/member/update" method="POST">
		<input type="text" name="num" value="${param.num } " readOnly/>
		<input type="text" name="name" placeholder="이름을 입력하세요"/>
		<input type="text" name="addr" placeholder="주소를 입력하세요"/>
		<button type="submit">저장</button>
	</form>
</body>
</html>