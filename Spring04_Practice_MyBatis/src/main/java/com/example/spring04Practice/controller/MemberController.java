package com.example.spring04Practice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.spring04Practice.dto.MemberDto;
import com.example.spring04Practice.repository.MemberDao;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class MemberController {
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	
	@Autowired
	private MemberDao dao;
	
	@GetMapping("/member/list")
	public String List(Model model) {
		List<MemberDto> list = dao.selectAll();
		model.addAttribute("list", list);
		return "/member/list";
	}
	
	@PostMapping("/member/insert")
	public String insert(MemberDto dto) {
		int insertSuccess = dao.insert(dto);
		return "redirect:/member/list";
	}
	
	@GetMapping("/member/insertForm")
	public String insertForm() {
		return "/member/insertForm";
	}
	
	@GetMapping("/member/deleteByNum")
	public String deleteByNum(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		int insertSuccess = dao.deleteByNum(num);
		return "redirect:/member/list";
	}
	
	
	@GetMapping("/member/updateForm")
	public String updateForm() {
		return "/member/updateForm";
	}
	
	@PostMapping("/member/update")
	public String update(MemberDto dto) {
		int updateSuccess = dao.update(dto);
		return "redirect:/member/list";
	}
}
