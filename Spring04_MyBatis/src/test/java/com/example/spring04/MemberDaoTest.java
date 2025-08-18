package com.example.spring04;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.example.spring04.dto.MemberDto;
import com.example.spring04.repository.MemberDao;

@SpringBootTest
@Transactional // 트랜잭션을 관리하도록 하고
@Rollback // insert, update, delete 등의 동작은 rollback 되도록 한다.
public class MemberDaoTest {
	// 필요한 의존 객체 주입받기
	@Autowired
	private MemberDao dao;
	
	@Test
	@DisplayName("회원 목록 테스트")
	void selectAll() {
		// 테이터를 추가하고
		int num = insertFixture("acorn", "seoul");
		List<MemberDto> list = dao.selectAll();
		boolean isExist = false;
		for(MemberDto tmp:list) {
			if(tmp.getNum() == num) {
				isExist = true; // 하나라도 true가 나오면 값을 변수에 담고
				break; // 반복문 탈출
			}
		}
		assertTrue(isExist);
	}
	
	
	@Test
	@DisplayName("회원 목록 테스트")
	void selectAll2() {
		// 테이터를 추가하고
		int num = insertFixture("acorn", "seoul");
		List<MemberDto> list = dao.selectAll();
		/*
		 * item.getNum() == num이 하나라도 true가 있다면 (하나라도 일치한다면)
		 * true를 리턴하는 메서드가 .anyMatch() 메서드이다.
		 * 
		 */
		boolean isExist = list.stream().anyMatch(item -> item.getNum() == num);
		assertTrue(isExist);
	}
	
	
	@Test
	@DisplayName("회원정보 수정 테스트")
	void update() {
		int num = insertFixture("acorn", "seoul");
		MemberDto dto = dao.getByNum(num);
		// 필드 수정
		dto.setName("acorn2");
		dto.setAddr("seoul2");
		int rows = dao.update(dto);
		MemberDto dto2 = dao.getByNum(num);
		
		assertEquals(1, rows);
		assertEquals("acorn2", dto.getName());
		assertEquals("seoul2", dto.getAddr());
		
	}
	
	
	@Test
	@DisplayName("회원정보 삭제 테스트")
	void delete() {
		int num = insertFixture("acorn", "seoul");
		// 삭제하고 삭제된 row의 개수를 리턴받는다.
		int rows = dao.deleteByNum(num);
		// 삭제된 row의 개수는 반드시 1이여야 한다.
		assertEquals(1, rows);
		// select된 정보는 반드시 null이어야 한다.
		assertNull(dao.getByNum(num));
	}
	
	@Test
	@DisplayName("MemberDao가 bean으로 관리되는지 테스트")
	void test01() {
		assertNotNull(dao);
	}
	
	// 이름과 주소를 전달하면 전달된 정보를 DB에 저장하고 해당 정보의 PK를 리턴하는 메서드
	int insertFixture(String name, String addr) {
		MemberDto dto = new MemberDto();
		dto.setName(name);
		dto.setAddr(addr);
		// mybatis에서 selectKey 설정을 했기 때문에 insert하고 나면 dto 객체에 추가한 회원의 번호가 들어있다.
		dao.insert(dto);
		
		return dto.getNum();
	}
	
	@Test
	@DisplayName("회원정보 추가 테스트")
	void insert() {
		int num = insertFixture("acorn", "seoul");
		
		// 데이터가 잘 들어갔는지 select 해보기
		MemberDto found = dao.getByNum(num);
		// select된 정보가 null이 아니여야 한다.
		assertNotNull(found);
		// select된 정보의 name이 반드시 "acorn"이여야 한다.
		assertEquals("acorn", found.getName());
		// select된 정보의 addr이 반드시 "seoul"이여야 한다.
		assertEquals("seoul", found.getAddr());
	}
}
