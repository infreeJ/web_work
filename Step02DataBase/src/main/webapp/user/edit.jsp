<%@page import="db.UserDao"%>
<%@page import="db.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String userName = (String)session.getAttribute("userName");
	UserDto dto = new UserDao().getByUserName(userName);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/edit.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<h1>가입정보 수정</h1>
		<%--
			input type="file"이 있는 from의 전송방식은 다르다.
			따라서 enctype="multipart/form-data" 속성을 form에 추가해둔다.
			서버에서 해당 요청을 처리하는 방법도 다르기 때문에 jsp가 아닌 서블릿에서 처리하자
		 --%>
		<form action="${pageContext.request.contextPath}/user/update" method="post" enctype="multipart/form-data">
			<div>
				<label for="userName">아이디</label>
				<input type="text" name="userName" value="<%=dto.getUserName() %>" readOnly/>
			</div>
			<div>
				<label for="email">이메일</label>
				<input type="email" name="email" value="<%=dto.getEmail()%>"/>
			</div>
			<div>
				<label for="profileImage">프로필 이미지</label>
				<div>
					<%if(dto.getProfileImage() == null) {%>
						
					<%} else { %>
					
					<%} %>
				</div>
				<input type="file" name="profileImage" accept="image/*"/>
			</div>
			<button type="submit">수정 확인</button>
			<button type="reset">취소</button>
		</form>
		
	</div>
</body>
</html>



