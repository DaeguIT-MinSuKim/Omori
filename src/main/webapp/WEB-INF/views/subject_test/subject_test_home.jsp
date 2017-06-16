<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.section h1{
	color:#eee;
}
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}
.select-test-box{background: #ff00ff;}
.select-subject-box{display: none;}
</style>

<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>과목별 시험</h1>
			<div class="inner-section">
				<div class="select-test-box">
					<div class="latest-test">
						<h3>최근에 푼 기출문제</h3>
						<c:if test="${empty testName }">
							<p>최근에 푼 기출문제가 없습니다</p>
						</c:if>
						<c:if test="${!empty testName }">
							<p>
								<a href='' tno="${testName.tno}">${testName.tname}</a>
							</p>
						</c:if>
					</div>
					<div class="test-list-box">
						<h3>기출문제 목록</h3>
						<c:forEach var="obj" items="${testNameList}">
							<p><a href='' tno="${obj.tno}">${obj.tname}</a></p>
						</c:forEach>
					</div>
				</div>
				<div class="select-subject-box">
					<div class="jeong-bo-gisa">
						<p><a href="">데이터베이스</a></p>
						<p><a href="">전자계산기구조</a></p>
						<p><a href="">운영체제</a></p>
						<p><a href="">소프트웨어공학</a></p>
						<p><a href="">데이터통신</a></p>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
	$(".select-test-box a").click(function(e){
		e.preventDefault();
		var tno = $(this).attr("tno");
		
		$(this).parents(".select-test-box").slideUp("slow", function() {
			$(".select-subject-box").slideDown("slow");	
		});
		
		$(".select-subject-box a").each(function(i, obj) {
			$(obj).attr("tno", tno);
		})
	});
	
	$(".select-subject-box a").click(function(e){
		e.preventDefault();
		var tno = $(this).attr("tno");
		var subject = $(this).text();
		location.replace("${pageContext.request.contextPath}/subject_test/"+tno+"/"+subject);
	});
</script>