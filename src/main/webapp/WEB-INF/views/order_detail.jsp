<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/order_detail.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
		$(function(){
		    let loginMemberIdx = "${sessionScope.loginMemberIdx}";
		    $.ajax({
		    	url:'deleteCartAfterOrder',
		    	type:'post',
		    	data:{
		    		"loginMemberIdx":loginMemberIdx
		    	},
		    	success:function(res){
		    		consoloe.log(res);
		    	},
		    	error:function(r,s,e){
		    		consoloe.log(r,s,e);
		    	}
		    });
		    
			$(".cart_list").each(function(){
				let dateText = $(this).find(".date_text").text();
			    let formattedDate = dateText.split(" ")[0];
			    formattedDate = formattedDate.replace(/-/g, ".");
			    $(this).find(".date_text").text(formattedDate);
			})
			
			$(".back_button").click(function(){
				history.back();
			});
			$(".home_button.real_button").click(function(){
				location.href="index";
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
			$(".popup_x_button").click(function(){
				$(".popup_background").hide();
			});
			$(".order_cancel").click(function(){
				let productIdx = $(this).closest(".cart_list").attr("order_idx");
				$(".delete_check_popup_background."+productIdx).css('display','flex');
			});
			$(".no_button").click(function(){
				$(".delete_check_popup_background").css('display','none');
			});
			$(".yes_button").click(function(){
				$(".delete_check_popup_background").css('display','none');
				let orderIdx = $(this).attr("order_idx");
				let loginMemberIdx = '${sessionScope.loginMemberIdx}';
				
				$.ajax({
					url:'deleteOrderProduct',
					type:'post',
					data:{
						"orderIdx":orderIdx
					},
					success:function(res){
						console.log(res);
						$(".cart_list."+orderIdx).remove();
						function showAlert() {
							var alertBox = document.getElementById("customAlert");
							alertBox.style.visibility = "visible"; // 알림을 보이게 설정
							setTimeout(function() {
							alertBox.style.visibility = "hidden"; // 3초 후에 알림 숨기기
							}, 3000);
						}
						// 페이지 로딩 후 알림 띄우기
						showAlert();
					},
					error:function(r,s,e){
						console.log(r,s,e);
					}
				});
				$(".cart_list."+orderIdx).remove();
			});
		});
		$(function(){
		    // 1분마다 상태를 변경하는 함수
		    function changeOrderStatus(orderIdx) {
		        $.ajax({
		            url: 'updateOrderStatus',  // 서버에서 상태를 업데이트할 API URL (수정 필요)
		            type: 'POST',
		            data: {
		                orderIdx: orderIdx  // 변경할 주문의 ID
		            },
		            success: function(res) {
		                // 서버에서 변경된 상태 받아와서 버튼 업데이트
		                if (res.status === '배송중') {
		                    $(".cart_list." + orderIdx + " .status_view").text('배송중');
		                    $(".order_cancel." + orderIdx).css({
										                    	 "pointer-events": "none",  // 버튼 클릭 비활성화
										                    	    "opacity": "0.5",
										                    	    "cursor":"default"
											                    });
		                    
		                    function showAlert() {
								var alertBox = document.getElementById("customAlert_shipping_start");
								alertBox.style.visibility = "visible"; // 알림을 보이게 설정
								setTimeout(function() {
								alertBox.style.visibility = "hidden"; // 1초 후에 알림 숨기기
								}, 1000);
							}
							// 페이지 로딩 후 알림 띄우기
							showAlert();
		                } else if (res.status === '배송완료') {
		                    $(".cart_list." + orderIdx + " .status_view").text('배송완료');
		                    $(".order_cancel." + orderIdx).hide();
		                    $(".order_confirmation." + orderIdx).css('display','flex');
		                    
		                    
		                    function showAlert() {
								var alertBox = document.getElementById("customAlert_shipping_end");
								alertBox.style.visibility = "visible"; // 알림을 보이게 설정
								setTimeout(function() {
								alertBox.style.visibility = "hidden"; // 1초 후에 알림 숨기기
								}, 1000);
							}
							// 페이지 로딩 후 알림 띄우기
							showAlert();
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error('상태 업데이트 실패:', error);
		            }
		        });
		    }

		    // 1분마다 상태 변경하기
		    $(".cart_list").each(function() {
		    	let productName = $(this).find(".name_text").text().trim();
		        let orderIdx = $(this).attr("order_idx");  // 주문 ID
		        let $statusView = $(this).find(".status_view").text().trim();  // 상태를 표시하는 부분
		        // 상태에 따라서 1분 간격으로 상태를 변경
		        setInterval(function() {
		            let currentStatus = $statusView;  // 현재 상태
					
		            // 상태에 따라서 변경
		            if (currentStatus === '상품 준비중') {
		                changeOrderStatus(orderIdx);
		            }else if (currentStatus === '배송중') {
		                changeOrderStatus(orderIdx);
		            }
		        }, 20000);  // 20000ms = 20초
		    });
		});
		
		$(document).ready(function() {
		    $(".cart_list").each(function(){
		    	let orderIdx = $(this).attr("order_idx").trim();
		    	let text = $(".status_view."+orderIdx).text().trim();
		    	if(text=='배송완료'){
		    		$(".order_cancel."+orderIdx).hide();
		    		$(".order_confirmation."+orderIdx).css('display','flex');
		    	}
		    });
		});
	</script>
</head>
<body>
	<div id="customAlert">주문 취소가 완료 되었습니다</div>
	<div id="customAlert_shipping_start">주문하신 상품이 배송시작 되었습니다</div>
	<div id="customAlert_shipping_end">주문하신 상품이 배송완료 되었습니다</div>
	<div class="main_area">
		<div class="main_top">
			<div class="main_top_left">
				<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
				<b class="home_button">주문 내역</b>
			</div>
			<div class="main_top_right">
				<svg class="home_button real_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<div class="alert_message"><b>20초마다 "배송상태"가 업데이트 됩니다.<br/></b></div>
			<!-- 배송상태 기능을 위한 수정중 -->
			<c:forEach var="order" items="${selectAllOrder }">
				<div class="cart_list ${order.orderIdx }" order_idx="${order.orderIdx }">
					<div class="item_img">
						<img item_idx="${order.productIdx }" class="item_img_tag" src="<%= request.getContextPath() %>/resources/img/${order.img}" alt="${order.img}">
						<div class="cart_item_info">
							<b class="date_text">${order.orderDate}</b>
							<div class="brand_text" >
								<b>${order.brand }</b>
							</div>
							<div class="name_text">${order.name }</div>
							<span class="size_text">${order.sizeName }</span>
							<span>/</span>
							<span class="quantity_text"> ${order.quantity }개</span>
							<div class="total_price_text"><b>${order.totalPrice }원</b></div>
						</div>
					</div>
					<div class="status_button_area">
						<div class="status_view ${order.orderIdx }">
							${order.status }
						</div>
						<div class="order_cancel ${order.orderIdx }">
							주문 취소
						</div>
						<div onclick="alert('구매 확정을 하였습니다');" class="order_confirmation ${order.orderIdx }" style="display:none;">
							구매 확정
						</div>
					</div>
				</div>
				<!------------------ 삭제 팝업창 ----------------------->
				<div class="delete_check_popup_background ${order.orderIdx }" order_idx="${order.orderIdx }">
					<div class="delete_check_popup">
						<div class="delete_popup_text">상품을 주문 취소 하시겠습니까?</div><div></div>
						<div>
							<input type="button" class="no_button" value="돌아가기"/>
							<input type="button" class="yes_button"  value="취소하기"  order_idx="${order.orderIdx }"/>
						</div>
					</div>	
				</div>
				<!------------------ 삭제 팝업창 ----------------------->
			</c:forEach>
			<!-- 배송상태 기능을 위한 수정중 -->
			<!-- 장바구니 상품 없을 경우 -->
			<!-- <div class="do_not_have_likes">
				<b>장바구니에 담은 상품이 없습니다.</b><br/>
				<a href="index">상품 보러 가기</a>
			</div> -->
		</div>
	</div>
</body>
</html>