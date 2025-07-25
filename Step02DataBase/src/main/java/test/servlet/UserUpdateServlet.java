package test.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import db.UserDao;
import db.UserDto;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/*
 * 	enctype="multipart/form-data" 형식의 폼이 전송되었을 때 처리할 서블릿 만들기
 */


@WebServlet("/user/update")
@MultipartConfig(
	fileSizeThreshold = 1024*1024*10, // 업로드를 처리하기 위한 메모리 사이즈(10 Mega byte)
	maxFileSize = 1024*1024*50, // 업로드되는 최대 파일 사이즈(50 Mega byte)
	maxRequestSize = 1024*1024*60 // 이 요청의 최대 사이즈(60 Mega byte), 파일 외의 다른 문자열도 전송되기 때문에
)

public class UserUpdateServlet extends HttpServlet {
	
	// 업로드된 파일 저장경로를 저장할 필드 선언
	String fileLocation;
	
	// 이 서블릿이 초기화되는 시점에 최초 한번 호출되는 메서드
	@Override
	public void init() throws ServletException {
		// 무언가 초기화 작업을 여기서 하면 된다.
		ServletContext context = getServletContext();
		// web.xml 파일에 "fileLocation" 이라는 이름으로 저장된 정보를 읽어와서 필드에 저장하기
		fileLocation = context.getInitParameter("fileLocation");
	}
	
	// post 방식 전송을 처리하는 메서드
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 폼 전송되는 내용 추출
		String userName = req.getParameter("userName");
		String email = req.getParameter("email");
		// 파일 데이터 <input type="file" name="profileImage">
		Part filePart = req.getPart("profileImage");
		// DB 에서 사용자 정보를 불러온다
		UserDto dto = UserDao.getInstance().getByUserName(userName);
		
		// 만일 업로드된 프로필 이미지가 있다면
		if(filePart != null && filePart.getSize() > 0) {
			// 원본 파일의 이름 얻어내기
			String orgFileName = filePart.getSubmittedFileName();
			// 파일명이 겹치지 않게 랜덤한 id값 얻어내기
			String uid = UUID.randomUUID().toString();
			// 저장될 파일명을 구성한다.
			String saveFileName = uid + orgFileName;
			// 저장할 파일의 경로 구성하기
			String filePath = fileLocation + "/" + saveFileName;
			
			/*
			 * 업로드된 파일은 임시 폴더에 임시 파일로 저장이 된다.
			 * 해당 파일에서 byte 알갱이를 읽을 수 있는 InputStream 객체를 얻어내서
			 */
			
			InputStream is = filePart.getInputStream();
			// 원하는 위지에 copy해야한다.
			Files.copy(is, Paths.get(filePath));
			
			// 기존에 이미 저장된 프로필 사진이 있으면 파일시스템에서 삭제하기
			if(dto.getProfileImage() != null) {
				// 삭제할 파일의 전체 경로
				String deleteFilePath = fileLocation + "/" + dto.getProfileImage();
				// Files 클래스의 delete() 메서드를 이용해서 삭제하기
				Files.delete(Paths.get(deleteFilePath));
			}
			
			// dto에 이메일과 저장된 파일명을 담는다.
			dto.setEmail(email);
			dto.setProfileImage(saveFileName);
			// dao의 email과 profile을 수정하는 메서드를 이용하여 수정 반영
			UserDao.getInstance().updateEmailProfile(dto);
		} else { // 업로드된 프로필 이미지가 없으면 (이메일만 수정)
			// dto에 이메일만 담는다.
			dto.setEmail(email);
			// dao의 email만 수정하는 메서드를 이용하여 수정 반영
			UserDao.getInstance().updateEmail(dto);
			
		}
		
		String cPath = req.getContextPath();
		resp.sendRedirect(cPath + "/user/info.jsp");
	}
}












