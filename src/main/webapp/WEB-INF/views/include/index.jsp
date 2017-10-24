<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>

	<!-- alert -->
	<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login-join.css" />
<style>
@import url("${pageContext.request.contextPath}/resources/css/common.css");

/* .................... */
/* home 				*/
/* .................... */
.main{width:100%;}
.title-box {margin:10% auto;}
.title-box #title-table{margin:0 auto;}
.title-box #title-table .image-box{text-align: right; width:37%;}
.title-box #title-table #title-top{font-size:2.1em; display: block; font-family: "나눔스퀘어EB"; color:#6e4a37;}
.title-box #title-table .title-animation span.title{font-size:4.81em; font-family: "나눔스퀘어EB"; color:#d74526;}
.title-box #title-table #title-bottom{font-size:1.125em; font-family: "나눔스퀘어EB"; color:#6e4a37;}
.title-box #title-table .login-box a{color:#cd9d61; font-family: "나눔스퀘어B"; font-size:20px; display: inline-block; margin-right:20px;}

/*-----------------
	타이틀 애니메이션
-----------------*/
.title-animation{width: 100%;margin: auto; perspective: 800px;}
.title-animation span {display: inline-block; transform-origin: 50% 70%;}
.title-animation span:nth-child(1) {animation: flipUp 2s cubic-bezier(0.68, -0.55, 0.26, 1.55) .2s both; }
.title-animation span:nth-child(2) {animation: flipUp 2s cubic-bezier(0.68, -0.55, 0.26, 1.55).4s both;}
.title-animation span:nth-child(3) {animation: flipUp 2s cubic-bezier(0.68, -0.55, 0.26, 1.55).6s both;}
.title-animation span:nth-child(4) {animation: flipUp 2s cubic-bezier(0.68, -0.55, 0.26, 1.55) .8s both;}
.title-animation span:nth-child(5) {animation: flipUp 2s cubic-bezier(0.68, -0.55, 0.26, 1.55) 1s both;}
@keyframes flipUp {
  from {transform: rotateX(90deg);}
  to {transform: rotateX(0deg);}
}
@media screen and (min-width: 916px) {
  span {font-size: 6.2em;}
  span:nth-child(5) {display: inline-block;margin: 0;}
}
</style>
<script>
	$(function(){
		/* 로그인 & 회원가입 버튼 클릭 ...........................*/
		$('#btnLogin').click(function(e){
			e.preventDefault();
			$('.login-container .login-form').css('display','block');
			$('.login-container .register-form').css('display','none');
			$('.login-container').fadeIn("slow");
		});
		
		$('#btnJoin').click(function(e){
			e.preventDefault();
			$('.login-container .login-form').css('display','none');
			$('.login-container .register-form').css('display','block');
			$('.login-container').fadeIn("slow");
		});
		/* .............................................. */
	});
</script>
</head>
<body>
<div class="main">
	<div class="title-box">
		<table id="title-table">
			<tr>
				<td class="image-box" rowspan="4">
					<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td>
					<span id="title-top">자격증 기출문제가<br />출출할 땐</span>
					<div class="title-animation">
						<span class="title">오</span>
						<span class="title">모</span>
						<span class="title">리</span>
						<span class="title">닷</span>
						<span class="title">컴</span>
					</div>
					<span id="title-bottom">오답풀이, 모의고사, 리플레이(반복학습)를 한번에!</span>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>
					<div class="login-box">
						<a href="" id="btnLogin">로그인</a>
						<a href="" id="btnJoin">회원가입</a>
					</div>
				</td>
			</tr>
		</table>
		<%-- <div class='image-box'>
			<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="" />
		</div>
		<div class="text-box">
			<span id="title-top">자격증 기출문제가<br />출출할 땐</span>
			<div class="title-animation">
				<span class="title">오</span>
				<span class="title">모</span>
				<span class="title">리</span>
				<span class="title">닷</span>
				<span class="title">컴</span>
			</div>
			<span id="title-bottom">오답풀이, 모의고사, 리플레이(반복학습)를 한번에!</span>
		</div>
		<div class="login-box">
			<a href="" id="btnLogin">로그인</a>
			<a href="" id="btnJoin">회원가입</a>
		</div> --%>
	</div>
</div>

<!-- login and join modal -->
<div class="login-container">
	<%@ include file="../user/login_and_join.jsp" %>
</div>
<!-- .................... -->
</body>
</html>