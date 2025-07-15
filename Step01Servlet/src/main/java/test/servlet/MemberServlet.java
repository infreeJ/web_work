package test.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/member")
public class MemberServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// get 방식 요청 파라미터 추출 "/member?num=x"
		
		// 추출된 문자열을 int로 변환하여 변수에 저장
		int num = Integer.parseInt(req.getParameter("num"));
		
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		
		// 클라이언트에게 출력할 수 있는 객체의 참조값 얻어내기
		PrintWriter pw = res.getWriter();
		pw.println("<!doctype html>");
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<meta charset='utf-8'>");
		pw.println("<title>회원 정보 자세히 보기</title>");
		pw.println("</head>");
		pw.println("<body>");
		pw.println("<p>" + num + "번 회원의 정보는 다음과 같습니다. 이름 : xxx, 주소 : xxx</p>");
		pw.println("</body>");
		pw.println("</html>");
		pw.close();
		
	}
}
