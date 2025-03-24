<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>주문서 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/detail.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/likes.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cart.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/order.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function(){
			$(".back_button").click(function(){
				history.back();
			});
			$(".home_button.real_button").click(function(){
				location.href="index";
			});
			/* 구매하기 클릭시 */
			$(".submit_input").click(function(event) {
				let loginMemberIdx = "${sessionScope.loginMemberIdx}";
				let finalTotalPrice = 0;
			    // 각 .cart_list 요소 순회
			    $(".cart_list").each(function() {
			        let brand = $(this).find(".brand_text b").text(); // 브랜드
			        let productName = $(this).find(".name_text").text(); // 제품 이름
			        let productIdx = $(this).attr("item_idx"); // 제품 번호
			        let size = $(this).find(".size_text").text(); // 사이즈
			        size = parseInt(size);
			        let quantity = $(this).find(".quantity_text").text().trim(); // 수량
			        let totalPrice = $(this).find(".total_price_text b").text().replace("원", "").trim(); // 가격 (원 제거)
			        totalPrice = totalPrice.replace(/,/g, "");
			        finalTotalPrice += parseInt(totalPrice); // 모든 제품의 가격 총합

			        $.ajax({
			       		url:'insertOrderDetail',
			       		type:'post',
			       		data:{
			       			loginMemberIdx : loginMemberIdx,
			       			productIdx : productIdx,
			       			sizeIdx : size,
			       			quantity : quantity.replace("개","")
			       		},
			       		success:function(res){
			       			console.log("주문서 상세 테이블에 추가 : " + res);
			       			location.href="order_detail";
			       		},
			       		error:function(r,s,e){
			       			console.log(r,s,e);
			       		}
			       	});
			    });
			    alert("결제하실 총 금액은 " + finalTotalPrice + "원 입니다.");
			});
		});
	</script>
</head>
<body>
	<div class="main_area">
		<div class="main_top">
			<div class="main_top_left">
				<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
				<b class="home_button">주문서</b>
			</div>
			<div class="main_top_right">
			</div>
		</div>
		<div class="main_content">
			<!-- 구매자 정보 -->
			<div class="order_user_info">
				<div>
					<h3>${sessionScope.loginMemberName}</h3>
					<input class="modify_button" type="button" onclick="location.href='modify_member_address'" value="배송지 변경"/>
				</div>
				<div>${sessionScope.loginMemberAddress}</div>
				<div>${sessionScope.loginMemberPhone}</div>
			</div>
			<!-- 상품갯수 체크 -->
			<h3>주문 상품 ${finalQuantity}개</h3>
			<!-- 상품목록 -->
			<c:forEach var="cart" items="${cartList }">
				<div class="cart_list" cart_idx="${cart.cartIdx}" item_idx="${cart.productIdx }">
					<div class="item_img">
						<img item_idx="${cart.productIdx }" class="item_img_tag" src="<%= request.getContextPath() %>/resources/img/${cart.img}" alt="${cart.img}">
						<div class="cart_item_info">
							<div class="brand_text" >
								<b>${cart.brand }</b>
							</div>
							<div class="name_text">${cart.name }</div>
							<span class="size_text">${cart.sizeName }</span>
							<span>/</span>
							<span class="quantity_text"> ${cart.quantity }</span>
							<div class="total_price_text"><b>${cart.totalPrice }원</b></div>
						</div>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
		<div class="main_footer">
			<input onclick="return check();" class="submit_input" type="submit" value="${finalPrice }원 결제하기"/>
		</div>
</body>
</html>