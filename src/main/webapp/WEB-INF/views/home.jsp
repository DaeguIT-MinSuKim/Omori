<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="include/index.jsp"%>

<c:if test="${!empty showLoginForm}">
	<script>
		$(function(){
			$('#btnLogin').click();	
		});
	</script>
</c:if>

<c:if test="${!empty showFailLoginForm}">
	<script>
		$(function(){
			$(".login-container").css("display", "block");
			
			swal({
				title:"존재하지 않는 아이디입니다"
			});
		});
	</script>
</c:if>

<c:if test="${!empty showJoinForm}">
	<script>
		$(function(){
			$("#btnJoin").click();
		});
	</script>
</c:if>