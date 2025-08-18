package com.example.spring04.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.spring04.dto.MemberDto;
import com.example.spring04.exception.MemberException;
import com.example.spring04.exception.MemberException.Reason;
import com.example.spring04.repository.MemberDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	// 의존 객체에 final 예약어를 붙이고 클래스에
	// @RequiredArgsConstructor를 붙이면
	// 의존 객체를 전달받는 생성자가 자동으로 만들어진다.
	private final MemberDao dao;
	
	@Override
	public List<MemberDto> getAll() {
		return dao.selectAll();
	}

	@Override
	public MemberDto getMember(int num) {
		MemberDto dto = dao.getByNum(num);
		if(dto == null) {
			// 예외 발생 시키기
			throw MemberException.notFound(num);
		}
		return dto;
	}

	@Override
	public void addMember(MemberDto dto) {
		/*
		 * insert 과정에서 SQLException이 발생하면 자동으로 DataAccessException이 발생한다.
		 * dao에 붙여놓은 @Repository 어노테이션 때문에
		 */
		dao.insert(dto);
	}

	@Override
	public void updateMember(MemberDto dto) {
		int rowCount = dao.update(dto);
		if(rowCount == 0) {
			throw MemberException.updateFailed(dto.getNum());
		}
	}

	@Override
	public void deleteMember(int num) {
		int rowCount = dao.deleteByNum(num);
		if(rowCount == 0) {
			throw MemberException.deleteFailed(num);
		}
	}

}
