<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>로그인 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/login.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function(){
			$(".back_button").click(function(){
				location.href="/musinsa";
			});
			$(".home_button").click(function(){
				location.href="index";
			});
			$(".join_button").click(function(){
				location.href="join";
			});
			$(".find_id").click(function(){
				location.href="find_id";
			});
			$(".find_pw").click(function(){
				location.href="find_pw";
			});
			$(".submit_input").css('background-color','#EAEAEA');
			$(".submit_input").prop('disabled', true);
			$(".id_input, .pw_input").keyup(function(){
				
				let inputId = $(".id_input").val();
				let inputPw = $(".pw_input").val();
				
				if(inputId.length==0 || inputPw.length==0){
					$(".submit_input").css('background-color','#EAEAEA');
					$(".submit_input").prop('disabled', true);
				}else if(inputId.length!=0 && inputPw.length!=0){
					$(".submit_input").css('background-color','black');
					$(".submit_input").prop('disabled', false);
				}
				if (event.key === "Enter") {
		            check();
		        }
			});
		});
		function check(){
			if($(".id_input").val()==''){
				alert("아이디를 입력해주세요");
				return false;
			}
			if($(".pw_input").val()==''){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			let id = $(".id_input").val();
			let pw = $(".pw_input").val();
			
			$.ajax({
			    url: 'loginCheck',
			    type: 'post',
			    data: ({
			        "id": id,
			        "pw": pw
			    }),
			    success: function(res) {
			        if (res == 1) {
			            alert("환영합니다, " + id + " 님!");
			            location.href = "index";
			        } else {
			            alert("로그인 정보가 잘못되었습니다.");
			            location.href = "login";
			        }
			    },
			    error: function(r, s, e) {
			        console.log("Error:", r, s, e);
			        alert("error");
			    }
			});
		}
	</script>
</head>
<body>
	<div class="main_area">
		<div class="main_top">
			<div class="main_top_left">
				<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
				<b>로그인/회원가입</b>
			</div>
			<div class="main_top_right">
				<svg class="home_button" width="28" height="28" viewBox="0 0 28 28" display="none">
				<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<c:if test="${not empty successMessage}">
			    <script>
			        alert("${successMessage}");
			    </script>
			</c:if>
			<b style="color:red;" >테스트계정 ↓<br/> 아이디 : test<br/>비밀번호 : 1234</b><br/>
			<form action="login_action" method="post">
				<input class="id_input" type="text" name="id" placeholder="아이디"/>
				<input class="pw_input" type="password" name="pw" placeholder="비밀번호"/>
				<input onclick="return check();" class="submit_input" type="button" value="로그인"/>
			</form>
			<div class="join_or_find">
				<input class="join_button" type="button" value="회원가입"/>
				<span class="find_id">아이디 찾기</span>
				<span class="find_pw">비밀번호 찾기</span>
			</div>
		</div>
	</div>
</body>
</html>