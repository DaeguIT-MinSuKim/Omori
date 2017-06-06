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
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>모의고사</h1>
			<div class="inner-section">
				<div class="mocktest-box">
					<table class='table'>
						<tr>
							<td colspan="2" id="testName"></td>
						</tr>
						<tr class="first-table">
							<td class='table-left'>
								<table></table>
							</td>
							<td class='table-right'>
								<table></table>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="paging"></td>
						</tr>
					</table>
				</div>
				<div class="omr-box">
					<table class="table">
						<tr>
							<td colspan="5" id="time-zone">00 : 00 : 00</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
</div>