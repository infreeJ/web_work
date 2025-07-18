<%@page import="db.BoardDto"%>
<%@page import="org.apache.catalina.filters.ExpiresFilter.XHttpServletResponse"%>
<%@page import="db.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 폼 전송되는 내용을 읽어와서
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 글 작성자와 로그인된 userName이 동일한지 비교해서 동일하지 않으면 에러를 응답한다.
	String writer = BoardDao.getInstance().getByNum(num).getWriter();
	String userName = (String)session.getAttribute("userName");
	// 만일 글 작성자와 로그인된 userName 하고 같지 않으면
	if(!writer.equals(userName)) {
		// 에러 페이지 응답
		response.sendError(XHttpServletResponse.SC_FORBIDDEN, "남의 게시글 수정하지 마세요");
		return; // 메서드를 여기서 종료
	}
	
	// DB에 수정 반영하고
	BoardDto dto = new BoardDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);

	// 응답한다.
	BoardDao.getInstance().update(dto);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/update.jsp</title>
</head>
<body>
	<script>
		alert("수정 했습니다!")
		location.href="${pageContext.request.contextPath}/board/view.jsp?num=<%=num%>"
	</script>
</body>
</html>




