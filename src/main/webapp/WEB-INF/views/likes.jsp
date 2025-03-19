<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>좋아요 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/likes.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function(){
			$(".like_heart").css({
	            "stroke": "#ff002d",           // 하트의 외곽선 색상
	            "fill": "#ff0000",             // 하트의 채우기 색상
	            "fill-opacity": "1"            // 채우기 불투명도
	        });
			$(".center_div.likes").click(function(){
				location.href="likes";
			});
			$(".center_div.my").click(function(){
				location.href="my_page";
			});
			$(".center_div.home").click(function(){
				location.href="index";
			});
			 // 장바구니 버튼
		    $(".cart_logo, .selectCartQuantity").click(function(){
		        location.href="cart";
		    });
			$(".item_main_div").click(function(){
			    let itemIdx = $(this).attr("item_idx"); // 클릭한 상품의 idx
			    let isLiked = $(this).find(".like_heart"); // 해당 상품의 하트 상태
			    let likeStatus = isLiked.hasClass("on") ? 1 : 0; // 하트가 'on' 클래스가 있으면 좋아요 상태(1), 없으면 비어 있음(0)

			    // 먼저 서버에 isLiked 상태를 세션에 저장하도록 AJAX 요청
			    $.ajax({
			        url: 'saveLikeStatus', // 서버에 좋아요 상태 저장하는 API 호출
			        type: 'post',
			        data: {
			            "isLiked": likeStatus // 저장할 좋아요 상태
			        },
			        success: function(response) {
			            // 세션에 저장 후, 상세 페이지로 이동
			            location.href = "detail?productIdx=" + itemIdx;
			        },
			        error: function(r, s, e) {
			            console.log("세션 저장 error: ", r, s, e);
			            alert("좋아요 상태 저장 중 오류가 발생했습니다.");
			        }
			    });
			});
			$(".product_like").click(function(event) {
				let productIdx = $(this).closest('.item_main_div').attr("item_idx");
		        let loginMemberIdx = ${sessionScope.loginMemberIdx};
			    event.stopPropagation();

			    // .product_like에 on 클래스 추가/제거
			    $(this).toggleClass("on");

			    // 그 안의 .like_heart에 on 클래스 추가/제거
			    $(this).find(".like_heart").toggleClass("on");

			    // .like_heart의 색상 및 스타일을 변경 (클릭 시마다)
			    if ($(this).hasClass("on")) {
			        $(this).find(".like_heart").css({
			            "stroke": "#ff002d",           // 하트의 외곽선 색상
			            "fill": "#ff0000",             // 하트의 채우기 색상
			            "fill-opacity": "1"            // 채우기 불투명도
			        });

			        $.ajax({
			        	url:'likeProduct',
			        	type:'post',
			        	data:{
			        		"productIdx": productIdx,
			        		"loginMemberIdx": ${sessionScope.loginMemberIdx},
			                "likeStatus": true // 좋아요 추가
			        	},
			        	success:function(res){
			        	},
			        	error:function(r,s,e){
			        		console.log("error : ", r, s, e);
			        		alert("error!");
			        	}
			        });
			        
			    } else {
			        $(this).find(".like_heart").css({
			            "stroke": "",                 // 원래 외곽선 색상
			            "fill": "",                   // 원래 채우기 색상
			            "fill-opacity": "0.3"          // 원래 채우기 불투명도
			        });
			        
			        $.ajax({
			        	url:'likeProduct',
			        	type:'post',
			        	data:{
			        		"productIdx": productIdx,
			        		"loginMemberIdx": ${sessionScope.loginMemberIdx},
			                "likeStatus": false // 좋아요 제거
			        	},
			        	success:function(res){
			        	},
			        	error:function(r,s,e){
			        		console.log("error : ", r, s, e);
			        		alert("error!");
			        	}
			        });
			    }
			});
		});
	</script>
</head>
<body>
	<div class="main_area">
		<div class="main_top">
			<div class="main_top_left">
				<b class="home_button">좋아요</b>
			</div>
			<div class="main_top_right">
				<div class="selectCartQuantity">
					${selectCartQuantity}
				</div>
				<svg class="cart_logo" xmlns="http://www.w3.org/2000/svg" width="28px" height="28px" viewBox="0 0 20 20" fill="none" class="size-7">
					<path class="cart_logo_outer" d="M4.3 16.5C4.13431 16.5 4 16.3657 4 16.2V7.8C4 7.63431 4.13432 7.5 4.3 7.5H15.7C15.8657 7.5 16 7.63431 16 7.8V16.2C16 16.3657 15.8657 16.5 15.7 16.5H4.3Z" stroke-width="1.4" stroke="#FFFFFF" vector-effect="non-scaling-stroke"></path>
					<path class="cart_logo_inner" d="M7.5 7.5V5.5C7.5 4.11929 8.61929 3 10 3C11.3807 3 12.5 4.11929 12.5 5.5V7.5" stroke-width="1.4" stroke="#FFFFFF" vector-effect="non-scaling-stroke"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<!-- 좋아요 있을 경우 -->
			<div class="item_main_whole">
				<c:forEach var="product" items="${likedList}">
					<div class="item_main_div" item_idx="${product.productIdx}">
						<div class="item_img">
						    <img class="item_img_tag" src="<%= request.getContextPath() %>/resources/img/${product.img}" alt="${product.img}">
								<svg class="product_like on" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg" class="">
									<path class="like_heart on"  d="M9.80392 16.3294C9.91639 16.4275 10.0836 16.4275 10.1961 16.3294C11.0801 15.5587 14.7183 12.3692 16.25 10.75C16.9 10 17.5 9 17.5 7.5C17.5 5.25 16 3.5 13.75 3.5C11.85 3.5 10.8 4.65 10 6C9.2 4.65 8.15 3.5 6.25 3.5C4 3.5 2.5 5.25 2.5 7.5C2.5 9 3.1 10 3.75 10.75C5.28165 12.3692 8.91988 15.5587 9.80392 16.3294Z" stroke-miterlimit="10" fill-opacity="0.3" fill="" stroke="" class="stroke-white fill-gray-500" vector-effect="non-scaling-stroke"></path></svg>
						</div>
						<div class="item_info">
							<b class="brand_info">${product.brand}</b>
							<div class="name_info">${product.name}</div>
							<b class="price_info">${product.price}원</b>
						</div>
					</div>
				</c:forEach>
				<!-- 좋아요 없을 경우 -->
				<c:if test="${fn:length(likedList) == 0}">
					<div class="do_not_have_likes">
						<b>좋아요한 상품이 없습니다.</b><br/>
						<a href="index">상품 보러 가기</a>
					</div>
				</c:if>
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
	</div>
</body>
</html>