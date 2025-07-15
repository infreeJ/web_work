<%@page import="db.BookDao"%>
<%@page import="db.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	BookDto dto = new BookDto();
	dto.setTitle(request.getParameter("title"));
	dto.setAuthor(request.getParameter("author"));
	dto.setPublisher(request.getParameter("publisher"));
	
	BookDao dao = new BookDao();
	dao.insert(dto);
	
	String cPath = request.getContextPath();
	response.sendRedirect(cPath+"/book/list.jsp");
%>