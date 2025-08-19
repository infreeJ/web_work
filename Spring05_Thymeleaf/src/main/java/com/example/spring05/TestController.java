package com.example.spring05;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TestController {
	
	/*
	 * 컨트롤러의 메서드에 UserDto를 선언하면 폼 전성되는 파라미터가 자동으로 추출되어서
	 * UserDto의 필드에 담긴채로 전달된다.
	 * 
	 * @ModelAttribute 어노테이션을 이용하면 view page에서 해당 객체에 담긴 값을 활용할 수 있다.
	 */
	
	@GetMapping("/print-num")
	public String printNum(Model model) {
		
		// 테스트를 위해 데이터 전달
		model.addAttribute("start", 6);
		model.addAttribute("end", 10);
		
		return "print-num";
	}
	
	
	@GetMapping("/include-test")
	public String includeTest(Model model) {
		model.addAttribute("title", "오늘의 운세");
		model.addAttribute("content", "동쪽으로 가면 귀인을 만나요");
		return "include-test";
	}
	
	
	@PostMapping("/save")
	public String save(@ModelAttribute("dto") UserDto dto) {
		// "dto"라는 키값으로 UserDto 객체가 Model 객체에 자동으로 담긴다.
		// 클라이언트가 전송한 내용을 view 페이지에 출력할 때 사용할 수 있다.
		return "save";
	}
	
	
	
	@GetMapping("/form")
	public String form() {
		
		return "form";
	}
	
	@GetMapping("/if")
	public String ifTest(Model model) {
		
		// view page에서 if문을 테스트할 값을 Model에 담기
		model.addAttribute("score", 75);
		model.addAttribute("age", 25);
		model.addAttribute("role", "staff");
		return "if";
	}
	
	@GetMapping("/member/detail")
	public String memberDetail(Model model) {
		// DB에서 불러온 회원 한 명의 정보라고 가정하자
		MemberDto dto = MemberDto.builder()
			.num(1)
			.name("김구라")
			.addr("노량진")
			.build();
		// 응답에 필요한 정보를 Model 객체에 담는다.
		model.addAttribute("dto", dto);
		// /templates/member/detail.html thymeleaf 페이지로 응답하기
		return "member/detail";
	}
	
	@GetMapping("/member/list")
	public String memberList(Model model) {
		MemberDto dto1 = MemberDto.builder()
				.num(1)
				.name("김구라1")
				.addr("노량진1")
				.build();
		MemberDto dto2 = MemberDto.builder()
				.num(2)
				.name("김구라2")
				.addr("노량진2")
				.build();
		MemberDto dto3 = MemberDto.builder()
				.num(3)
				.name("김구라3")
				.addr("노량진3")
				.build();
		List<MemberDto> list = List.of(dto1, dto2, dto3);
		model.addAttribute("list", list);
		
		return "member/list";
	}
}












