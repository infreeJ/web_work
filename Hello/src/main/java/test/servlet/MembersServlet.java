package test.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import db.MemberDao;
import db.MemberDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/members")
public class MembersServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		MemberDao dao = new MemberDao();
		
		List<MemberDto> list = dao.select();
		
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");

        PrintWriter pw = res.getWriter();
        pw.println("<!doctype html>");
        pw.println("<html>");
        pw.println("<head>");
        pw.println("<meta charset='utf-8'>");
        pw.println("<title>회원 목록 페이지</title>");
        pw.println("</head>");
        pw.println("<body>");
        pw.println("""
        		<table>
        		<tr>
        			<th>번호</th>
        			<th>이름</th>
        			<th>주소</th>
        		</tr>
        		""");
        
        for (MemberDto dto : list) {
        	pw.println("<tr>");
        	pw.println("<td>" + dto.getNum() + "</td>");
        	pw.println("<td>" + dto.getName() + "</td>");
        	pw.println("<td>" + dto.getAddr() + "</td>");
        	pw.println("</tr>");
        }
        
        pw.println("</table>");
        pw.println("<img src ='/Hello/images/SouthKorea.png'/>");
        pw.println("</body>");
        pw.println("</html>");
        pw.close();
	}
}










