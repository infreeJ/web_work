<%@page import="db.BoardDao"%>
<%@page import="db.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 수정할 글 정보를 읽어와서
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDto dto = BoardDao.getInstance().getByNum(num);
	
	// 글 수정 폼을 응답한다.
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/edit.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container pt-3">
		<nav aria-label="breadcrumb">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
		    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/list.jsp">Board</a></li>
		    <li class="breadcrumb-item active" aria-current="page">Edit</li>
		  </ol>
		</nav>
		<h1>글 수정 페이지</h1>
		<form action="update.jsp" method="post">
			<div>
				<label class="form-label" for="num">글번호</label>
				<input class="form-control" type="text" name="num" id="num" value=<%=dto.getNum()%> readonly/>
			</div>
			<div>
				<label class="form-label" for="writer">작성자</label>
				<input class="form-control" type="text" name="writer" id="writer" value=<%=dto.getWriter()%> readonly/>
			</div>
			<div>
				<label class="form-label" for="title">제목</label>
				<input class="form-control" type="text" name="title" id="title" value=<%=dto.getTitle() %>>
			</div>
			<div>
				<label class="form-label" for="content">내용</label>
				<textarea class="form-control" type="text" name="content" id="content" value=<%=dto.getContent() %>/></textarea>
			</div>
			<button class="btn btn-success btn-sm">수정 확인</button>
			<button class="btn btn-success btn-sm">취소</button>
		</form>
	
	</div>
</body>
</html>