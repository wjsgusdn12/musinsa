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
		$(function(){
			$(".back_button").click(function(){
				location.href="login";
			});
			$(".home_button").click(function(){
				location.href="index";
			});
			$(".submit_input").css('background-color','#EAEAEA');
			$(".submit_input").prop('disabled', true);
			$(".name_input, .phone_input, id_input").keyup(function(){
				let inputName = $(".name_input").val();
				let inputPhone = $(".phone_input").val();
				let inputId = $(".id_input").val();
				if(inputName.length==0 || inputPhone.length==0 || inputId.length==0){
					$(".submit_input").css('background-color','#EAEAEA');
					$(".submit_input").prop('disabled', true);
				}else if(inputName.length!=0 && inputPhone.length!=0 && inputId.length!=0){
					$(".submit_input").css('background-color','black');
					$(".submit_input").prop('disabled', false);
				}
			});
		});
		function check(){
			if($(".name_input").val()==''){
				alert("이름을 입력해주세요");
				return false;
			}
			if($(".phone_input").val()==''){
				alert("연락처를 입력해주세요");
				return false;
			}
			if($(".id_input").val()==''){
				alert("아이디를 입력해주세요");
				return false;
			}
		}
		$(function() {
	        $(".phone_input").on("input", function() {
	            let phone = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 남기기

	            // 전화번호 길이가 11자리 이하인 경우에만 포맷 적용
	            if (phone.length <= 11) {
	                if (phone.length <= 3) {
	                    $(this).val(phone); // 처음 3자리는 하이픈 없이 입력
	                } else if (phone.length <= 6) {
	                    $(this).val(phone.replace(/(\d{3})(\d{0,4})/, "$1-$2")); // 4자리는 - 추가
	                } else if (phone.length <= 10) {
	                    $(this).val(phone.replace(/(\d{3})(\d{3})(\d{0,4})/, "$1-$2-$3")); // 7자리는 - 추가
	                } else if (phone.length == 10) {
	                    $(this).val(phone.replace(/(\d{3})(\d{3})(\d{0,4})/, "$1-$2-$3"));
	                } else if (phone.length == 11) {
	                    $(this).val(phone.replace(/(\d{3})(\d{4})(\d{0,4})/, "$1-$2-$3"));
	                } else {
	                    $(this).val(phone.replace(/(\d{3})(\d{3})(\d{4})/, "$1-$2-$3"));
	                }
	            } else {
	                // 11자리를 초과하면 더 이상 입력하지 못하도록 제한
	                $(this).val(phone.substring(0, 11).replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
	            }
	        });
	        // keyup 이벤트에서 비교
	        $(".email_input, .name_input, .address_input, .phone_input").keyup(function() {
	            toggleSubmitButton();
	        });
	        // 버튼 비활성화/활성화 기능
	        function toggleSubmitButton() {
	            let sessionEmail = "${sessionScope.loginMemberEmail}";
	            let sessionName = "${sessionScope.loginMemberName}";
	            let sessionAddress = "${sessionScope.loginMemberAddress}";
	            let sessionPhone = "${sessionScope.loginMemberPhone}";

	            let inputEmail = $(".email_input").val();
	            let inputName = $(".name_input").val();
	            let inputAddress = $(".address_input").val();
	            let inputPhone = $(".phone_input").val();
	            let inputId = "${sessionScope.loginMemberId}";

	            // 모든 값이 세션 값과 같으면 버튼 비활성화
	            if (inputEmail === sessionEmail &&
	                inputName === sessionName &&
	                inputAddress === sessionAddress &&
	                inputPhone === sessionPhone) {
	                $(".submit_input").css('background-color','#EAEAEA');
	                $(".submit_input").prop('disabled', true);
	            } else {
	                $(".submit_input").css('background-color','black');
	                $(".submit_input").prop('disabled', false);
	            }
	        }
	        // 초기 상태 확인
	        toggleSubmitButton();
	    });
	</script>
</head>
<body>
	<div class="main_area">
		<div class="main_top">
			<div class="main_top_left">
				<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
				<b>비밀번호 찾기</b>
			</div>
			<div class="main_top_right">
				<svg class="home_button" width="28" height="28" viewBox="0 0 28 28" display="none">
				<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<b style="color:red;" >테스트계정 ↓<br/> 아이디 : test<br/>이름 : 테스트<br/>연락처 : 010-9999-9999</b><br/>
			<form action="find_pw_action" method="post">
				<input class="id_input" type="text" name="id" placeholder="아이디"/>
				<input class="name_input" type="text" name="name" placeholder="이름"/>
				<input class="phone_input" type="text" name="phone" placeholder="연락처"/>
				<input onclick="return check();" class="submit_input" type="submit" value="비밀번호 찾기"/>
			</form>
		</div>
	</div>
</body>
</html>