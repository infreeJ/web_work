package com.example.spring04.controller;

import java.net.http.HttpRequest;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.spring04.dto.MemberDto;
import com.example.spring04.repository.MemberDao;
import com.example.spring04.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	
	// 필요한 의존 객체를 주입받는다
	private final MemberService service;
	
	@PostMapping("/member/update")
	public String update(MemberDto dto) {
		service.updateMember(dto);
		return "member/update";
	}

	@GetMapping("/member/edit")
	public String edit(int num, Model model) {
		MemberDto dto = service.getMember(num);
		model.addAttribute("dto", dto);
		return "member/edit";
	}
	
	@GetMapping("/member/delete")
	public String delete(int num) {
		service.deleteMember(num);
		return "/member/delete";
	}
	
	
	@PostMapping("/member/save")
	public String save(MemberDto dto) {
		service.addMember(dto);
		// 회원 목록보기 "/member/list" 요청을 다시 하라는 redirect 응답하기
		return "redirect:/member/list";
	}
	
	@GetMapping("/member/new")
	public String newForm() {
		return "member/new-form";
	}
	
	@GetMapping("/member/list")
	public String list(Model model) {
		List<MemberDto> list = service.getAll();
		// 응답에 필요한 객체를 Model 객체에 담는다.
		model.addAttribute("list", list);
		// "/WEB-INF/views/member/list.jsp" 에서 응답하기
		return "member/list";
	}
	
}
