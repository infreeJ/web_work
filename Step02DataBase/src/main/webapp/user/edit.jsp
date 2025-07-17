<%@page import="db.UserDao"%>
<%@page import="db.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String userName = (String)session.getAttribute("userName");

	
	UserDto dto = UserDao.getInstance().getByUserName(userName);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/edit.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<h1>가입정보 수정</h1>
		<%--
			input type="file"이 있는 from의 전송방식은 다르다.
			따라서 enctype="multipart/form-data" 속성을 form에 추가해둔다.
			서버에서 해당 요청을 처리하는 방법도 다르기 때문에 jsp가 아닌 서블릿에서 처리하자
		 --%>
		<form action="${pageContext.request.contextPath}/user/update" method="post" enctype="multipart/form-data">
			<div>
				<label for="userName">아이디</label>
				<input type="text" name="userName" value="<%=dto.getUserName() %>" readOnly/>
			</div>
			<div>
				<label for="email">이메일</label>
				<input type="email" name="email" value="<%=dto.getEmail()%>"/>
			</div>
			<div>
				<label for="profileImage">프로필 이미지</label>
				<div>
					<a href="javascript:" id="profileLink">
						<%if(dto.getProfileImage() == null) {%>
							<i style="font-size:100px;" class="bi bi-person-circle"></i>
						<%} else { %>
						<% %>
							<img src="${pageContext.request.contextPath}/upload/<%=dto.getProfileImage() %>" 
							style="width:100px; height:100px; border-radius:50%;"/>
						<%} %>
					</a>
				</div>
				<input type="file" name="profileImage" accept="image/*" style="display:none;"/>
			</div>
			<button type="submit">수정 확인</button>
			<button type="reset">취소</button>
		</form>
	</div>
	<script>
		// 이미지를 감싸고 있는 링크를 클릭했을 때
		document.querySelector("#profileLink").addEventListener("click", () => {
			// input 강제 클릭
			document.querySelector("input[name=profileImage]").click();
		})
		
		// input 요소 중 name 속성 값이 profileImage인 요소를 선택해서 이벤트 리스너 등록
		document.querySelector("input[name=profileImage]").addEventListener("change", (e) => {
			// 선택한 파일을 배열로 얻어내기
			const files = e.target.files;
			// FileReader 객체 생성
			const reader = new FileReader();
			// 배열의 0번방의 파일객체를 읽고
			reader.readAsDataURL(files[0]);
			// 다 읽으면 실행할 함수 등록
			reader.onload = () => {
				// 읽은 데이터를 이용해서 img 요소를 만들 준비를 한다.
				const img = `<img src="\${reader.result}"
				style="width:100px; height:100px; border-radius:50%">`;
				// img 마크업 형식의 문자열을 실제로 HTML로 해석이 되게끔 a 요소 안에 넣기
				document.querySelector("#profileLink").innerHTML = img
			}
		})
	</script>
</body>
</html>



