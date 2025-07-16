<%@page import="db.UserDto"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="db.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 1. 폼 전송되는 기존 비밀번호와 새 비밀번호를 읽어온다.
	String password = request.getParameter("password");
	String newPassword = request.getParameter("newPassword");
	
	// 2. 세션에 저장된 userName을 이용해서 가입정보를 DB에서 불러온다
	String userName = (String)session.getAttribute("userName");
	UserDto dto = new UserDao().getByUserName(userName);
	
	// 3. 기존 비밀번호와 DB에 저장된 비밀번호가 일치하는지 확인해서
	boolean isValid = BCrypt.checkpw(password, dto.getPassword());
	
	// 4. 일치한다면 새 비밀번호를 DB에 수정 반영하고 로그아웃한다.
	if(isValid) {
		// 새 비밀번호를 암호화
		String encodedPwd = BCrypt.hashpw(newPassword, BCrypt.gensalt());
		// dto에 담고
		dto.setPassword(encodedPwd);
		// DB에 수정반영
		new UserDao().updatePassword(dto);
		
		// 로그아웃
		session.removeAttribute("userName");
	}
	
	// 5. 일치하지 않는다면 에러정보를 응답하고 다시 입력할 수 있도록 한다.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/update-password.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isValid) {%>
			<p>
				<strong><%=userName %>님의 비밀번호가 수정되고 로그아웃 되었습니다.</strong>
				<a href="loginform.jsp?url=${pageContext.request.contextPath}/user/info.jsp">다시 로그인</a>
			</p>
		<%} else { %>
			<p>
				기존 비밀번호가 일치하지 않습니다. 다시 입력해주세요
				<a href="edit-password.jsp">확인</a>
			</p>
		<%} %>
		
	</div>
</body>
</html>













