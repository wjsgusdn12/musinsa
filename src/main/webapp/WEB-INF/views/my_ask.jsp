<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>문의 내역 페이지</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cart.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/likes.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/detail.css"/>
	<script src="<%= request.getContextPath() %>/resources/js/jquery-3.7.1.min.js"></script>
	<script>
	$(document).ready(function() {
	    // 뒤로 가기 버튼
	    $(".back_button").click(function(){
	        history.back();
	    });
	    // 홈 버튼
	    $(".home_button.real_button").click(function(){
	        location.href="index";
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
				<b class="home_button">문의 내역</b>
			</div>
			<div class="main_top_right">
				<svg class="home_button real_button" width="28" height="28" viewBox="0 0 28 28" fill="none">
					<path d="M14.0004 23.7999H5.20039C5.03471 23.7999 4.90039 23.6656 4.90039 23.4999V11.0023C4.90039 10.9065 4.94609 10.8166 5.02339 10.7601L13.8234 4.3293C13.9288 4.25226 14.072 4.25226 14.1774 4.3293L22.9774 10.7601C23.0547 10.8166 23.1004 10.9065 23.1004 11.0023V23.4999C23.1004 23.6656 22.9661 23.7999 22.8004 23.7999H14.0004ZM14.0004 23.7999V14.5055" stroke="currentColor" stroke-width="1.4"></path></svg>
			</div>
		</div>
		<div class="main_content">
			<div class="item_description">
				<div class="size_description">
					<h2>상품문의</h2><br/>
					<c:forEach var="ask" items="${myAsk}">
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
		</div>
	</div>
</body>
</html>