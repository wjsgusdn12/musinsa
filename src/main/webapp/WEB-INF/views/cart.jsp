<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>장바구니 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/detail.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/likes.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cart.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function(){
			$(".back_button").click(function(){
				location.href="index";
			});
			$(".home_button.real_button").click(function(){
				location.href="index";
			});
			$(".product_like").click(function(event) {
			    let productIdx = $(this).prev().attr("item_idx");
			    let loginMemberIdx = ${sessionScope.loginMemberIdx};
			    event.stopPropagation();  // 클릭 이벤트 전파 방지
			    // 같은 productIdx를 가진 모든 .product_like 요소 찾기
			    let hearts = $(".product_like").filter(function() {
			        return $(this).prev().attr("item_idx") == productIdx;
			    });
			    // 하트 상태 변경
			    hearts.each(function() {
			        let currentHeart = $(this);
			        // 상태를 토글 (하트가 이미 "on"이면 "off"로 변경, 그 반대도 마찬가지)
			        currentHeart.toggleClass("on");
			        currentHeart.find(".like_heart").toggleClass("on");
			        // 상태에 맞는 스타일 적용
			        if (currentHeart.hasClass("on")) {
			            currentHeart.find(".like_heart").css({
			                "stroke": "#ff002d",           // 하트 외곽선 색상
			                "fill": "#ff0000",             // 하트 채우기 색상
			                "fill-opacity": "1"            // 채우기 불투명도
			            });
			        } else {
			            currentHeart.find(".like_heart").css({
			                "stroke": "",                 // 원래 외곽선 색상
			                "fill": "",                   // 원래 채우기 색상
			                "fill-opacity": "0.3"          // 원래 채우기 불투명도
			            });
			        }
			    });
			    // AJAX 요청 - 좋아요 추가/제거
			    $.ajax({
			        url: 'likeProduct',
			        type: 'post',
			        data: {
			            "productIdx": productIdx,
			            "loginMemberIdx": loginMemberIdx,
			            "likeStatus": hearts.first().hasClass("on") // 첫 번째 하트 상태 기준
			        },
			        success: function(res) {
			            console.log("좋아요 상태 변경 성공", res);
			        },
			        error: function(r, s, e) {
			            console.log("error : ", r, s, e);
			            alert("error!");
			        }
			    });
			});
			$(".item_img_tag").click(function(){
				let itemIdx = $(this).attr("item_idx");
				let isLiked = $(this).closest(".item_img").find(".like_heart"); // 해당 상품의 하트 상태
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
			
			$(".x_button").click(function(){
				let cartIdx = $(this).closest('.cart_list').attr("cart_idx");
				$(".delete_check_popup_background").each(function() {
			        if ($(this).attr("cart_idx") === cartIdx) {  // cart_idx가 일치하는 팝업을 찾음
			            $(this).css('display', 'flex');  // 해당 팝업을 보여줌
			        }
			    });
			});
			$(".no_button").click(function(){
				$(".delete_check_popup_background").css('display','none');
			});
			$(".yes_button").click(function(){
			    let cartIdx = $(this).attr("cart_idx");  // 클릭된 버튼의 cart_idx 값
			    let loginMemberIdx = ${sessionScope.loginMemberIdx};  // 로그인된 회원의 아이디
			    
			    $(".cart_list").each(function() {
			        if ($(this).attr("cart_idx") === cartIdx) {
			            $(this).hide();  // 해당 cart_idx를 가진 항목 숨기기
			            
			            $.ajax({
			            	url:'deleteCart',
			            	type:'post',
			            	data:{
			            		"cartIdx":cartIdx
			            	},
			            	success:function(res){
			            		console.log(res);
			            	},
			            	error:function(r,s,e){
			            		alert("error");
			            		console.log(r,s,e);
			            	}
			            });
			        }
			    });
			    $(".delete_check_popup_background").css('display','none');
			    location.reload();
			});
			
			// 사이즈 선택 클릭
		    $(".sizeName").click(function(event){
		        let sizeName = $(this).attr("sizeName");
		        $(".popup_size_name_text").text(sizeName);
		        $(".option_block").css('display','none');
		        $(".option_none").css('display','flex');
		        
		        let totalPrice = 0;
		        let totalQuantity = 0;
		        // 모든 selected_option 요소를 순회하면서 가격을 더함
		        $('.selected_option').each(function() {
		            let priceText = $(this).find('.selected_price').text();  // '100,000원' 형식의 텍스트
		            let price = parseInt(priceText.replace(/,/g, '').replace('원', '').trim()); // 숫자만 추출
		            
		            totalPrice += price;  // 가격 합산
		            
	 				let quantity = $(this).find('.quantity_input').val();
		            
		            totalQuantity += parseInt(quantity);
		        });
		        
		        // 총합을 화면에 표시 (예: .total_price 클래스를 사용하여 표시)
		        $('.final_product_price').text(totalPrice.toLocaleString() + '원');
		        $(".final_product_quantity").text("총 "+ totalQuantity +"개");
		        
		        event.stopPropagation();
		    });

		    // 옵션 팝업 닫기
		    $(".option_none").click(function() {
		        $(this).css('display','none');
		        $(".option_block").css('display','flex');
		        event.stopPropagation();
		    });

		    // 옵션 선택 블록 클릭
		    $(".option_block").click(function() {
		        $(this).css('display','none');
		        $(".option_none").css('display','flex');
		        event.stopPropagation();
		    });

		    // 수량 조정 및 삭제 버튼 클릭 이벤트 처리
		    $(document).on('click', '.minus_input, .plus_input, .x_button', function(event) {
		    	let cartIdx = $(this).closest(".popup_background").attr("cart_idx");
		    	
		    	// cart_idx 값에 해당하는 .cart_list를 찾아서 가격 텍스트 가져오기
		    	let price = $(".cart_list").filter(function() {
		    	    return $(this).attr("cart_idx") == cartIdx;  // cart_idx 값 비교
		    	}).find(".total_price_text").text().replace("원","");  // 해당 .cart_list 내에서 가격 텍스트 가져오기
		    	
		    	let firstQuantity = $(".cart_list").filter(function() {
		    	    return $(this).attr("cart_idx") == cartIdx;  // cart_idx 값 비교
		    	}).find(".quantity_text").text().replace("개","");
		    	
		    	let unitPrice = price.replace(/,/g, "") / firstQuantity;
		    	
		    	// minus_input 클릭 시
		    	if ($(this).hasClass('minus_input')) {
		    	    let quantity = $(this).siblings('.quantity_input').val(); // 현재 값 가져오기
		    	    if (quantity > 1) {
		    	        quantity = parseInt(quantity) - 1; // 값 감소
		    	        $(this).siblings('.quantity_input').val(quantity); // 입력 필드 값 업데이트
		    	    }
		    	    if (quantity == 1) {
		    	        $(this).addClass("off");
		    	    }
		    	    let total_price = (unitPrice*quantity);
		    	    $(this).parent().closest(".option_bottom").find(".selected_price").text(total_price.toLocaleString());
		    	}
		    	// plus_input 클릭 시
		    	else if ($(this).hasClass('plus_input')) {
		    	    let quantity = $(this).siblings('.quantity_input').val(); // 현재 값 가져오기
		    	    quantity = parseInt(quantity) + 1; // 값 증가
		    	    $(this).siblings('.quantity_input').val(quantity); // 입력 필드 값 업데이트
		    	    if (quantity != 1) {
		    	        $(this).siblings('.minus_input').removeClass("off");
		    	    }
		    	    let total_price = (unitPrice*quantity);
		    	    $(this).parent().closest(".option_bottom").find(".selected_price").text(total_price.toLocaleString());
		    	}
		        event.stopPropagation();  // 추가: 이벤트 전파 차단
		    });
			$(".popup_x_button").click(function(){
				$(".popup_background").hide();
			});
			$(".option_modify").click(function(){
				let sizeName = $(this).parent().find(".size_text").text();
				let quantity = $(this).parent().find(".quantity_text").text();
				let price = $(this).parent().find(".total_price_text").text().replace("원","");
				let cartIdx = $(this).parent().attr("cart_idx");
				let productIdx = $(this).parent().attr("item_idx");
				$(".popup_size_name_text").text(sizeName);
				$(".quantity_input").val(parseInt(quantity));
				$(".selected_price").text(price);
				$(".popup_background").attr("cart_idx", cartIdx);
				$(".popup_background").css('display','flex');
				
				$(".cancle_button").click(function(){
					$(".popup_background").hide();
				});
				$(".modify_button").off("click").click(function(){
					let modifyProductIdx = productIdx;
					let deleteSizeName = sizeName;
					let modifySizeName = $(".popup_size_name_text").first().text();
					let loginMemberIdx = ${sessionScope.loginMemberIdx};
					quantity = $(".quantity_input").val();
					$.ajax({
						url:'modifyCart',
						type:'post',
						data:{
							"productIdx":modifyProductIdx,
							"deleteSizeIdx":parseInt(deleteSizeName),
							"modifySizeIdx":parseInt(modifySizeName),
							"quantity":quantity,
							"loginMemberIdx":loginMemberIdx
						},
						success:function(res){
							location.href="cart";
						},
						error:function(r,s,e){
							alert(r,s,e)
						}
					});
				});
			});
			/* 구매하기 클릭시 */
			$(".submit_input.real_button").click(function(event) {
			    event.preventDefault(); // 폼 제출 방지
			    location.href="order";
			});
		});
	</script>
</head>
<body>
	<!--------------------------------------- 팝업창공간 ----------------------------------------->
	<div class="popup_background" cart_idx="">
		<div class="order_info_popup">
			<div class="popup_background_close_button">
				<svg class="popup_x_button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
                       <path d="M5 5L10 10M10 10L15 15M10 10L5 15M10 10L15 5" class="stroke-black" stroke-miterlimit="10" vector-effect="non-scaling-stroke"></path>
                   </svg>
			</div>
			<div class="popup_option_area">
				<div class="option_none">
					<span class="popup_size_name_text">사이즈</span>
					<svg class="size_view_button" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
					    <path d="M4 6 L10 12 L16 6" fill="none" vector-effect="non-scaling-stroke"></path>
					</svg>
				</div>
				<div style="display:none;" class="option_block">
					<div class="option_head">
						<span class="popup_size_name_text">사이즈</span>
						<svg class="size_view_button" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
						    <path d="M4 6 L10 12 L16 6" fill="none" vector-effect="non-scaling-stroke" transform="rotate(180 10 10)"></path>
						</svg>
					</div>
					<div class="option_content">
						<c:forEach var="i" begin="1" end="7">
						    <div class="sizeName" sizeName="0${i}">0${i}</div>
						</c:forEach>
					</div>	
				</div>
				<div class="selected_option">
	                <div class="option_bottom">
	                    <div class="selected_quantity">
	                        <div class="minus_input">
	                            <svg class="minus_one" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
	                                <path d="M4 10H16" class="stroke-black" stroke-miterlimit="10" vector-effect="non-scaling-stroke"></path>
	                            </svg>
	                        </div>
	                        <input class="quantity_input" value="1"/>
	                        <div class="plus_input">
	                            <svg class="plus_one" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
	                                <path d="M10 4V10M10 10V16M10 10H4M10 10H16" class="stroke-black" stroke-miterlimit="10" vector-effect="non-scaling-stroke"></path>
	                            </svg>
	                        </div>
	                    </div>
	                    <div>
	                    	<b class="selected_price">${productInfo.price}</b><b>원</b>
	                    </div>
	                </div>
	            </div>
			</div>
			<div class="popup_button_area">
				<div class="total_info" style="/* display:none; */">
				</div>
				<div class="real_button_area">
					<input class="cart_button cancle_button" type="button" value="취소"/>
					<input class="order_button modify_button" type="button" value="변경하기"/>
				</div>
			</div>
		</div>
	</div>
	<!----------------------------------------------- 팝업창공간 ------------------------------------------>
	<div class="main_top">
		<div class="main_top_left">
			<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
			<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
			<b class="home_button">장바구니</b>
		</div>
		<div class="main_top_right">
			<svg class="home_button real_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
			<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
		</div>
	</div>
	<div class="main_area">
		<div class="main_content">
			<!-- 장바구니 상품 있을 경우 -->
			<c:forEach var="cart" items="${cartList }">
				<div class="cart_list" cart_idx="${cart.cartIdx}" item_idx="${cart.productIdx }">
					<div class="item_img">
						<img item_idx="${cart.productIdx }" class="item_img_tag" src="<%= request.getContextPath() %>/resources/img/${cart.img}" alt="${cart.img}">
						<svg class="product_like 
			                <c:forEach var="likedProduct" items="${likedList}">
			                    ${cart.productIdx == likedProduct.productIdx ? 'on' : ''}
			                </c:forEach>" 
			                viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
			                <path class="like_heart 
			                    <c:forEach var="likedProduct" items="${likedList}">
			                        ${cart.productIdx == likedProduct.productIdx ? 'on' : ''}
			                    </c:forEach>" 
			                    d="M9.80392 16.3294C9.91639 16.4275 10.0836 16.4275 10.1961 16.3294C11.0801 15.5587 14.7183 12.3692 16.25 10.75C16.9 10 17.5 9 17.5 7.5C17.5 5.25 16 3.5 13.75 3.5C11.85 3.5 10.8 4.65 10 6C9.2 4.65 8.15 3.5 6.25 3.5C4 3.5 2.5 5.25 2.5 7.5C2.5 9 3.1 10 3.75 10.75C5.28165 12.3692 8.91988 15.5587 9.80392 16.3294Z" 
			                    stroke-miterlimit="10" fill-opacity="0.3" fill="" stroke="" class="stroke-white fill-gray-500" vector-effect="non-scaling-stroke">
			                </path>
			            </svg>
						<div class="cart_item_info">
							<div class="brand_text" >
								<b>${cart.brand }</b>
								<svg class="x_button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
			                        <path d="M5 5L10 10M10 10L15 15M10 10L5 15M10 10L15 5" class="stroke-black" stroke-miterlimit="10"></path>
			                    </svg>
							</div>
							<div class="name_text">${cart.name }</div>
							<span class="size_text">${cart.sizeName }</span>
							<span>/</span>
							<span class="quantity_text"> ${cart.quantity }</span>
							<div class="total_price_text"><b>${cart.totalPrice }원</b></div>
						</div>
					</div>
					<div class="option_modify">
						옵션 변경
					</div>
				</div>
				<!------------------ 삭제 팝업창 ----------------------->
				<div class="delete_check_popup_background" cart_idx="${cart.cartIdx }">
					<div class="delete_check_popup">
						<div class="delete_popup_text">상품을 삭제하시겠습니까?</div><div></div>
						<div class="delete_popup_button_area">
							<input type="button" class="no_button" value="취소"/>
							<input type="button" class="yes_button"  value="삭제하기"  cart_idx="${cart.cartIdx }"/>
						</div>
					</div>	
				</div>
				<!------------------ 삭제 팝업창 ----------------------->
			</c:forEach>
			<c:if test="${fn:length(cartList) == 0}">
			   <div class="do_not_have_likes">
				<b>장바구니에 담은 상품이 없습니다.</b><br/>
				<a href="index">상품 보러 가기</a>
			</div>
			</c:if>
		</div>
	</div>
	<div class="main_footer">
		<!-- 장바구니 상품 있을 경우 -->
		<c:if test="${fn:length(cartList) != 0}">
			<form action="" method="post">
				<input class="submit_input real_button" type="submit" value="${finalPrice }원 구매하기 (${finalQuantity }개)"/>
			</form>
		</c:if>
		<!-- 장바구니 상품 없을 경우 -->
		<c:if test="${fn:length(cartList) == 0}">
		   <input onclick="location.href='index'" class="submit_input" type="submit" value="쇼핑 계속하기"/>
		</c:if>
	</div>
</body>
</html>