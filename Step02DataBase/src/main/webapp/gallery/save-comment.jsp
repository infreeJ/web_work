<%@page import="db.CommentDto"%>
<%@page import="db.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    int parentNum = Integer.parseInt(request.getParameter("parentNum"));
    String targetWriter = request.getParameter("targetWriter");
    String content = request.getParameter("content");
    	
    
    // 댓글의 그룹번호가 넘어오는지 읽어와본다.(null이라면 원글의 댓글 저장 요청)
    String strGroupNum = request.getParameter("groupNum");
    // 댓글의 그룹번호를 담을 변수를 미리 만들고
    int groupNum = 0;
    // 만딜 댓글의 그룹번호가 넘어온다면(대댓글이라면)
    if(strGroupNum != null) {
    	// 댓글의 그룹번호를 변수에 담는다.
    	groupNum = Integer.parseInt(strGroupNum);
    }
    
    
    String writer = (String)session.getAttribute("userName");
    	
    	// 저장할 댓글의 댓글 번호를 미리 얻어낸다.
    	int num = CommentDao.getInstance().getSequence();
    	CommentDto dto = new CommentDto();
    	dto.setNum(num);
    	dto.setWriter(writer);
    	dto.setTargetWriter(targetWriter);
    	dto.setContent(content);
    	dto.setParentNum(parentNum);
    	
    	// 만일 원글의 댓글이면
    	if(groupNum == 0) {
    		dto.setGroupNum(num); // 원글의 댓글의 자신의 글번호가 댓글의 그룹번호이다.
    	} else {
    		dto.setGroupNum(groupNum); // 대댓글은 전송된 그룹번호가 댓글의 그룹번호이다.
    	}
    	
    	
    	boolean isSuccess = CommentDao.getInstance().insert(dto);
    	
    	// 리다이렉트 : 원래글 자세히 보기 페이지로 다시 요청을 하라고 응답
    	String cPath = request.getContextPath();
    	response.sendRedirect(cPath + "/gallery/view.jsp?num=" + parentNum);
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/save-comment.jsp</title>
</head>
<body>

</body>
</html>