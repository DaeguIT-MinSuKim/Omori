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
.width1400 h1{text-align: center;}
</style>

<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			
			<c:if test="${login.isadmin}">
				<h1>기출문제 수정</h1>
			</c:if>
			<div class="inner-section">
				<c:if test="${!login.isadmin}">
					<h1>모의고사</h1>
				</c:if>
				<c:if test="${!login.isadmin}">
					<div class="latest-test">
						<h3>최근에 푼 기출문제</h3>
						<c:if test="${empty testName }">
							<p>최근에 푼 기출문제가 없습니다</p>
						</c:if>
						<c:if test="${!empty testName }">
							<p>
								<a href="${pageContext.request.contextPath}/mock_test/start_test/${testName.tno}">${testName.tname}</a>
							</p>
						</c:if>
					</div>
				</c:if>
				<div class="test-list-box">
					<h3>기출문제 목록</h3>
					<c:if test="${!login.isadmin}">
						<c:forEach var="obj" items="${testNameList}">
							<p><a href="${pageContext.request.contextPath}/mock_test/start_test/${obj.tno}">${obj.tname }</a></p>
						</c:forEach>
					</c:if>
					<c:if test="${login.isadmin}">
						<c:forEach var="obj" items="${testNameList}">
							<p><a href="${pageContext.request.contextPath}/admin/update_test/${obj.tno}">${obj.tname }</a></p>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</section>
</div>

