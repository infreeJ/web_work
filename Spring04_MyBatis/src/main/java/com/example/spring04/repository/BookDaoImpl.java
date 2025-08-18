package com.example.spring04.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.example.spring04.dto.BookDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BookDaoImpl implements BookDao{

	private final SqlSession session;
	
	@Override
	public List<BookDto> selectAll() {
		List<BookDto> list = session.selectList("book.selectAll");
		return list;
	}

	@Override
	public BookDto getByNum(int num) {
		BookDto dto = session.selectOne("book.getByNum", num);
		return dto;
	}

	@Override
	public int insert(BookDto dto) {
		return session.insert("book.insert", dto);
	}

	@Override
	public int update(BookDto dto) {
		return session.update("book.update", dto);
	}

	@Override
	public int deleteByNum(int num) {
		return session.delete("book.deleteByNum", num);
	}

}
