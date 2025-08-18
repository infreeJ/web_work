package com.example.spring04.exception;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 예외 처리 컨트롤러
@ControllerAdvice
public class ExceptionController {
	/*
	 * spring 프레임워크가 동작하는 과정 중에 DataAccessException type의 예외 발생 시
	 * 이 메서드가 자동으로 호출된다.
	 * 메서드의 매개변수에는 해당 예외 객체의 참조값이 전달된다.
	 * 예외 관련 처리를 하고 에러 페이지를 응답할 수 있다.
	 */

	@ExceptionHandler(DataAccessException.class)
	public String dataAccess(DataAccessException dae, Model model) {
		
		model.addAttribute("title", "DB 관련 작업 중에 예외가 발생했습니다");
		model.addAttribute("message", dae.getMessage());
		model.addAttribute("status", 500);
		
		return "error/data-access"; // 에러페이지 경로
	}
	
	@ExceptionHandler(MemberException.class)
	public String memberException(MemberException me, Model model) {
		model.addAttribute("title", "Member 관련 작업 중에 에러가 발생했습니다");
		model.addAttribute("message", me.getMessage());
		model.addAttribute("status", me.reason.name());
		
		return "error/member-exception";
	}
	
	@ExceptionHandler(BookException.class)
	public String bookException(BookException be, Model model) {
		model.addAttribute("title", "Book 관련 작업 중에 에러가 발생했습니다");
		model.addAttribute("message", be.getMessage());
		model.addAttribute("status", be.reason.name());
		
		return "error/book-exception";
	}
}












