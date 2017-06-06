<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	
	<!-- chart -->
	<script src="${pageContext.request.contextPath}/resources/graph/chartist.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/graph/chartist-plugin-tooltip.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/graph/chartist.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/graph/chartist-plugin-tooltip.css">

	<!-- alert -->
	<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login-join.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
	
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
	
	/* 그래프 1 */
	var data = {
			labels : [ '05-21', '05-22', '05-23', '05-24', '05-25' ],
			series : [ [
			            {meta: '데이터베이스', value: 68 },
			            {meta: '데이터베이스', value: 70},
			            {meta: '데이터베이스', value: 88},
			            {meta: '데이터베이스', value: 90},
			            {meta: '데이터베이스', value: 92}
			          ], [
				            {meta: '전자계산기구조', value: 70},
				            {meta: '전자계산기구조', value: 50},
				            {meta: '전자계산기구조', value: 72},
				            {meta: '전자계산기구조', value: 65},
				            {meta: '전자계산기구조', value: 60}
				          ] ],
			
		};

	var options = {
		low:20,
		high:100,
		width : 320,
		height : 280,
		plugins: [Chartist.plugins.tooltip()]
	};

	new Chartist.Line('.ct-chart', data, options);
	/* ............................................. */
	
	/* 그래프2 */
	var data2 = {
			labels : [ '2016-1회', '2016-2회', '2016-3회', '2017-1회', '2017-2회' ],
			series : [ [ 
			             {meta : '2016-1회', value : 68}, 
			             {meta : '2016-2회', value : 70}, 
			             {meta : '2016-3회', value : 88}, 
			             {meta : '2017-1회', value : 90}, 
			             {meta : '2017-2회',value : 92} ]
			]};

	var options2 = {
		high : 100,
		low : 50,
		width : 350,
		height : 280,
		axisX : {
			labelInterpolationFnc : function(value, index) {
				return index % 2 === 0 ? value : null;
			}
		},
		plugins : [ Chartist.plugins.tooltip() ]
	};

	new Chartist.Bar('.ct-chart2', data2, options2);
	/* ............................................. */
});
</script>	
</head>
<body>
<div class="wrapper">
	<nav class="nav-top">
		<div class="width1400">
			<div class="top-nav-box">
				<h3>최근 본 시험</h3>
				<div class="menu-box">
					<a href="">정보처리기사 2017년 1회 12313321321321321321321321321321302320321321321321321321321</a>
					<a href="">정보처리기사 2017년 2회</a>
					<a href="">정보처리기사 2017년 3회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
				</div>
			</div>
			<div class="top-nav-box">
				<h3>많이 본 시험</h3>
				<div class="menu-box">
					<a href="">정보처리기사 2017년 1회</a>
					<a href="">정보처리기사 2017년 2회</a>
					<a href="">정보처리기사 2017년 3회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
					<a href="">정보처리기사 2017년 4회</a>
				</div>
			</div>
			<div class="top-nav-box">
				<h3>성적 그래프</h3>
				<div class="ct-chart ct-perfect-fourth"></div>
				<div class="ct-chart2 ct-perfect-fourth"></div>
			</div>
		</div>
	</nav>
	
	<aside class="aside">
		<div class="width1400">
			<div class="login-join">
				<c:if test="${empty login}">
					<a href="#" id="btnLogin">로그인</a>
					<a href="#" id="btnJoin">회원가입</a>
				</c:if>
				
				<c:if test="${!empty login}">
					<a href="">${login.uid}님 반갑습니다</a>
					<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
				</c:if>
			</div>
		</div>
	</aside>
	
	<header class="header">
		<div class="title-box">
			<span id="title-top">국가자격증 기출문제</span><br />
			<span id="title">오모리닷컴</span><br />
			<span id="title-bottom"><span>오</span>답풀이, <span>모</span>의고사, <span>리</span>플레이(반복학습)</span>
		</div>
	</header>
	
	<nav class="nav-bottom">
		<div class="width1400">
			<div class="bottom-nav-box">
				<button>모의 시험</button>
				<button>과목별 시험</button>
				<button>한 문제씩 풀기</button>
				<button>오답노트</button>
			</div>
		</div>
	</nav>
</div>

<!-- login and join modal -->
<div class="login-container">
	<%@ include file="../user/login_and_join.jsp" %>
</div>
<!-- .................... -->
</body>
</html>