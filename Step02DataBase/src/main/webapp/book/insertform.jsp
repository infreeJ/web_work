<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/book/insertform</title>
</head>
<body>
	<div>
		<h1>책 등록 양식</h1>
		<form action="${pageContext.request.contextPath}/book/insert.jsp">
			<label for="title">책 이름</label>
				<input type="text" name="title" id="title" placeholder="책 이름을 입력해주세요"/>
			<br/>
			<label for="author">작가</label>
				<input type="text" name="author" id="author" placeholder="작가를 입력해주세요"/>
			<br/>
			<label for="publisher">출판사</label>
				<input type="text" name="publisher" id="publisher" placeholder="출판사를 입력해주세요"/>
			
			<br/>
			<button type="submit">제출</button>
		</form>
	</div>
</body>
</html>
