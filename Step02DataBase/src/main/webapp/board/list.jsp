<%@page import="java.util.List"%>
<%@page import="db.BoardDao"%>
<%@page import="db.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	List<BoardDto> list = BoardDao.getInstance().selectAll();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/list.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="board" name="thisPage"></jsp:param>
	</jsp:include>
	<div class="container pt-2">
		<a class="btn btn-outline-primary btn-sm" href="new-form.jsp">새글 작성<i class="bi bi-pencil-square"></i></a>
		<h1>게시글 목록입니다.</h1>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>글번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<%for(BoardDto tmp : list) {%>
					<tr>
						<td><%=tmp.getNum() %></td>
						<td><%=tmp.getWriter() %></td>
						<td><a href="view.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a></td>
						<td><%=tmp.getViewCount() %></td>
						<td><%=tmp.getCreatedAt() %></td>
					</tr>
				<%}%>
			</tbody>
		</table>
	</div>
</body>
</html>