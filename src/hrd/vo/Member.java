package hrd.vo;

import java.sql.Date;

public class Member {
	
	private int custNo;
	private String custName;
	private String phone;
	private String address;
	private Date joinDate;
	private String grade;
	private String city;
	
	public Member() {
		// TODO Auto-generated constructor stub
	}
	
	public Member(int custNo, String custName, String phone, String address, Date joinDate, String grade, String city) {
		this.custNo = custNo;
		this.custName = custName;
		this.phone = phone;
		this.address = address;
		this.joinDate = joinDate;
		this.grade = grade;
		this.city = city;
	}
	public int getCustNo() {
		return custNo;
	}
	public String getCustName() {
		return custName;
	}
	public String getPhone() {
		return phone;
	}
	public String getAddress() {
		return address;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public String getGrade() {
		return grade;
	}
	public String getCity() {
		return city;
	}

	@Override
	public String toString() {
		return "Member [custNo = " + custNo + ", custName = " + custName + ", phone = " + phone + ", address = " + address
				+ ", joinDate = " + joinDate + ", grade = " + grade + ", city = " + city + "]<br>";
	}
	// .html에 출력할 때는 줄바꿈을 br태그로 해준다.
	
}
