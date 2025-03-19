package com.hw.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hw.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void insertMember(String email, String id, String pw, String name, String address, String phone) {
		HashMap<String,String> info = new HashMap<String,String>();
		info.put("email", email);
		info.put("id", id);
		info.put("pw", pw);
		info.put("name", name);
		info.put("address", address);
		info.put("phone", phone);
		
		sqlSession.insert("MemberMapper.insertMember", info);
	}

	@Override
	public int checkId(String id) {
		HashMap<String,String> idCheck = new HashMap<String,String>();
		idCheck.put("id", id);
		
		int resultNum = sqlSession.selectOne("MemberMapper.selectMemberIdCheck",id);
		return resultNum;
	}

	@Override
	public String selectId(String name, String phone) {
		// 전화번호 형식 변경
	    if (phone != null && !phone.isEmpty()) {
	        phone = phone.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
	    }
		
		Map<String, Object> params = new HashMap<>();
	    params.put("name", name);
	    params.put("phone", phone);
		
		String id = sqlSession.selectOne("MemberMapper.selectId",params);
		return id;
	}
	
	@Override
	public String selectPw(String id, String name, String phone) {
		// 전화번호 형식 변경
	    if (phone != null && !phone.isEmpty()) {
	        phone = phone.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
	    }
		
		Map<String, Object> params = new HashMap<>();
	    params.put("id", id);
	    params.put("name", name);
	    params.put("phone", phone);
		
		String pw = sqlSession.selectOne("MemberMapper.selectPw",params);
		return pw;
	}

	@Override
	public int loginCheck(String id, String pw) {
		Map<String, String> value = new HashMap<>();
		value.put("id", id);
		value.put("pw", pw);
		
		int result = sqlSession.selectOne("MemberMapper.loginCheck", value);
		if(result==1) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public MemberDto selectMemberIdxAndName(String id) {
		Map<String, String> value = new HashMap<>();
		value.put("id", id);
		
		MemberDto result = sqlSession.selectOne("MemberMapper.selectMemberIdxAndName", value);
		return result;
	}

	@Override
	public String getPasswordById(String id) {
		return sqlSession.selectOne("MemberMapper.getPasswordById", id);
	}

	@Override
	public void modifyPwAction(String id, String pw) {
		Map<String, Object> value = new HashMap<>();
		value.put("id", id); 
		value.put("pw", pw); 
		sqlSession.update("MemberMapper.modifyPwAction", value);
	}

	@Override
	public void modifyMember(String id, String email, String name, String address, String phone) {
		Map<String, Object> value = new HashMap<>();
		value.put("id", id);
		value.put("email", email);
		value.put("name", name);
		value.put("address", address);
		value.put("phone", phone);
		sqlSession.update("MemberMapper.modifyMember", value);
	}
	
}
