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
</style>

<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>한 문제씩 풀기</h1>
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
			</div>
		</div>
	</section>
</div>

<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
	$(".select-test-box a").click(function(e){
		e.preventDefault();
		var tno = $(this).attr("tno");
		
		location.replace("${pageContext.request.contextPath}/one_test/"+tno);
	});
</script>