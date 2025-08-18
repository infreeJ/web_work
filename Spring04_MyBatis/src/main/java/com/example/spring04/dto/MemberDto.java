package com.example.spring04.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("memberDto") // MyBatis에서 제공하는 어노테이션. Mapper.mxl 문서의 MemberDto type에 별칭을 부여할 수 있다
@Setter
@Getter
public class MemberDto {
	private int num;
	private String name;
	private String addr;
}