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

<script>
	$(function(){
		/* swal({
			title: "최근에 푼 기출문제를 가져올까요?",
			showCancelButton:true,
			cancelButtonText: "아니오",
			confirmButtonText: "네",
			closeOnConfirm:false
		}, function(isConfirm){
			if(isConfirm){
				latestTestName();
			}else{
				location.replace("${pageContext.request.contextPath}/mock_test/start_test/"+1);
			}
		}); */
	});//end of ready
	
	/* function latestTestName(){
		var res;
		$.ajax({
			url:"${pageContext.request.contextPath}/mock_test/latestTestName",
			type:"post",
			async:false,
			success:function(result){
				console.log("latestTestName------------------");
				console.log(result);
				res = result;
			},
			error:function(e){
				alert("에러가 발생하였습니다.");
			}
		});
		
		//최근에 푼 기출문제가 없으면 새로 선택해서 풀도록 함
		if(res == ""){
			setTestNameList();
		}
		//최근에 푼 기출문제가 있을 때
		else{
			location.replace("${pageContext.request.contextPath}/mock_test/start_test/"+res.tno);
		}
	} *///latestTestName
	
	/* function setTestNameList(){
		selectAllTestName("${pageContext.request.contextPath}/admin/selectAllTestName").done(function(data){
			console.log("selectAllTestName data : " + data);
			
			//select태그 생성
			var $option = "<select id='testNameList'><option selected='selected' value='0'>기출문제를 선택해주세요.</option>";
			for(var i = 0; i < data.length; i++){
				$option += "<option value="+data[i].tno+">"
							+ "<span>"+data[i].tname+"</span>"
							+ " <span>"+data[i].tdate+"</span>"
							+ "</option>";
			}
			$option += "</select>";
			
			//옵션에서 선택된 기출문제
			var tno = 0;
			var tname = "";
			$(document).on("change", "#testNameList", function(){
				tno = $(this).val();
				tname = $(this).find("option:selected").text();
			});
			
			//확인버튼을 누르면 그 기출문제를 가져옴
			swal({
				title: "최근에 푼 기출문제가 없습니다",
				html:true,
				text: $option,
				confirmButtonText: "확인",
				closeOnConfirm:false
			}, function(isConfirm){
				if(tno != 0){
					location.replace("${pageContext.request.contextPath}/mock_test/start_test/"+tno);
				}else{
					return false;
				}
			});
		});
	} *///setTestNameList
</script>

