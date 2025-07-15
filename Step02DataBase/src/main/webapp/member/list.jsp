<%@page import="test.util.DbcpBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="db.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDao dao = new MemberDao();
	List<MemberDto> list = dao.select();
	System.out.println(list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/list.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/include/navbar.jsp">
	<jsp:param name="thisPage" value="member"/>
</jsp:include>
	<a href="${pageContext.request.contextPath}/member/insertform.jsp">회원 추가</a>
	<h1>회원 목록</h1>
	<table>
		<tr>
			<th>번호</th><th>이름</th><th>주소</th>수정<th><th>삭제</th>
		</tr>
		
		<%
		for(MemberDto tmp : list) {%>
		<tr>
			<td><%=tmp.getNum()%></td>
			<td><%=tmp.getName()%></td>
			<td><%=tmp.getAddr()%></td>
			<td><a href="updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
			<td><a href="${pageContext.request.contextPath}/member/delete.jsp?num=<%=tmp.getNum()%>">삭제</a></td>
			<td><a href="javascript:" class="delete-Link" data-num="<%=tmp.getNum()%>">삭제</a></td>
		</tr>
		<%}%>
	</table>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
	
	<script>
		const deleteLink = document.querySelectorAll(".delete-Link")
		
		deleteLink.forEach((item) => {
			item.addEventListener("click", (e) => {
				const num = e.target.getAttribute("data-num");
				const isDelete = confirm(num+"번 회원을 삭제하시겠습니까????");
				if(isDelete) {
					location.href = "${pageContext.request.contextPath}/member/delete.jsp?num="+num;
				}
			})
		})
	</script>
</body>
</html>










