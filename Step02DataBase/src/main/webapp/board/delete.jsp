<%@page import="org.apache.catalina.filters.ExpiresFilter.XHttpServletResponse"%>
<%@page import="db.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// GET 방식 파라미터로 전달되는 글 번호를 읽어와서
	int num = Integer.parseInt(request.getParameter("num"));

	// 글 작성자와 로그인된 userName이 동일한지 비교해서 동일하지 않으면 에러를 응답한다.
	String writer = BoardDao.getInstance().getByNum(num).getWriter();
	String userName = (String)session.getAttribute("userName");
	// 만일 글 작성자와 로그인된 userName 하고 같지 않으면
	if(!writer.equals(userName)) {
		// 에러 페이지 응답
		response.sendError(XHttpServletResponse.SC_FORBIDDEN, "남의 게시글 지우지 마세요");
		return; // 메서드를 여기서 종료
	}
	
	
	// DB에서 해당 글을 삭제하고
	BoardDao.getInstance().deleteByNum(num);
	// 응답한다.

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/delete.jsp</title>
</head>
<body>
	<script>
		alert("삭제 했습니다!")
		location.href="${pageContext.request.contextPath}/board/list.jsp"
	</script>
</body>
</html>
