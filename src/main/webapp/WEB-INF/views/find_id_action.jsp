<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	let id = '${id}';
	if(id==''){
		alert("입력하신 정보가 잘못되었습니다");
		location.href="find_id";
	}else{
		alert("찾으신 계정의 아이디는 "+id+" 입니다.");
		location.href="login";
	}
</script>