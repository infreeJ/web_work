<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/edit-password.jsp</title>
</head>
<body>
	<div class="container">
		<h1>비밀번호 수정 양식</h1>
		<form action="update-password.jsp" method="post" id="editForm">
			<div>
				<label for="password">기존 비밀번호</label>
				<input type="password" name="password" id="password"/>
			</div>
			<div>
				<label for="newPassword">새 비밀번호</label>
				<input type="password" name="newPassword" id="newPassword"/>
			</div>
			<div>
				<label for="newPassword2">새 비밀번호 확인</label>
				<input type="password" id="newPassword2"/>
			</div>
			<button type="submit">수정하기</button>
		</form>
	</div>
	
	<script>
		// id가 editForm인 요소에 "submit" 이벤트가 일어났을 때 실행할 함수 등록
		// form 안에 있는 submit 버튼을 누르면 해당 form에는 "submit" 이벤트가 발생한다.
		document.querySelector("#editForm").addEventListener("submit", (e) => {
			/*
				여기서 해야할 일
				- 폼에 입력한 내용의 유효성을 검증한다.
				- 검증해서 유효하다면 관여하지 않는다.
				- 유효하지 않다면 e.preventDefault();를 실행해서 폼 제출을 막아준다.
			*/
			const pwd = document.querySelector("#password").value;
			const newPwd = document.querySelector("#newPassword").value;
			const newPwd2 = document.querySelector("#newPassword2").value;
			
			if(pwd.trim() == "") {
				alert("기존 비밀번호를 입력하세요")
				e.preventDefault();
			} else if(newPwd.trim() == "") {
				alert("새 비밀번호를 입력하세요")
				e.preventDefault();
			} else if(newPwd.trim() != newPwd2.trim()) {
				alert("새 비밀번호가 일치하지 않습니다.")
				e.preventDefault();
			}
				
		})
	</script>
</body>
</html>









