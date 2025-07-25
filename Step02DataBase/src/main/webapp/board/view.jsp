<%@page import="java.util.List"%>
<%@page import="db.CommentDto"%>
<%@page import="db.CommentDao"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="db.BoardDao"%>
<%@page import="db.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	// get 방식 파라미터로 전달되는 글 번호 얻어내기
	int num = Integer.parseInt(request.getParameter("num"));
	
	// DB에서 해당 글의 자세한 정보를 얻어낸다.
	BoardDto dto = BoardDao.getInstance().getByNum(num);
	
	// 로그인된 userName
	String userName = (String)session.getAttribute("userName");
	
	// 자신의 글이 아니라면 조회수 1 증가
	if(!dto.getWriter().equals(userName)) {
		BoardDao.getInstance().addViewCount(num);
	}
	
	// 댓글 목록을 DB에서 읽어오기
	List<CommentDto> commentList = CommentDao.getInstance().selectList(num);
	
	boolean isLogin = userName == null ? false : true;
	System.out.println(isLogin);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/detail.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>

	<%-- breadcrumb --%>
	<div class="container pt-3">
		<nav aria-label="breadcrumb">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
		    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/list.jsp">Board</a></li>
		    <li class="breadcrumb-item active" aria-current="page">Detail</li>
		  </ol>
		</nav>
		<h1>게시글 상세 보기</h1>
		<div class="btn-group mb-2">
			<a class="btn btn-outline-secondary btn-sm <%=dto.getPrevNum() == 0 ? "disabled" : "" %>"
			href="view.jsp?num=<%=dto.getPrevNum()%>">
				<i class="bi bi-arrow-left"></i>
				Prev
			</a>
			<a class="btn btn-outline-secondary <%=dto.getNextNum() == 0 ? "disabled" : "" %>"
			href="view.jsp?num=<%=dto.getNextNum()%>">
				Next
				<i class="bi bi-arrow-right"></i>
			</a>
		</div>
		
		<%-- 게시글 상세 내용 출력 --%>
		<table class="table table-striped">
			<colgroup>
				<col class="col-2" />
				<col class="col" />
			</colgroup>
			<tr>
				<th>글번호</th>
				<td><%=num %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
				<%if (dto.getProfileImage() == null) {%>
					<i style="font-size:100px;" class="bi bi-person-circle"></i>
				<%} else {%>
					<img src="${pageContext.request.contextPath}/upload/<%=dto.getProfileImage() %>" 
					style="width:100px; height:100px; border-radius:50%;"/>
				<%} %>
				<%=dto.getWriter() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewCount() %></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getCreatedAt() %></td>
			</tr>
		</table>
		
		<%
			// 클라이언트가 작성한 글 제목이나 내용을 그대로 클라이언트에게 출력하는 것은 javascript 주입 공격을 막을 수 있다.
			// 따라서 해당 문자열은 excape해서 출력하는 것이 안전하다.
		%>
		
		
		<div class="card mt-4">
		  <div class="card-header bg-light">
		    <strong>본문 내용</strong>
		  </div>
		  <div class="card-body p-1">
		    <%=dto.getContent() %>
		  </div>
		</div>
		<%if(dto.getWriter().equals(userName)) {%>
			<div class="text-end pt-2">
				<a class="btn btn-warning btn-sm" href="edit.jsp?num=<%=dto.getNum() %>">Edit</a>
				<a class="btn btn-danger btn-sm" href="delete.jsp?num=<%=dto.getNum() %>">Delete</a>
			</div>
		<%} %>
		
		
		<%-- 댓글 작성 폼 --%>
		<div class="card my-3">
  			<div class="card-header bg-primary text-white">
    			댓글을 입력해 주세요
  			</div>
			<div class="card-body">
				<!-- 원글의 댓글을 작성할 폼 -->
				<form action="save-comment.jsp" method="post">
			    	<!-- 숨겨진 입력값 -->
			    	<input type="hidden" name="parentNum" value="<%=dto.getNum() %>"/>
			    	<input type="hidden" name="targetWriter" value="<%=dto.getWriter() %>" />
			
			    	<div class="mb-3">
			        	<label for="commentContent" class="form-label">댓글 내용</label>
			        	<textarea id="commentContent" name="content" rows="5" class="form-control" placeholder="댓글을 입력하세요"></textarea>
			      	</div>
			
			      	<button type="submit" class="btn btn-success">등록</button>
			    </form>
			</div>
		</div>
		
		
		<%-- 댓글 목록 출력하기 --%>
		<div class="comments">
		<%for(CommentDto tmp : commentList) {%>
			<div class="card mb-3">
			<%if(tmp.getDeleted().equals("yes")) { %>
				<div class="card-body bg-light text-muted rounded">삭제된 댓글입니다</div>
			<%} else { %>
				<div class="card-body d-flex flex-column flex-sm-row position-relative">
		      <%-- 댓글 작성자가 로그인된 userName과 같다면 close버튼 출력 --%>
		      <%if(tmp.getWriter().equals(userName)) { %>
		      	<button data-num="<%=tmp.getNum() %>" class="btn-close position-absolute top-0 end-0 m-2 mt-3"></button>
		      <%}%>
		      
		        <%if(tmp.getProfileImage() == null) { %>
		        	<i style="font-size:50px;" class="bi bi-person-circle me-3 align-self-center"></i>
		        <%} else { %>
		        <img class="rounded-circle me-3"
		        	src="${pageContext.request.contextPath}/upload/<%=tmp.getProfileImage() %>"
		        	alt="프로필 이미지" style="width:50px; height:50px">
		        <%} %>
	
		        <div class="flex-grow-1">
		          <div class="d-flex justify-content-between">
		            <div>
		              <strong><%=tmp.getWriter() %></strong>
		              <span><%=tmp.getTargetWriter() %></span>
		            </div>
		            <small class="me-3"><%=tmp.getCreatedAt() %></small>
		          </div>
		          <pre><%=tmp.getContent() %></pre>
		          
		          <%-- 댓글 작성자가 로그인된 userName과 같으면 수정폼, 다르면 댓글폼을 출력한다. --%>
		          <%if(tmp.getWriter().equals(userName)) { %>
			          <button class="btn btn-sm btn-outline-primary edit-btn">수정</button>
			          <!-- 댓글 수정 폼 (처음에는 숨김) -->
			          <div class="d-none form-div">
			            <form action="comment-update.jsp" method="post">
			            <%-- 댓글을 수정하기 위한 댓글의 번호, 이 페이지로 다시 돌아오기 위한 parentNum도 같이 전송 --%>
			              <input type="hidden" name="num" value=<%=tmp.getNum() %> />
			              <input type="hidden" name="parentNum" value=<%=num %> />
			              <textarea name="content" class="form-control mb-1" rows="2"><%=tmp.getContent() %></textarea>
			              <button type="submit" class="btn btn-sm btn-success">수정 완료</button>
			              <button type="reset" class="btn btn-sm btn-secondary cancel-edit-btn">취소</button>
			            </form>
			          </div>
		          <%} else { %>
		          	<button class="btn btn-sm btn-outline-primary show-reply-btn">댓글</button>
			          <!-- 댓글 입력 폼 (처음에는 숨김) -->
			          <div class="d-none form-div">
			            <form action="save-comment.jsp" method="post">
			              <textarea class="form-control mb-1" rows="2" placeholder="댓글을 입력하세요"></textarea>
			              <button type="submit" class="btn btn-sm btn-success">등록</button>
			              <button type="reset" class="btn btn-sm btn-secondary cancel-reply-btn">취소</button>
			            </form>
			          </div>
		          <%} %>
		          
		          
		        </div>
		      </div>
			<%} %>
		      
		    </div>
		<%} %>
		</div>
	</div>
	
	
	<script>
	const isLogin = <%=isLogin%>
	console.log(isLogin)
	
	document.querySelector("#commentContent").addEventListener("focus", () => {
		// 원글의 댓글 입력란에 포커스가 왔을 때 만일 로그인하지 않았다면
		if(isLogin == false) {
			alert("로그인이 필요합니다.")
			location.href="${pageContext.request.contextPath }/user/loginform.jsp?url=${pageContext.request.contextPath }/board/view.jsp?num=<%=num %>";
		}
	})
	
	  document.querySelectorAll(".show-reply-btn").forEach((item) => {
		// 원글의 댓글 입력란에 포커스가 왔을 때 만일 로그인하지 않았다면
	    item.addEventListener("click", (e) => {
	    	if(isLogin == false) {
				alert("로그인이 필요합니다.")
				location.href="${pageContext.request.contextPath }/user/loginform.jsp?url=${pageContext.request.contextPath }/board/view.jsp?num=<%=num %>";
				return;
	    	}
	      item.nextElementSibling.classList.remove("d-none");
	      item.classList.add("d-none");
	    })
	  })
	
	  
	  // 대댓글 작성 폼 닫는 이벤트 리스너
	  document.querySelectorAll(".cancel-reply-btn").forEach((item) => {
	    item.addEventListener("click", () => {
	      const formDiv = item.closest(".form-div")
	      formDiv.classList.add("d-none")
	      formDiv.previousElementSibling.classList.remove("d-none")
	    })
	  })
	  
	  
	  // 댓글 수정 이벤트리스너
	  document.querySelectorAll(".edit-btn").forEach((item) => {
	    item.addEventListener("click", () => {
	      item.classList.add("d-none")
	      item.nextElementSibling.classList.remove("d-none")
	    })
	  })
	
	  // 댓글 수정폼 닫는 이벤트리스너
	  document.querySelectorAll(".cancel-edit-btn").forEach((item) => {
	    item.addEventListener("click", () => {
	      const formDiv = item.closest(".form-div")
	      formDiv.classList.add("d-none")
	      formDiv.previousElementSibling.classList.remove("d-none")
	    })
	  })
	
	
	  // 댓글 삭제 이벤트리스너
	  document.querySelectorAll(".btn-close").forEach((item) => {
	    item.addEventListener("click", () => {
	      // data-num 속성에 출력된 삭제할 댓글의 번호
	      const num = item.getAttribute("data-num");
	      const isDelete = confirm(num + "번 댓글을 삭제하시겠습니까?")
	      if(isDelete) {
	    	  // "delete-comment.jsp?num=삭제할_댓글번호&parentNum=원글의_글번호"
	    	  location.href = `comment-delete.jsp?num=\${num}&parentNum=<%=num%>`;
	      }
	    })
	  })
	  
	  
  </script>
</body>
</html>






