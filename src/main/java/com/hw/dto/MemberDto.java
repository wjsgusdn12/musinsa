package com.hw.dto;

public class MemberDto {
	private int memberIdx;
	private String email;
	private String id;
	private String pw;
	private String name;
	private String address;
	private String phone;
	private String joinDate;
	private String profileImg;
	
	public MemberDto() {}
	
	public MemberDto(int memberIdx, String email, String id, String pw, String name, String address, String phone,
			String joinDate, String profileImg) {
		this.memberIdx = memberIdx;
		this.email = email;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.joinDate = joinDate;
		this.profileImg = profileImg;
	}
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	
}
