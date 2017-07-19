<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.sweet-alert{width:400px !important;top:40% !important;margin-left: -217px !important;}
.section .latest-test, .test-list-box{margin:40px 0; text-align: center;}
</style>

<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<div class="inner-section">
				<h1>기출문제 수정</h1>
				<div class="test-list-box">
					<h3>기출문제 목록</h3>
					<c:forEach var="obj" items="${testNameList}">
						<p><a href="${pageContext.request.contextPath}/admin/update_test/${obj.tno}">${obj.tname} <small>(${obj.tdate})</small></a></p>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
</div>

