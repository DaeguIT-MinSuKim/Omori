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
.main{
	width:100%;
}

.login-box{
	width:600px;
	margin:10% auto 0;
	text-align: right;
}
.login-box a{
	display:inline-block;
	color:#eee;
	font-family: "나눔스퀘어R";
	font-size: 26px;
	margin:15px 0 15px 20px;
	padding:5px 0;
}

.nonmember{
	color:#eee;
	width:600px;
	margin:20px auto 0;
	text-align:right;
}

.title-box{
	width:600px;
	display:block;
	background:rgba(0,0,0,0.4);
	text-align: center;
	margin:0 auto ;
	padding:20px 0;
}
.title-box #title{
	color:#eee;
	font-family: "나눔스퀘어B";
	font-size: 72px;
	text-shadow:2px 2px 0px gray;
	display:inline-block;
	padding:7px 0;
}
.title-box #title-bottom, #title-top {
	font-family: "나눔스퀘어R";
	color:#c4e2ee;
	font-size:20px;
	display:inline-block;
}
#title-top{
	padding-top:10px;
}
#title-bottom{
	padding-bottom:10px;
}

#title-bottom span{
	color:#eee;
	font-size:22px;
	font-weight: bold;
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
	<div class="login-box">
		<a href="" id="btnLogin">로그인</a>
		<a href="" id="btnJoin">회원가입</a>
	</div>
	<div class="title-box">
		<span id="title-top">국가자격증 기출문제</span><br />
		<span id="title">오모리닷컴</span><br />
		<span id="title-bottom"><span>오</span>답풀이, <span>모</span>의고사, <span>리</span>플레이(반복학습)</span>
	</div>
	<div class="nonmember">
		<a href="${pageContext.request.contextPath}/mock_test/mock_test">비회원 로그인</a>
	</div>
</div>

<!-- login and join modal -->
<div class="login-container">
	<%@ include file="../user/login_and_join.jsp" %>
</div>
<!-- .................... -->
</body>
</html>