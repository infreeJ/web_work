<%@page import="db.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num = Integer.parseInt(request.getParameter("num"));

	new BookDao().delete(num);
	
	String cPath = request.getContextPath();
	response.sendRedirect(cPath+"/book/list.jsp");
%>