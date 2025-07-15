package test.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/send")
public class SendServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		/*
		 *   클라이언트가 요청을 하면서 전송한 요청 파라미터 추출하기
		 *   
		 *   - HttpServletRequest 객체의 기능을 이용해서 추출하면 된다.
		 *   - post 방식 전송인 경우 추출하기 전에 인코딩 설정을 해야 한다.
		 */
		
		String uri = req.getRequestURI();
		
		// 입력할 이름 추출
		String name = req.getParameter("name");
		// 입력할 메시지 추출
		String msg = req.getParameter("msg");
		// 콘솔창에 출력해보기
		System.out.println(uri + name + " : " + msg);
		
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");

		PrintWriter pw = res.getWriter();
		pw.println("<!doctype html>");
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<meta charset='utf-8'>");
		pw.println("<title>메시지 전송결과 페이지</title>");
		pw.println("</head>");
		pw.println("<body>");
		pw.println("<p>메시지 잘 받았습니다</p>");		
		pw.println("</body>");
		pw.println("</html>");
		pw.close();
	}
}
