package com.hw.dao;

import com.hw.dto.MemberDto;

public interface MemberDao {
	void insertMember(String email, String id, String pw, String name, String address, String phone);
	int checkId(String id);
	String selectId(String name, String phone);
	String selectPw(String id, String name, String phone);
	int loginCheck(String id, String pw);
	MemberDto selectMemberIdxAndName(String id);
	String getPasswordById(String id);
	void modifyPwAction(String id, String pw);
	void modifyMember(String id, String email, String name, String address, String phone);
}
