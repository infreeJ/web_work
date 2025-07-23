
<%@page import="org.apache.tomcat.jakartaee.commons.lang3.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="db.BoardDao"%>
<%@page import="db.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	// 검색 키워드가 있는지 확인
	String keyword = request.getParameter("keyword");
	System.out.println(keyword); // null or "" 또는 검색어
	
	if(keyword == null) {
		keyword = "";
	}


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
	final int PAGE_ROW_COUNT = 3;
	
	// 하단 페이지를 몇 개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT = 3;
	
	// 보여줄 페이지의 시작 ROWNUM
	int startRowNum = 1+(pageNum-1) * PAGE_ROW_COUNT;
	// 보여줄 페이지의 끝 ROWNUM
	int endRowNum = pageNum * PAGE_ROW_COUNT;
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum = startPageNum + PAGE_DISPLAY_COUNT-1;
	
	
	
	/*
	StringUtils 클래스의 isEmpty() static 메서드를 이용하면 문자열이 비었는지 여부를 알 수 있다.
	null 또는 "" 빈 문자열은 비었다고 판정된다.
	
	StringUtils.isEmpty(keyword)는 keyword == null or "".equals(keyword)를 대체할 수 있다.
	
	*/
	//전체 글의 갯수
	int totalRow = 0;
	if(StringUtils.isEmpty(keyword)) {
		totalRow=BoardDao.getInstance().getCount();
	} else {
		totalRow=BoardDao.getInstance().getCountByKeyword(keyword);
	}
	
	
	
	
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
			
	List<BoardDto> list = null;
	
	
	// 해당 row만 select
	if(StringUtils.isEmpty(keyword)) { // 검색어가 없다면
		list = BoardDao.getInstance().selectPage(dto);
	} else { // 검색어가 있다면
		dto.setKeyword(keyword); // DTO에 keyword 추가 후
		list = BoardDao.getInstance().selectPageByKeyword(dto); // Select
	}
	
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
		
		<div class="row">
			<div class="col-lg-4 col-md-6 ms-auto mb-3">
				<form action="list.jsp" method="get">
					<div class="input-group col-3">
						<input value="<%=StringUtils.isEmpty(keyword) ? "" : keyword %>"
						type="text" name="keyword" class="form-control" placeholder="검색어 입력..."/>
						<button type="submit" class="btn btn-outline-secondary">검색</button>
					</div>
				</form>
			</div>
		</div>
		
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
		<ul class="pagination">
			<li class="page-item">
				<%if(startPageNum != 1) {%>
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1%>&keyword=<%=keyword%>">&lsaquo;</a>
				<%} %>
				
			</li>
			
			<%for(int i=startPageNum; i <= endPageNum; i++) {%>
				<li class="page-item">
					
					<a class="page-link <%=i==pageNum ? "active" : "" %>" href="list.jsp?pageNum=<%=i%>&keyword=<%=keyword%>"><%=i%></a>
				</li>
			<%}%>
			
			<li class="page-item">
				<%if(endPageNum != totalPageCount) {%>
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1%>&keyword=<%=keyword%>">&rsaquo;</a>
				<%}%>
			</li>
		</ul>
	</div>
</body>
</html>