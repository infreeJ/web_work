<%@page import="db.UserDao"%>
<%@page import="db.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/include/navbar.jsp --%>
<%
	//navbar.jsp 페이지가 어떤 페이지에 include 되었는지 파라미터 읽어오기
	String thisPage=request.getParameter("thisPage");// "index" or "member" or "book"
	//로그인된 userName 이 있는지 읽어와 본다
	String userName=(String)session.getAttribute("userName");
	
	UserDto userDto = UserDao.getInstance().getByUserName(userName);
	
%>
	<nav class="navbar navbar-expand-md bg-success" data-bs-theme="dark">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath }/">Acorn</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
						<a class="nav-link <%=thisPage.equals("member") ? "active":""%>" href="${pageContext.request.contextPath }/member/list.jsp">Member</a>
					</li>
					<li class="nav-item">
						<a class="nav-link <%=thisPage.equals("book") ? "active":""%>" href="${pageContext.request.contextPath }/book/list.jsp">Book</a>
					</li>
					<li class="nav-item">
						<a class="nav-link <%=thisPage.equals("board") ? "active":""%>" href="${pageContext.request.contextPath }/board/list.jsp">Board</a>
					</li>
				</ul>
	            <!-- 오른쪽 사용자 메뉴 -->
	            <ul class="navbar-nav">
                <%if (userName == null) {%>
	                <li class="nav-item">
	                    <a class="btn btn-outline-light btn-sm me-2"
	                       href="${pageContext.request.contextPath }/user/loginform.jsp">로그인</a>
	                </li>
	                <li class="nav-item">
	                    <a class="btn btn-warning btn-sm"
	                       href="${pageContext.request.contextPath }/user/signup_form.jsp">회원가입</a>
	                </li>
                <%}else {%>
                	<li>
                		<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#staticBackdrop" aria-controls="staticBackdrop">
  						알림버튼
						</button>
					</li>
	                <li class="nav-item  me-2">
					    <a class="nav-link  p-0"
					       href="${pageContext.request.contextPath}/user/info.jsp">
					        <strong><%= userName %></strong>
					    </a>
					</li>
	                <li class="nav-item me-2">
	                    <span class="navbar-text">Signed in</span>
	                </li>
	                <li class="nav-item">
	                    <a class="btn btn-danger btn-sm"
	                       href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
	                </li>
                <%}%>
                </ul>
			</div>
		</div>
	</nav>
	
<div class="offcanvas offcanvas-end" data-bs-backdrop="static" tabindex="-1" id="staticBackdrop" aria-labelledby="staticBackdropLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="staticBackdropLabel">알림 목록</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div>
      <ul>
      	<li>
      		
      	</li>
      </ul>
    </div>
  </div>
</div>

	
	
	
	
	
	
	
	
	