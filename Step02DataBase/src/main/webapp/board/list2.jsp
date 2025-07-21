<%@page import="java.util.List"%>
<%@page import="db.BoardDao"%>
<%@page import="db.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	// 기본 페이지 번호는 1로 설정하고
	int pageNum = 1;
	// 페이지 번호를 읽어와서
	String strPageNum = request.getParameter("pageNum");

	// 전달되는 페이지가 있다면
	if(strPageNum != null) {
		// 전달되는 페이지 번호로 변경해서 사용
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}
	

	// 한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT = 5;
	
	// 하단 페이지를 몇 개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT = 5;
	
	// 보여줄 페이지의 시작 ROWNUM
	int startRowNum = 1+(pageNum-1) * PAGE_ROW_COUNT;
	// 보여줄 페이지의 끝 ROWNUM
	int endRowNum = pageNum * PAGE_ROW_COUNT;
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum = startPageNum + PAGE_DISPLAY_COUNT-1;
	
	//전체 글의 갯수
	int totalRow=BoardDao.getInstance().getCount();
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}	

	// dto에 select할 row의 정보를 담고
	BoardDto dto = new BoardDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// 해당 row만 select
	List<BoardDto> list = BoardDao.getInstance().selectPage(dto);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/list2.jsp</title>

<style>
	ul a{
		text-decoration: none;
	}

	.active{
		font-weight: bold;
		color: red;
		text-decoration: underline;
	}
	
	ul.my-pagination{
		list-style-type: none;
		padding-left: 0;
		display: flex;
		gap: 10px;
		justify-content: center;
	}
	
</style>

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
		<ul class="my-pagination">
			<li>
				<%if(startPageNum != 1) {%>
					<a href="list.jsp?pageNum=<%=startPageNum-1%>">&lsaquo;</a>
				<%} %>
				
			</li>
			<%
			for(int i=startPageNum; i <= endPageNum; i++) {%>
				<li>
					
					<a class="<%= i==pageNum ? "active" : "" %>" href="list.jsp?pageNum=<%=i%>"><%=i%></a>
				</li>
			<%}%>
			<li>
				<%if(endPageNum != totalPageCount) {%>
					<a href="list.jsp?pageNum=<%=endPageNum+1%>">&rsaquo;</a>
				<%} %>
				
			</li>
		</ul>
	</div>
</body>
</html>