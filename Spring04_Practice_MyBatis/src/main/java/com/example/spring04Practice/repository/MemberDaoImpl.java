package com.example.spring04Practice.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.spring04Practice.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSession session;

	@Override
	public MemberDto getByNum(int num) {
		MemberDto dto = session.selectOne("member.getBuNum", num);
		return dto;
	}
	
	@Override
	public int insert(MemberDto dto) {
		int insertSuccess = session.insert("member.insert", dto);
		return insertSuccess;
	}
	
	@Override
	public int update(MemberDto dto) {
		int updateSuccess = session.update("member.update", dto);
		return updateSuccess;
	}
	
	
	@Override
	public int deleteByNum(int num) {
		int deleteSuccess = session.delete("member.deleteByNum", num);
		return deleteSuccess;
	}

	@Override
	public List<MemberDto> selectAll() {
		List<MemberDto> list = session.selectList("member.selectAll");
		return list;
	}

}
