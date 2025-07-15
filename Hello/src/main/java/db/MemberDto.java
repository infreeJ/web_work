package db;

public class MemberDto {
	private int num;
	private String name;
	private String addr;
	
	public void setNum(int num) {
		this.num = num;
	}
	
	public int getNum() {
		return num;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getAddr() {
		return addr;
	}
}
