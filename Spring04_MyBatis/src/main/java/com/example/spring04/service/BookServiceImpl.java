package com.example.spring04.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.spring04.dto.BookDto;
import com.example.spring04.exception.BookException;
import com.example.spring04.repository.BookDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService{

	private final BookDao dao;
	
	@Override
	public List<BookDto> selectAll() {
		return dao.selectAll();
	}

	@Override
	public BookDto getByNum(int num) {
		BookDto dto = dao.getByNum(num);
		if(dto == null) {
			throw BookException.notFound(num);
		}
		return dto;
	}

	@Override
	public void insert(BookDto dto) {
		dao.insert(dto);
	}

	@Override
	public void update(BookDto dto) {
		int rowCount = dao.update(dto);
		if(rowCount == 0) {
			throw BookException.updateFailed(dto.getNum());
		}
	}

	@Override
	public void deleteByNum(int num) {
		int rowCount = dao.deleteByNum(num);
		if(rowCount == 0) {
			throw BookException.deleteFailed(num);
		}
	}

}
