<%@page import="db.MemberDao"%>
<%@page import="db.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	int num = Integer.parseInt(request.getParameter("num"));
	MemberDto dto = new MemberDao().getByNum(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/updateform.jsp</title>
</head>
<body>
	<div class="container">
		<h1>회원정보 수정 양식</h1>
		<form action="${pageContext.request.contextPath}/member/update.jsp" method="post">
			<div>
				<label for="num">번호</label>
				<input type="text" name="num" id="num" value="<%=dto.getNum()%>" readonly/>
			</div>
			<div>
				<label for="name">이름</label>
				<input type="text" name="name" id="name" value="<%=dto.getName()%>"/>
			</div>
			<div>
				<label for="addr">주소</label>
				<input type="text" name="addr" id="addr" value="<%=dto.getAddr()%>"/>
			</div>
			<button type="submit">수정</button>
			<button type="reset">취소</button>
		</form>
	</div>
</body>
</html>