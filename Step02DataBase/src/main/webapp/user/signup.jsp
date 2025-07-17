<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="db.UserDto"%>
<%@page import="db.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	// 폼 전송되는 정보를 추출한다
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	
	// 사용자가 입력한 비밀번호로 암호화한 비밀번호를 얻어낸다.
	String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
	System.out.println("암호화된 비밀번호 : " + hashed);
	
	// dto에 담아서 DB에 저장하고
	UserDto dto = new UserDto();
	dto.setUserName(userName);
	dto.setPassword(hashed);
	dto.setEmail(email);
	
	// 응답
	boolean isSuccess = UserDao.getInstance().insert(dto);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/signup.jsp</title>
</head>
<body>
	<div class="container">
		<%
		if(isSuccess) {%>
			<p><strong><%=userName %></strong></p>님 회원가입 되었습니다
			<a href="loginform.jsp">로그인 하러가기</a>
		<%} else {%>
			가입 실패
			<a href="signup-form">다시 가입</a>
		<%}%>
		
	</div>
</body>
</html>























