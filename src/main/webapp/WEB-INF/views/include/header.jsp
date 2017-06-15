<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
$(function(){
	/* 관리자 버튼 클릭 */
	$("#admin-menu-btn").click(function(e){
		e.preventDefault();
		$(".admin-sub-menu").slideToggle();
	});
	/* ................................. */
});
</script>
</head>
<body>
<header class="header">
	<div class="width1400">
		<div class="title-box">
			<span id="title-top">국가자격증 기출문제</span><br />
			<span id="title"><a href="${pageContext.request.contextPath}/grade/">오모리닷컴</a></span><br />
			<span id="title-bottom"><span>오</span>답풀이, <span>모</span>의고사, <span>리</span>플레이(반복학습)</span>
		</div>
	</div>
	<div class="width1400">
		<div class="top-login-box">
			<c:if test="${empty login}">
				<a href="${pageContext.request.contextPath}/user/login">로그인</a>
				<a href="${pageContext.request.contextPath}/user/join">회원가입</a>
			</c:if>
			<c:if test="${!empty login }">
				<c:if test="${login.isadmin == true}">
					<a href=""><b>관리자</b>로 로그인하셨습니다.</a>
					<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
				</c:if>
				<c:if test="${login.isadmin == false}">
					<a href=""><b>${login.uid}</b>로 로그인하셨습니다.</a>
					<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
				</c:if>
			</c:if>
		</div>
	</div>
	<div class="top-menu-box">
		<div class="width1400">
			<ul>
				<li><a href="${pageContext.request.contextPath}/mock_test/" class="click-event">모의고사</a></li>
				<li><a href="${pageContext.request.contextPath}/subject_test/" class="click-event">과목별 시험</a></li>
				<li><a href="${pageContext.request.contextPath}/one_test/" class="click-event">한 문제씩 풀기</a></li>
				<li><a href="" class="click-event">오답노트</a></li>
				<li><a href="${pageContext.request.contextPath}/grade/" class="click-event">성적 통계</a></li>
				<c:if test="${!empty login }">
					<c:if test="${login.isadmin == true}">
						<li>
							<a href="" class="click-event" id="admin-menu-btn">관리자 메뉴</a>
							<div class="admin-sub-menu">
								<a href="${pageContext.request.contextPath}/admin/insert_test">기출문제 등록</a>
								<a href="${pageContext.request.contextPath}/mock_test/">기출문제 수정</a>
							</div>
						</li>
					</c:if>
				</c:if>
			</ul>
		</div>
	</div>
</header>
</body>
</html>
