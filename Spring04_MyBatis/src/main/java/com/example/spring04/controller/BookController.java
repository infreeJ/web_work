package com.example.spring04.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.spring04.dto.BookDto;
import com.example.spring04.service.BookService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BookController {
	
	private final BookService service;

	@GetMapping("/book/list")
	public String list(Model model) {
		List<BookDto> list = service.selectAll();
		model.addAttribute("list", list);
		return "book/list";
	}
	
	@GetMapping("/book/new-form")
	public String insertForm() {
		return "book/new-form";
	}
	
	@PostMapping("/book/save")
	public String insert(BookDto dto) {
		service.insert(dto);
		return "redirect:/book/list";
	}
	
	@GetMapping("/book/edit")
	public String updateForm(int num, Model model) {
		BookDto dto = service.getByNum(num);
		model.addAttribute("dto", dto);
		return "book/edit";
	}
	
	
	@PostMapping("/book/update")
	public String update(BookDto dto) {
		service.update(dto);
		return "redirect:/book/list";
	}
	
	@GetMapping("/book/delete")
	public String delete(int num) {
		service.deleteByNum(num);
		return "redirect:/book/list";
	}
	
}










