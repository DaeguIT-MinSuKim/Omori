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
</style>
<h1>tqno</h1>
<c:forEach var="tqno" items="${tq_noList }" end="10">
	<p>${tqno }</p>
</c:forEach>
<h1>sa_answer</h1>
<c:forEach var="answer" items="${sa_answerList }">
	<p>${answer }</p>
</c:forEach>