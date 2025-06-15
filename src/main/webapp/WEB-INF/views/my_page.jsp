<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>마이 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/likes.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/my_page.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function(){
			$(".center_div.likes").click(function(){
				location.href="likes";
			});
			$(".center_div.my").click(function(){
				location.href="my_page";
			});
			$(".center_div.home").click(function(){
				location.href="index";
			});
			$(".cart_logo").click(function(){
				location.href="cart";
			});
			$(".home_button.real_button").click(function(){
				location.href="index";
			});
			$(".input_button").click(function(){
				let id = '${sessionScope.loginMemberId}';
				let name = '${sessionScope.loginMemberName}';
				let phone = '${sessionScope.loginMemberPhone}';
				if($(this).hasClass("info")){
					location.href="modify_member";
				}else if($(this).hasClass("pw")){
					location.href="modify_pw?id="+encodeURIComponent(id)+"&name="+encodeURIComponent(name)+"&phone="+phone;
				}else if($(this).hasClass("order")){
					location.href="order_detail";
				}else if($(this).hasClass("ask")){
					location.href="my_ask";
				}
			});
		});
		// 이름 필터링 함수 (첫 글자는 그대로 두고 나머지 글자는 *** 처리)
        function filterName(name) {
            let filteredName = name.charAt(0);  // 첫 글자는 그대로 남겨두기
            filteredName += "***";  // 나머지 글자는 ***
            return filteredName;
        }

        // ID 필터링 함수 (첫 3자리만 노출하고 나머지 *** 처리)
        function filterId(id) {
            let filteredId = id.substring(0, 3);  // 첫 3자만 표시
            filteredId += "***";  // 나머지 글자는 ***
            return filteredId;
        }

        // 주소 필터링 함수
        function filterAddress(address) {
            const addressParts = address.split(" ");
            let city = addressParts[0];
            let filteredAddress = city;

            for (let i = 1; i < addressParts.length; i++) {
                let part = addressParts[i];

                // 시, 군, 구, 읍, 면, 동, 리는 그대로 두고 나머지는 ***
                if (part.includes("시") || part.includes("군") || part.includes("구") || 
                    part.includes("읍") || part.includes("면") || part.includes("동") || part.includes("리")) {
                    filteredAddress += " " + part;
                } else {
                    filteredAddress += " ***";
                }
            }
            return filteredAddress;
        }
        
     	// 이메일 필터링 함수 (로컬 부분은 ***, 도메인과 TLD는 처리)
        function filterEmail(email) {
            let emailParts = email.split("@");
            let localPart = emailParts[0];  // @ 앞부분
            let domainPart = emailParts[1];  // @ 뒷부분

            let filteredLocalPart = localPart.substring(0, 3);  // 첫 3자리만 남기고 나머지는 ***
            filteredLocalPart += "***";  // 나머지 부분 *** 처리

            // 도메인 앞부분만 *** 처리하고, 도메인 뒤부분(TLD)만 보여줌
            let domainParts = domainPart.split(".");
            let filteredDomainPart = "***" + "." + domainParts[domainParts.length - 1];  // 도메인 앞부분은 *** 처리하고, 뒤는 그대로

            return filteredLocalPart + "@" + filteredDomainPart;
        }

        $(document).ready(function() {
            // 이름 필터링
            let originalName = "${sessionScope.loginMemberName}"; // 세션에서 이름 가져오기
            let filteredName = filterName(originalName);
            $("#filteredName").text(filteredName);  // 필터링된 이름 표시

            // ID 필터링
            let originalId = "${sessionScope.loginMemberId}"; // 세션에서 ID 가져오기
            let filteredId = filterId(originalId);
            $("#filteredId").text(filteredId);  // 필터링된 ID 표시

            // 주소 필터링
            let originalAddress = "${sessionScope.loginMemberAddress}"; // 세션에서 주소 가져오기
            let filteredAddress = filterAddress(originalAddress);
            $("#filteredAddress").text(filteredAddress);  // 필터링된 주소 표시

            // 전화번호 필터링
            let phone = "${sessionScope.loginMemberPhone}";
            let filteredPhone = phone.replace(/\d{4}$/, "****");
            $("#filteredPhone").text(filteredPhone);  // 필터링된 전화번호 표시

         	// 이메일 필터링
            let email = "${sessionScope.loginMemberEmail}";
            let filteredEmail = filterEmail(email);
            $("#filteredEmail").text(filteredEmail);  // 필터링된 이메일 표시
        });
	</script>
</head>
<body class="wrap">
	<b style="display:flex; align-items:center; justify-content:center; font-size:25px; margin-bottom:5px;"><a style="position:relative; top:0; right:0;" href="https://www.notion.so/api-21159556933c80b6b2cafa4dbdb89899">☞ API명세 바로가기 ☜</a></b>
	<div class="main_top">
		<div class="main_top_left">
			<b class="home_button">마이</b>
		</div>
		<div class="main_top_right">
			<svg class="home_button real_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
			<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
		</div>
	</div>
	<div class="main_area">
		<div class="main_content">
			<!-- 로그인계정이 아닐 경우 -->
			<!-- <div class="do_not_have_likes">
				<b>로그인이 필요한 페이지 입니다.</b><br/>
				<a href="login">로그인하러 가기</a>
			</div> -->
			<!-- 로그인계정이 아닐 경우 -->
			<div class="member_info_area">
				<div><b class="member_info_my_page">이름</b> <p id="filteredName">${sessionScope.loginMemberName}</p></div>
		        <div><b class="member_info_my_page">ID</b> <p id="filteredId">${sessionScope.loginMemberId}</p></div>
		        <div><b class="member_info_my_page">연락처</b> <p id="filteredPhone">${sessionScope.loginMemberPhone}</p></div>
		        <div><b class="member_info_my_page">이메일</b> <p id="filteredEmail">${sessionScope.loginMemberEmail}</p></div>
		        <div><b class="member_info_my_page">주소</b> <p id="filteredAddress">${sessionScope.loginMemberAddress}</p></div>
			</div>
			<input class="input_button info" type="button" value="회원정보 변경"/>
			<input class="input_button pw" type="button" value="비밀번호 변경"/>
			<input class="input_button order" type="button" value="주문 내역"/>
			<input class="input_button ask" type="button" value="문의 내역"/>
			<a href="logout">로그아웃</a>
		</div>
	</div>
	<div class="main_footer">
		<div class="center_div likes">
			<div><svg class="_gnb__icon_1h8bp_46" width="29" height="28" viewBox="0 0 29 28" fill="none"><path d="M14.3072 22.9324C14.4197 23.0304 14.5803 23.0304 14.6928 22.9324C15.7682 21.9958 21.0547 17.3708 23.25 15.05C24.16 14 25 12.6 25 10.5C25 7.35002 22.9 4.90002 19.75 4.90002C17.09 4.90002 15.62 6.51002 14.5 8.40002C13.38 6.51002 11.91 4.90002 9.25 4.90002C6.1 4.90002 4 7.35002 4 10.5C4 12.6 4.84 14 5.75 15.05C7.94531 17.3708 13.2318 21.9958 14.3072 22.9324Z" stroke="currentColor" stroke-width="1.4" stroke-miterlimit="10"></path></svg></div>
			<div>좋아요</div>
		</div>
		<div class="center_div home">
			<div><svg class="_gnb__icon_1h8bp_46" width="29" height="28" viewBox="0 0 29 28" fill="none"><path d="M14.5 23.8H5.81999C5.58803 23.8 5.39999 23.6119 5.39999 23.38V11.0632C5.39999 10.9292 5.46397 10.8032 5.57219 10.7241L14.2522 4.38107C14.3998 4.27321 14.6002 4.27321 14.7478 4.38107L23.4278 10.7241C23.536 10.8032 23.6 10.9292 23.6 11.0632V23.38C23.6 23.6119 23.412 23.8 23.18 23.8H14.5ZM14.5 23.8V14.5055" stroke="currentColor" stroke-width="1.4"></path><clipPath><rect width="28" height="28" fill="white" transform="translate(0.5)"></rect></clipPath></svg></div>
			<div>무신사 홈</div>
		</div>
		<div class="center_div my">
			<div><svg class="_gnb__icon_1h8bp_46" width="29" height="28" viewBox="0 0 29 28" fill="none"><path d="M5.39999 23.1V20.3C5.39999 17.9804 7.2804 16.1 9.59999 16.1H19.4C21.7196 16.1 23.6 17.9804 23.6 20.3V23.1M18.35 8.75002C18.35 10.8763 16.6263 12.6 14.5 12.6C12.3737 12.6 10.65 10.8763 10.65 8.75002C10.65 6.62373 12.3737 4.90002 14.5 4.90002C16.6263 4.90002 18.35 6.62373 18.35 8.75002Z" stroke="currentColor" stroke-width="1.4"></path></svg></div>
			<div>마이</div>
		</div>
	</div>
</body>
	<script>
	    // 페이지 로드 시, .wrap 요소의 높이를 화면 크기에 맞게 설정
	    document.querySelector(".wrap").style.height = window.innerHeight + "px";
	</script>
</html>