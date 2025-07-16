<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="db.UserDto"%>
<%@page import="db.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	// 폼 전송되는 아이디와 비밀번호 추출하기
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	
	boolean isValid = false;
	// DB에서 userName을 이용해서 select 되는 정보가 있는지 select 해본다.
	UserDto dto = new UserDao().getByUserName(userName);
	
	// select된 정보가 있다면(userName이 존재한다는 것)
	if(dto != null) {
		// raw 비밀번호와 DB에 저장된 비밀번호를 비교해서 일치하는지 확인한다.
		isValid = BCrypt.checkpw(password, dto.getPassword());
	}
	
	// 입력한 아이디와 비밀번호가 유효한 정보라면 로그인 처리한다.
	// jsp에서 기본 제공해주는 HttpSession 객체에 userName을 저장
	// HttpSession 객체에 저장하면 응답을 한 이후에 다음번 요청에서
	// HttpSession 객체에 저장된 정보를 읽어올 수 있다.
	// 세선 객체에 담긴 정보는 어떤 요청도 하지 않고 일정 시간이 흐르면 자동 삭제된다.
	// 필요하다면(로그아웃 요청되면) 강제로 세션 객체에 담긴 정보를 삭제할 수도 있다.
	// 세션 객체에 로그인 정보를 저장하는 것이 '로그인'
	// 세션 객체에 담긴 로그인 정보를 삭제하는 것이 '로그아웃'
	
	if(isValid) {
		// HttpSession 객체에 "userName" 이라는 키값으로 userName을 저장한다.
		session.setAttribute("userName", userName);
		// 세션 유지시간 설정(초단위)
		session.setMaxInactiveInterval(60*10); // default 30분
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/login.jsp</title>
</head>
<body>
	<div class="container">
		<%
		if(isValid) {%>
			<p>
				<strong><%=userName %></strong> 회원님 환영합니다.
				<a href="${pageContext.request.contextPath}/">인덱스 페이지로</a>
			</p>
		<%} else {%>
			<p>
				아이디 혹은 비밀번호를 확인해주세요
				<a href="loginform.jsp">다시 로그인</a>
			</p>
		<%}%>
	</div>
</body>
</html>














