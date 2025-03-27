<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>제품 상세보기 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cart.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/likes.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/detail.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
	function order(){
		$(".popup_background").css('display','flex');
	}
	$(document).ready(function() {
		if(${isLiked}==1){
			$(".like_button").addClass("on");
			$(".like_heart").addClass("on");
			$(".like_heart").css({
                "stroke": "#ff002d",
                "fill": "#ff0000",
                "fill-opacity": "1"
            });
		}
		$(".popup_background_close_button").click(function(){
			$(".popup_background").css('display','none');
		});
	    // 뒤로 가기 버튼
	    $(".back_button").click(function(){
	        history.back();
	    });
	    // 홈 버튼
	    $(".home_button.real_button").click(function(){
	        location.href="index";
	    });
	    // 장바구니 버튼
	    $(".cart_logo, .selectCartQuantity").click(function(){
	        location.href="cart";
	    });
	    // 좋아요 버튼 클릭
	    $(".like_button").click(function(event) {
		    let productIdx = '${productInfo.productIdx}';
		    let loginMemberIdx = ${sessionScope.loginMemberIdx};
		    event.stopPropagation();
		    // 좋아요 상태 토글
		    $(this).toggleClass("on");
		    $(this).find(".like_heart").toggleClass("on");
		
		    if ($(this).hasClass("on")) {
		        $(this).find(".like_heart").css({
		            "stroke": "#ff002d",
		            "fill": "#ff0000",
		            "fill-opacity": "1"
		        });
		        // AJAX로 좋아요 추가 처리
		        $.ajax({
		            url: 'likeProduct', // 서버에서 likeProduct 요청 처리
		            type: 'post',
		            data: {
		                "productIdx": productIdx,
		                "loginMemberIdx": ${sessionScope.loginMemberIdx},
		                "likeStatus": true // 좋아요 추가
		            },
		            success: function(res) {
		                // 서버에서 좋아요 상태를 세션에 저장 처리
		                $.ajax({
		                    url: 'saveLikeStatus', // 세션에 좋아요 상태 저장 요청
		                    type: 'post',
		                    data: {
		                        "isLiked": 1 // 좋아요 상태
		                    },
		                    success: function(response) {
		                        console.log("좋아요 상태가 세션에 저장되었습니다.");
		                    },
		                    error: function(r, s, e) {
		                        console.log("세션 저장 error: ", r, s, e);
		                    }
		                });
		            },
		            error: function(r, s, e) {
		                console.log("error : ", r, s, e);
		            }
		        });
		
		    } else {
		        $(this).find(".like_heart").css({
		            "stroke": "",
		            "fill": "",
		            "fill-opacity": "0.3"
		        });
		        // AJAX로 좋아요 제거 처리
		        $.ajax({
		            url: 'likeProduct', // 서버에서 likeProduct 요청 처리
		            type: 'post',
		            data: {
		                "productIdx": productIdx,
		                "loginMemberIdx": ${sessionScope.loginMemberIdx},
		                "likeStatus": false // 좋아요 제거
		            },
		            success: function(res) {
		                // 서버에서 좋아요 상태를 세션에 저장 처리
		                $.ajax({
		                    url: 'saveLikeStatus', // 세션에 좋아요 상태 저장 요청
		                    type: 'post',
		                    data: {
		                        "isLiked": 0 // 좋아요 상태 제거
		                    },
		                    success: function(response) {
		                        console.log("좋아요 상태가 세션에 저장되었습니다.");
		                    },
		                    error: function(r, s, e) {
		                        console.log("세션 저장 error: ", r, s, e);
		                    }
		                });
		            },
		            error: function(r, s, e) {
		                console.log("error : ", r, s, e);
		            }
		        });
		    }
		});
	    // 사이즈 선택 클릭
	    $(".sizeName").click(function(event){
	        let sizeName = $(this).attr("sizeName");
	        let text = `
	            <div class="selected_option">
	                <div class="option_top">
	                    <div class="size_option center">`+sizeName+`</div>
	                    <div class="x_button center">
	                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
	                            <path d="M5 5L10 10M10 10L15 15M10 10L5 15M10 10L15 5" class="stroke-black" stroke-miterlimit="10" vector-effect="non-scaling-stroke"></path>
	                        </svg>
	                    </div>
	                </div>
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
	                    <div class="selected_price">${productInfo.price}원</div>
	                </div>
	            </div>
	        `;
	        $(".append_area").before(text);
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
	    	let price = '${productInfo.price}'; 
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
	    	    let total_price = (parseInt(price.replace(/,/g, '').trim())*quantity);
	    	    $(this).parent().parent().find(".selected_price").text(total_price.toLocaleString()+'원');
	    	    $(".final_product_price").text();
	    	}
	    	// plus_input 클릭 시
	    	else if ($(this).hasClass('plus_input')) {
	    	    let quantity = $(this).siblings('.quantity_input').val(); // 현재 값 가져오기
	    	    quantity = parseInt(quantity) + 1; // 값 증가
	    	    $(this).siblings('.quantity_input').val(quantity); // 입력 필드 값 업데이트
	    	    if (quantity != 1) {
	    	        $(this).siblings('.minus_input').removeClass("off");
	    	    }
	    	    let total_price = (parseInt(price.replace(/,/g, '').trim())*quantity);
	    	    $(this).parent().parent().find(".selected_price").text(total_price.toLocaleString()+'원');
	    	}
	        // x_button 클릭 시 (옵션 삭제)
	        else if ($(this).hasClass('x_button')) {
	            $(this).closest('.selected_option').remove(); // selected_option 요소 삭제
	        }
	        event.stopPropagation();  // 추가: 이벤트 전파 차단
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
	    });
	    
	    // 장바구니
	    $(".cart_button").click(function(){
	    	let productIdx = '${productInfo.productIdx}';
	    	let loginMemberIdx = '${sessionScope.loginMemberIdx}';
	        let totalSize = "";  // 사이즈 정보를 이어서 저장할 변수 (예: "01, 02, 03")
	        let totalQuantity = 0;  // 총 수량
	        let totalPrice = 0;  // 총 가격
	        let productName = '${productInfo.name}';
	        
	        // 모든 selected_option 요소를 순회하면서 정보 가져오기
	        $(".selected_option").each(function(){
	            let size = $(this).find(".size_option").text();  // 사이즈 정보 (예: "01", "02", "03")
	            let quantity = parseInt($(this).find(".quantity_input").val());  // 수량
	            let priceText = $(this).find(".selected_price").text();  // 가격 정보 (예: "100,000원")
	            let price = parseInt(priceText.replace(/,/g, '').replace('원', '').trim());  // 가격에서 ','와 '원' 제거하고 숫자로 변환
	            
	            totalSize += size + ", ";  // 사이즈 추가 (01, 02, 03 형태)
	            totalQuantity += quantity;  // 수량 합산
	            totalPrice += (price * quantity);  // 총 가격 합산

	           	$.ajax({
		        	url:'insertCart',
		        	type:'post',
		        	data:{
		        		"productIdx" : productIdx,
		        		"sizeIdx" : parseInt(size),
		        		"quantity" : parseInt(quantity)
		        	},
		        	success:function(res){
		        		location.href="cart";
		        	},
		        	error:function(r,s,e){
		        	}
		        });
	        });
	        // 마지막 쉼표 제거
	        totalSize = totalSize.trim().slice(0, -1);  // 마지막 공백과 쉼표 제거
	    });

	    // 주문하기
	    $(".order_button").click(function(){
	    	let productIdx = '${productInfo.productIdx}';
	    	let loginMemberIdx = '${sessionScope.loginMemberIdx}';
	        let totalSize = "";  // 사이즈 정보를 이어서 저장할 변수 (예: "01, 02, 03")
	        let totalQuantity = 0;  // 총 수량
	        let totalPrice = 0;  // 총 가격
	        
	        // 모든 selected_option 요소를 순회하면서 정보 가져오기
	        $(".selected_option").each(function(){
	        	let size = $(this).find(".size_option").text();  // 사이즈 정보 (예: "01", "02", "03")
	            let quantity = parseInt($(this).find(".quantity_input").val());  // 수량
	            let priceText = $(this).find(".selected_price").text();  // 가격 정보 (예: "100,000원")
	            let price = parseInt(priceText.replace(/,/g, '').replace('원', '').trim());  // 가격에서 ','와 '원' 제거하고 숫자로 변환
	            return;
	            totalSize += size + ", ";  // 사이즈 추가 (01, 02, 03 형태)
	            totalQuantity += quantity;  // 수량 합산
	            totalPrice += (price * quantity);  // 총 가격 합산
	            
	           	$.ajax({
		        	url:'insertCart',
		        	type:'post',
		        	data:{
		        		"productIdx" : productIdx,
		        		"sizeIdx" : size,
		        		"quantity" : quantity,
		        		"loginMemberIdx" : loginMemberIdx
		        	},
		        	success:function(res){
		        	},
		        	error:function(r,s,e){
		        	}
		        });
	        });
	        // 마지막 쉼표 제거
	        totalSize = totalSize.trim().slice(0, -1);  // 마지막 공백과 쉼표 제거
	    });
    	$(".submit_input.ask_submit").css({
    		"background-color":"#EAEAEA",
    		"cursor":"default"
    	});
    	$(".editable-box.title_input, .editable-box.content_input").on("input", function() {
    	    // contenteditable 요소에서 값 가져오기
    	    let askTitle = $(".editable-box.title_input").text().trim();
    	    let askContent = $(".editable-box.content_input").text().trim();
    	    // 값이 비어있다면 버튼을 비활성화
    	    if (askTitle == '' || askContent == '') {
    	        $(".submit_input.ask_submit").css({
    	            "background-color": "#EAEAEA",  // 비활성화 상태의 색상
    	            "cursor": "default"
    	        });
    	    } else {
    	        $(".submit_input.ask_submit").css({
    	            "background-color": "black",  // 활성화 상태의 색상
    	            "cursor": "pointer"
    	        });
    	    }
    	});
    	$(".submit_input.ask_submit").click(function() {
    	    // 커서 값이 'default'이면 클릭 이벤트를 취소
    	    if ($(this).css('cursor') === 'default') {
    	        return; // 클릭을 취소
    	    }
    	    // 클릭 시 알림 출력
    	    let askTitle = $(".editable-box.title_input").text().trim();
    	    let askContent = $(".editable-box.content_input").text().trim();
    	    let loginMemerIdx = ${sessionScope.loginMemberIdx};
    	    let productIdx = ${productInfo.productIdx};

    	    $.ajax({
    	    	url:'insertAsk',
    	    	type:'post',
    	    	data:{
    	    		"title": askTitle,
    	    		"content": askContent,
    	    		"loginMemerIdx": loginMemerIdx,
    	    		"productIdx": productIdx,
    	    	},
    	    	success:function(res){
    	    		alert("문의가 등록되었습니다");
    	    		location.reload();
    	    	},
    	    	error:function(r,s,e){
    	    	}
    	    });
    	});
    	//문의 폼 none block 스위칭
    	$(".submit_input.ask").click(function(){
    	    let displayValue = $(".ask_input_area").css('display');
    	    
    	    if(displayValue === 'none'){
    	        $(".ask_input_area").css('display', 'block');
    	    } else if(displayValue === 'block'){
    	        $(".ask_input_area").css('display', 'none');
    	    }
    	});
	});
	</script>
</head>
<body>
	<!--------------------------------------- 팝업창공간 ----------------------------------------->
	<div class="popup_background">
		<div class="order_info_popup">
			<div class="popup_background_close_button">
				<svg class="popup_x_button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none">
                       <path d="M5 5L10 10M10 10L15 15M10 10L5 15M10 10L15 5" class="stroke-black" stroke-miterlimit="10" vector-effect="non-scaling-stroke"></path>
                   </svg>
			</div>
			<div class="popup_option_area">
				<div class="option_none">
					<span>사이즈</span>
					<svg class="size_view_button" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
					    <path d="M4 6 L10 12 L16 6" fill="none" vector-effect="non-scaling-stroke"></path>
					</svg>
				</div>
				<div style="display:none;" class="option_block">
					<div class="option_head">
						<span>사이즈</span>
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
				<!-- 선택한 옵션이 추가될 영역 -->
				<div class="append_area" display="none"></div>
			</div>
			<div class="popup_button_area">
				<div class="total_info" style="/* display:none; */">
					<div class="final_product_quantity">
						총 0개
					</div>
					<div class="final_product_price">
						0원
					</div>
				</div>
				<div class="real_button_area">
					<input class="cart_button" type="button" value="장바구니"/>
				</div>
			</div>
		</div>
	</div>
	<!----------------------------------------------- 팝업창공간 ------------------------------------------>
	<div class="main_top">
		<div class="main_top_left">
			<svg class="back_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
			<path d="M16.1004 21.7L8.61252 14.2122C8.49537 14.095 8.49537 13.9051 8.61252 13.7879L16.1004 6.30005" stroke="currentColor" stroke-width="1.4"></path></svg>
			<b class="home_button">제품 상세보기</b>
		</div>
		<div class="main_top_right">
			<div class="selectCartQuantity">
				${selectCartQuantity}
			</div>
			<svg class="home_button real_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
				<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			<svg class="cart_logo" xmlns="http://www.w3.org/2000/svg" width="28px" height="28px" viewBox="0 0 20 20" fill="none" class="size-7">
				<path d="M4.3 16.5C4.13431 16.5 4 16.3657 4 16.2V7.8C4 7.63431 4.13432 7.5 4.3 7.5H15.7C15.8657 7.5 16 7.63431 16 7.8V16.2C16 16.3657 15.8657 16.5 15.7 16.5H4.3Z" stroke-width="1.4" stroke="black" vector-effect="non-scaling-stroke"></path>
				<path d="M7.5 7.5V5.5C7.5 4.11929 8.61929 3 10 3C11.3807 3 12.5 4.11929 12.5 5.5V7.5" stroke-width="1.4" stroke="black" vector-effect="non-scaling-stroke"></path></svg>
		</div>
	</div>
	<div class="main_area">
		<div class="main_content">
			<div class="item_img">
			    <img class="item_img_tag" src="<%= request.getContextPath() %>/resources/img/${productInfo.img}"/>
			</div>
			<div class="item_detail">
				<div class="item_detail_brand">${productInfo.brand }</div><hr/>
				<div class="item_detail_name">${productInfo.name }</div>
				<div class="item_detail_price">${productInfo.price }원</div>
			</div>
			<div class="item_description">
				<div class="product_description">
				    <p>${productInfo.description}</p>
				</div>
				<div class="size_description">
			    	<p>사이즈는 아래 표를 참조해주세요.</p>
				    <table class="size_table">
				        <thead> <tr> <th>Size</th> <th>의류</th> <th>신발</th> </tr> </thead>
				        <tbody> <tr> <td>01</td> <td>XS</td> <td>240</td> </tr>
					            <tr> <td>02</td> <td>S</td> <td>245</td> </tr>
					            <tr> <td>03</td> <td>M</td> <td>250</td> </tr>
					            <tr> <td>04</td> <td>L</td> <td>255</td> </tr>
					            <tr> <td>05</td> <td>XL</td> <td>265</td> </tr>
					            <tr> <td>06</td> <td>2XL</td> <td>270</td> </tr>
					            <tr> <td>07</td> <td>3XL</td> <td>275</td> </tr> </tbody>
				    </table>
				    <input class="submit_input ask" type="submit" value="문의하기"/>
				    <div class="ask_input_area">
				    	<b>문의 제목</b>
					    <div contenteditable="true" class="editable-box title_input" placeholder="제목을 입력하세요"></div><br/>
					    <b>문의 내용</b>
					    <div contenteditable="true" class="editable-box content_input" placeholder="내용을 입력하세요"></div>
						<input class="submit_input ask_submit" type="button" value="등록하기"/>
					</div>
					<hr/>
					<br/>
					<h2>문의 내역</h2><br/>
					<c:forEach var="ask" items="${selectProductAsk}">
						<div class="ask_area">
							<div>
								<div class="ask_title">
									<b>Q. ${ask.title }</b>
								</div><br/>
								<div class="ask_content">
									${ask.content }<br/><br/>
								</div>
								<div class="date_area ask">${ask.id } • ${ask.askDate}</div>
							</div><br/><hr/><br/>
							<div>
								<div class="answer_title">
									<b>A. ${ask.title }</b>
								</div><br/>
								<div class="answer_content">
									${ask.answer }
								</div><br/>
								<div class="date_area answer">${ask.answerDate}</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="item_img_footer">
			    <img class="item_img_tag_footer" src="<%= request.getContextPath() %>/resources/img/detail_footer.png"/>
			</div>
		</div>
	</div>
	<div class="main_footer">
		<form action="" method="post">
			<div class="footer_buttons">
			    <svg class="like_button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
			        <path class="like_heart" d="M9.79493 16.3061C9.91046 16.4154 10.0895 16.4154 10.2051 16.3061C11.1045 15.4553 14.7235 12.0265 16.25 10.5C16.8895 9.85325 17.5 8.75 17.5 7.5C17.5 5.34156 15.8342 3.5 13.75 3.5C11.9105 3.5 11 4.99545 10 6.25C9 4.99545 8.08947 3.5 6.25 3.5C4.16579 3.5 2.5 5.34156 2.5 7.5C2.5 8.75 3.11053 9.85325 3.75 10.5C5.27651 12.0265 8.89549 15.4553 9.79493 16.3061Z" stroke-width="1.4" stroke-miterlimit="10" vector-effect="non-scaling-stroke"></path>
			    </svg>
			    <!-- 구매하기 버튼 -->
			    <input onclick="return order();" class="submit_input" type="button" value="구매하기">
			</div>
		</form>
	</div>
</body>
</html>