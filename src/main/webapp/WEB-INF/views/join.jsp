<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원가입 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/join.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ffab9c8a8eae4650d2b625d4d9fea3df&libraries=services"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(function(){
			$(".back_button").click(function(){
				location.href="login";
			});
			$(".join_button").click(function(){
				location.href="join";
			});
			$(".home_button").click(function(){
				location.href="index";
			});
			$(".submit_input").css('background-color','#EAEAEA');
			$(".submit_input").prop('disabled', true);
			$(".id_input, .pw_input, .email_input, .name_input, .address_input, .phone_input").keyup(function(){
				
				let inputId = $(".id_input").val();
				let inputPw = $(".pw_input").val();
				let inputEmail = $(".email_input").val();
				let inputName = $(".name_input").val();
				let inputAddress = $(".address_input").val();
				let inputPhone = $(".phone_input").val();
				
				if(inputId.length==0 || inputPw.length==0 || inputEmail.length==0
						|| inputName.length==0 || inputAddress.length==0 || inputPhone.length==0){
					$(".submit_input").css('background-color','#EAEAEA');
					$(".submit_input").prop('disabled', true);
				}else if(inputId.length!=0 && inputPw.length!=0 && inputEmail.length!=0
						&& inputName.length!=0 && inputAddress.length!=0 && inputPhone.length!=0){
					$(".submit_input").css('background-color','black');
					$(".submit_input").prop('disabled', false);
				}
			});
		});
		function check(){
			if($(".id_input").val()==''){ alert("아이디를 입력해주세요"); return false; }
			if($(".pw_input").val()==''){ alert("비밀번호를 입력해주세요"); return false; }
			if($(".email_input").val()==''){ alert("이메일 입력해주세요"); return false; }
			if($(".name_input").val()==''){ alert("이름을 입력해주세요"); return false; }
			if($(".address_input").val()==''){ alert("주소를 입력해주세요"); return false; }
			if($(".phone_input").val()==''){ alert("연락처를 입력해주세요"); return false; }
			if(!$(".check_one").is(":checked")){ alert("개인정보 수집 이용동의를 체크해주세요"); return false; }
			if(!$(".check_two").is(":checked")){ alert("무신사스토어 이용약관을 체크해주세요"); return false; }
		}
		
		$(document).ready(function(){
            // 버튼 클릭 시 주소 검색 창 열기
            $("#searchAddressBtn").click(function(){
                openPostcode();
            });

            // 카카오 주소 API 호출
            function openPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 사용자가 선택한 주소 정보를 해당 필드에 삽입
                        var postcode = data.zonecode;
                        var address = data.address;
                        var extraAddress = '';

                        // 참고 항목: 1차 주소와 2차 주소를 나누어줍니다.
                        if (data.addressType === 'R') {
                            if (data.bname !== '') {
                                extraAddress += data.bname;
                            }
                            if (data.buildingName !== '') {
                                extraAddress += (extraAddress !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            address += (extraAddress !== '' ? ' (' + extraAddress + ')' : '');
                        }

                        // 우편번호와 주소 정보를 입력
                        document.getElementById('postcode').value = postcode;
                        document.getElementById('address').value = address;
                        document.getElementById('detailAddress').focus();
                    }
                }).open();
            }
        });
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
<body class="wrap">
	<div class="main_area">
		<div class="main_top">
			<div class="main_top_left">
				<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
			<div style="display:none;" class="main_top_right">
				<svg class="home_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<h1 class="header_text"><b>MUSINSA</b></h1>
			<h1 class="header_text"><b>회원가입</b></h1>
			<c:if test="${not empty errorMessage}">
			    <script>
			        alert("${errorMessage}");
			    </script>
			</c:if>
			<form action="join_action" method="post">
				<b>아이디</b><b style="color:red; margin-left:2.5px;">*</b><br/>
				<input class="id_input" type="text" name="id" placeholder="아이디 입력"/>
				<b>비밀번호</b><b style="color:red; margin-left:2.5px;">*</b><br/>
				<input class="pw_input" type="password" name="pw" placeholder="비밀번호 입력"/>
				<b>이메일</b><b style="color:red; margin-left:2.5px;">*</b><br/>
				<input class="email_input" type="text" name="email" placeholder="이메일 입력"/>
				<b>이름</b><b style="color:red; margin-left:2.5px;">*</b><br/>
				<input class="name_input" type="text" name="name" placeholder="이름 입력"/>
				
				<!-- 카카오 주소 api -->
				<b>주소</b><b style="color:red; margin-left:2.5px;">*</b><br/>
				<!-- <input class="address_input" type="text" name="address" placeholder="주소 입력"/> -->
		        <input class="address_input" type="text" id="postcode" name="postcode" readonly placeholder="우편번호">
		        <input class="address_input" type="text" id="address" name="address" readonly placeholder="주소">
		        <input class="address_input" type="text" id="detailAddress" name="detailAddress" placeholder="상세 주소">
			    <input type="button" class="address_input_button" id="searchAddressBtn" value="주소 검색"/>
				<!-- 카카오 주소 api -->
				
				<b>연락처</b><b style="color:red; margin-left:2.5px;">*</b><br/>
				<input class="phone_input" type="text" name="phone" placeholder="연락처 입력"/>
				<div class="check_div"><input class="check_one" type="checkbox"/>개인정보 수집 이용동의(필수)<br/></div>
				<div class="check_div"><input class="check_two" type="checkbox"/>무신사 무신사스토어 이용약관(필수)<br/></div>
				<input onclick="return check();" class="submit_input" type="submit" value="회원가입"/>
			</form>
		</div>
	</div>
</body>
	<script>
	    // 페이지 로드 시, .wrap 요소의 높이를 화면 크기에 맞게 설정
	    document.querySelector(".wrap").style.height = window.innerHeight + "px";
	</script>
</html>