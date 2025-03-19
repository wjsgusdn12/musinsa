<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호찾기 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/login.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function() {
			$(".back_button").click(function() {
				history.back();
			});
			$(".home_button").click(function() {
				location.href="index";
			});
			$(".submit_input").css('background-color','#EAEAEA');
			$(".submit_input").prop('disabled', true);
			$(".name_input, .phone_input").keyup(function() {
				let inputName = $(".name_input").val();
				let inputPhone = $(".phone_input").val();
				if (inputName.length == 0 || inputPhone.length == 0) {
					$(".submit_input").css('background-color','#EAEAEA');
					$(".submit_input").prop('disabled', true);
				} else if (inputName.length != 0 && inputPhone.length != 0) {
					$(".submit_input").css('background-color','black');
					$(".submit_input").prop('disabled', false);
				}
			});
		});

		function check(event) {
		    event.preventDefault(); // 기본 form submit을 막음

		    let newPw = $(".new_pw").val();
		    let newPwCheck = $(".new_pw_check").val();

		    // 새 비밀번호와 새 비밀번호 확인이 일치하는지 확인
		    if (newPw != newPwCheck) {
		        alert("새 비밀번호 입력이 불일치 합니다. 다시 입력 해주세요.");
		        return false;
		    }

		    let id = '${id}';
		    let beforePw = '${pw}';  // 서버에서 가져온 해시화된 기존 비밀번호

		    // 새 비밀번호와 기존 비밀번호가 같으면 변경 불가
		    if (newPw === beforePw) {
		        alert("변경할 비밀번호와 기존 비밀번호가 같습니다.");
		        return false;
		    }

		    // 비밀번호가 다르면 서버로 비밀번호 변경 요청
		    $.ajax({
		        url: 'modifyPwAction',
		        type: 'post',
		        data: {
		            "pw": newPw,  // 평문 비밀번호를 전송
		            "id": id
		        },
		        success: function (res) {
		            alert("비밀번호 변경에 성공하였습니다.");
		            location.href = "login";  // 로그인 페이지로 리디렉션
		        },
		        error: function (r, s, e) {
		            alert("비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
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
				<b>비밀번호 변경</b>
			</div>
			<div class="main_top_right">
				<svg class="home_button" width="28" height="28" viewBox="0 0 28 28" display="none">
				<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<b style="color:red;" >테스트계정 비밀번호 변경 ↓<br/>새 비밀번호 : test123<br/>새 비밀번호 확인 : test123</b><br/>
			<form onsubmit="check(event)">
				<input class="name_input new_pw" type="text" name="newPw" placeholder="새 비밀번호"/>
				<input class="phone_input new_pw_check" type="text" name="newPwCheck" placeholder="새 비밀번호 확인"/>
				<input class="submit_input" type="submit" value="완료"/>
			</form>
		</div>
	</div>
</body>
</html>
