<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	let id = '${id}';
	let name = '${name}';
	let phone = '${phone}';
	let pw = '${pw}';
	if(pw==''){
		alert("입력하신 정보가 잘못되었습니다");
		location.href="find_pw";
	}else{
		alert("찾으신 아이디 "+id+" 의 비밀번호를 재설정 해주세요");
		location.href="modify_pw?id="+encodeURIComponent(id)+"&name="+encodeURIComponent(name)+"&phone="+phone;
	}
</script>