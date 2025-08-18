package com.example.spring04.service;

import java.util.List;

import com.example.spring04.dto.BookDto;

public interface BookService {
	public List<BookDto> selectAll();
	public BookDto getByNum(int num);
	public void insert(BookDto dto);
	public void update(BookDto dto);
	public void deleteByNum(int num);
}
