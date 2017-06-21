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
<style>
.title-box{text-align: center;}
.title-box .image-box img{width:90px; margin-bottom:10px;}
.title-box .text-box .title-animation .title{font-family: "나눔스퀘어EB"; color:#d74526; font-size:40px;}
.title-box .text-box #title-bottom{font-size:18px; font-family: "나눔스퀘어B"; color:#6e4a37; font-size:15px;}
.title-box .text-box #title-bottom b{font-family: "나눔스퀘어EB"; font-size:17px; color:#d74526;}
.title-box .top-login-box a{display: inline-block; margin:15px 10px; color:#6e4a37; font-family: "나눔바른고딕"}
</style>
<script>
$(function(){
	/*----------------
		관리자 버튼 클릭 
	----------------*/
	$("#admin-menu-btn").click(function(e){
		e.preventDefault();
		$(".admin-sub-menu").slideToggle();
	});
	
	if($(location).attr("href").indexOf("admin") > -1){
		$("#admin-menu-btn").parent("li").find("img").css("display", "inline");
	}else if($(location).attr("href").indexOf("mock_test") > -1){
		$("ul li img").css("display", "none");
		$("ul li a").each(function(i, obj) {
			if($(obj).attr("data-hover") == "모의고사"){
				$(obj).parent("li").find("img").css("display", "inline");
			}
		});
	}else if($(location).attr("href").indexOf("subject_test") > -1){
		$("ul li img").css("display", "none");
		$("ul li a").each(function(i, obj) {
			if($(obj).attr("data-hover") == "모의고사"){
				$(obj).parent("li").find("img").css("display", "inline");
			}
		});
	}
});
</script>
</head>
<body>
<header class="header">
	<div class="width1400">
		<div class="title-box">
			<div class='image-box'>
				<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="" />
			</div>
			<div class="text-box">
				<div class="title-animation">
					<span class="title"><a href="${pageContext.request.contextPath}/grade/"></a>오모리닷컴</span>
				</div>
				<span id="title-bottom"><b>오</b>답풀이, <b>모</b>의고사, <b>리</b>플레이</span>
			</div>
			<div class="top-login-box">
				<c:if test="${empty login}">
					<a href="${pageContext.request.contextPath}/user/login">로그인</a>
					<a href="${pageContext.request.contextPath}/user/join">회원가입</a>
				</c:if>
				<c:if test="${!empty login }">
					<c:if test="${login.isadmin == true}">
						<a href=""><b>관리자</b>로 로그인하였습니다.</a>
						<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
					</c:if>
					<c:if test="${login.isadmin == false}">
						<a href=""><b>${login.uid}</b>로 로그인하였습니다.</a>
						<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
	<div class="top-menu-box">
		<div class="width1400">
			<ul>
				<li><img src="${pageContext.request.contextPath}/resources/images/ic_bookmark.png" alt="" /><a href="${pageContext.request.contextPath}/mock_test/" data-hover="모의고사" class="click-event">모의고사</a></li>
				<li><img src="${pageContext.request.contextPath}/resources/images/ic_bookmark.png" alt="" /><a href="${pageContext.request.contextPath}/subject_test/" data-hover="과목별 시험" class="click-event">과목별 시험</a></li>
				<li><img src="${pageContext.request.contextPath}/resources/images/ic_bookmark.png" alt="" /><a href="${pageContext.request.contextPath}/one_test/" data-hover="한 문제씩 풀기" class="click-event">한 문제씩 풀기</a></li>
				<li><img src="${pageContext.request.contextPath}/resources/images/ic_bookmark.png" alt="" /><a href="${pageContext.request.contextPath}/note/" data-hover="오답노트" class="click-event">오답노트</a></li>
				<li><img src="${pageContext.request.contextPath}/resources/images/ic_bookmark.png" alt="" /><a href="${pageContext.request.contextPath}/grade/" data-hover="성적 통계" class="click-event">성적 통계</a></li>
				<c:if test="${!empty login }">
					<c:if test="${login.isadmin == true}">
						<li>
							<img src="${pageContext.request.contextPath}/resources/images/ic_bookmark_off.png" alt="" />
							<a href="" class="click-event" id="admin-menu-btn" data-hover="관리자 메뉴" >관리자 메뉴</a>
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
