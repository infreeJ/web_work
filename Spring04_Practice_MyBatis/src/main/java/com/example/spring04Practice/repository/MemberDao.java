package com.example.spring04Practice.repository;

import java.util.List;

import com.example.spring04Practice.dto.MemberDto;

public interface MemberDao {
	public MemberDto getByNum(int num);
	public List<MemberDto> selectAll();
	public int insert(MemberDto dto);
	public int update(MemberDto dto);
	public int deleteByNum(int num);
}
