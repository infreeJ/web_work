package test.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/test/fileup")
@MultipartConfig( // 파일업로드를 위한 어노테이션(반드시 서블릿에서 처리)
	fileSizeThreshold = 1024*1024*10, // 업로드를 처리하기 위한 메모리 사이즈(10 Mega byte)
	maxFileSize = 1024*1024*50, // 업로드되는 최대 파일 사이즈(50 Mega byte)
	maxRequestSize = 1024*1024*60 // 이 요청의 최대 사이즈(60 Mega byte), 파일 외의 다른 문자열도 전송되기 때문에
)
public class FileupServlet extends HttpServlet{
	// 업로드된 파일 저장경로를 저장할 필드 선언
	String fileLocation;
		
	// 이 서블릿이 초기화되는 시점에 최초 한번 호출되는 메서드
	@Override
	public void init() throws ServletException {
		// 무언가 초기화 작업을 여기서 하면 된다.
		ServletContext context = getServletContext();
		// web.xml 파일에 "fileLocation" 이라는 이름으로 저장된 정보를 읽어와서 필드에 저장하기
		fileLocation = context.getInitParameter("fileLocation"); // web.xml에 설정된 경로를 자동으로 읽어온다.
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// caption이라는 파라미터 명으로 문자열이 전송되고
		// myFile 이라는 파라미터 명으로 파일이 전송된다. (Part 객체로 추출)
		String caption = req.getParameter("caption"); // input type="text" name="caption"
		Part filePart = req.getPart("myFile"); // input type="file" name="myFile"
		// 업로드된 파일이 없다면
		if(filePart != null && filePart.getSize() > 0) {
			// 원본 파일의 이름을 변수에 저장
			String orgFileName = filePart.getSubmittedFileName();
			// 랜덤한 id값 얻어내고
			String uid = UUID.randomUUID().toString();
			// 랜덤 id값과 원본 파일이름을 합쳐서 중복되지 않고록 구성한다.
			String saveFileName = uid + orgFileName;
			// 업로드 파일을 저장할 경로와 구성한 파일명을 결합하여 경로를 구성한다.
			String filePath = fileLocation + "/" + saveFileName;
			
			// 업로드된 파일은 임시 폴더에 임시 파일로 저장이 된다.
			// 해당 파일에서 type 알갱이를 읽을 수 있는 InputStream 객체를 얻어내서
			InputStream is = filePart.getInputStream();
			// 원하는 목적지에 copy
			Files.copy(is, Paths.get(filePath));
			// 업로드된 파일의 크기(업로드 제한 용도, 피드백용, DB저장용 등 용도가 다양함)
			long fileSize = filePart.getSize();
			
			// 원래는 DB에 저장해야 하지만 테스트로 응답에 필요한 데이터를
			// HttpServletRequest 객체의 .setAttribute("key", value) 메서드를 이용해서 저장하고
			// jsp 페이지가 사용할 수 있도록 한다.
			// jsp 페이지 해당 정보를 얻어낼 때는
			// HttpServletRequest 객체의 .getAttribute("key") 메서드를 이용해서 얻어낸다.
			
			req.setAttribute("orgFileName", orgFileName); // String type
			req.setAttribute("saveFileName", saveFileName); // String type
			req.setAttribute("fileSize", fileSize); // long type
			
		}
		
		// 요청 전달자 객체 얻어내기
		RequestDispatcher rd = req.getRequestDispatcher("/test/윤제.jsp");
		// 응답을 위임하기
		rd.forward(req, resp);
	}
}










