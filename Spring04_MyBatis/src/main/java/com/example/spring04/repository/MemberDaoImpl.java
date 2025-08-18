package com.example.spring04.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.spring04.dto.MemberDto;

// Dao에는 보통 @Repository 어노테이션을 붙여서 bean을 만든다.(내부적으로 추가 기능을 제공해준다)
@Repository
public class MemberDaoImpl implements MemberDao{

	// MyBatis를 사용할 때 필요한 핵심 객체
	private final SqlSession session;
	
	// 생성자를 이용해서 의존 객체를 주입 받는 것이 더 일반적이다.
	// 생성자가 오직 1개인 경우에는 @Autowired는 생략 가능하다.
	public MemberDaoImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public void insert(MemberDto dto) {
		session.insert("member.insert", dto);
	}

	@Override
	public int update(MemberDto dto) {
		return session.update("member.update", dto);
	}

	@Override
	public int deleteByNum(int num) {
		return session.delete("member.deleteByNum", num);
	}

	/*
	 * select되는 row가 1개면 session.selectOne() 메서드 사용
	 * select되는 row가 여러 개일 가능성이 있으면 session.selectList() 메서드를 사용
	 * 
	 */
	@Override
	public MemberDto getByNum(int num) {
		MemberDto dto =  session.selectOne("member.getByNum", num);
		return dto;
	}
	
	/*
	 * selectList()의 리턴타입은 무조건 List<T>이다.
	 * List의 generic type T는 그때 그때 다르다.
	 * resultType이 바로 List의 generic type으로 설정된다.
	 */
	@Override
	public List<MemberDto> selectAll() {
		List<MemberDto> list = session.selectList("member.selectAll");
		return list;
	}
}


