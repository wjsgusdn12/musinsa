package com.hw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hw.dao.MemberDao;
import com.hw.dto.MemberDto;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDao mDao;
	
	@Override
	public void insertMember(String email, String id, String pw, String name, String address, String phone) {
		
		// 비밀번호 암호화
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPw = passwordEncoder.encode(pw);  // 비밀번호를 해시화하여 저장
		
		mDao.insertMember(email, id, encodedPw, name, address, phone);
	}

	@Override
	public int checkId(String id) {
		return mDao.checkId(id);
	}

	@Override
	public String selectId(String name, String phone) {
		return mDao.selectId(name, phone);
	}

	@Override
	public String selectPw(String id, String name, String phone) {
		return mDao.selectPw(id, name, phone);
	}

	@Override
	public int loginCheck(String id, String pw) {
	    System.out.println("시작");

	    // DB에서 암호화된 비밀번호를 가져옵니다.
	    String storedEncodedPw = mDao.getPasswordById(id);  // id로 DB에서 비밀번호를 가져오는 메소드
	    System.out.println("이 아이디 " + id + " 의 비밀번호 : " + storedEncodedPw);

	    // 입력된 비밀번호와 DB에 저장된 암호화된 비밀번호를 비교
	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	    System.out.println("비교시작");

	    // 평문 비밀번호와 DB에서 가져온 암호화된 비밀번호 비교
	    if (passwordEncoder.matches(pw, storedEncodedPw)) {
	        System.out.println("성공");
	        // 비밀번호가 일치하면 로그인 성공
	        return 1;  // 예: 1은 성공을 나타냄
	    } else {
	        System.out.println("실패");
	        // 비밀번호가 일치하지 않으면 로그인 실패
	        return 0;  // 예: 0은 실패를 나타냄
	    }
	}


	@Override
	public MemberDto selectMemberIdxAndName(String id) {
		return mDao.selectMemberIdxAndName(id);
	}

	@Override
	public void modifyPwAction(String id, String pw) {
	    // 평문 비밀번호를 BCrypt로 암호화
	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	    String encodedPw = passwordEncoder.encode(pw);  // 암호화된 비밀번호

	    // 암호화된 비밀번호를 DB에 저장
	    mDao.modifyPwAction(id, encodedPw);
	}

	@Override
	public void modifyMember(String id, String email, String name, String address, String phone) {
		mDao.modifyMember(id, email, name, address, phone);
	}

	@Override
	public void deleteMember(int loginMemberIdx) {
		mDao.deleteMember(loginMemberIdx);
	}

}
