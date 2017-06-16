<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login-join.css" />
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.section h1, .section label{
	color:#eee;
}
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}
.each-question{display:block; background:#ff0000;width:31%; float:left; margin-left:20px;}

/* ------------
	로딩 이미지
-------------*/
.add-question-popup .login-page .form .login-form{display:none;}

.loading-box {display:none;}
.loading-box .load-wrapp {float: left; width: 100%; text-align: center;}
.loading-box .load-wrapp .loading-message{color:#303030;font-size:20px;margin-bottom:10px;}
.loading-box .load-wrapp .load-3 .line {display: inline-block; width: 25px; height: 25px; margin:5px 4px 0; 
										border-radius: 15px; background-color: #4b9cdb;}
.loading-box .clear{clear:both;}

.load-1 .line:nth-last-child(1) {animation: loadingA 1.5s 1s infinite;}
.load-1 .line:nth-last-child(2) {animation: loadingA 1.5s .5s infinite;}
.load-1 .line:nth-last-child(3) {animation: loadingA 1.5s 0s infinite;}

.load-2 .line:nth-last-child(1) {animation: loadingB 1.5s 1s infinite;}
.load-2 .line:nth-last-child(2) {animation: loadingB 1.5s .5s infinite;}
.load-2 .line:nth-last-child(3) {animation: loadingB 1.5s 0s infinite;}

.load-3 .line:nth-last-child(1) {animation: loadingC .6s .1s linear infinite;}
.load-3 .line:nth-last-child(2) {animation: loadingC .6s .2s linear infinite;}
.load-3 .line:nth-last-child(3) {animation: loadingC .6s .3s linear infinite;}

@keyframes loadingC {
    0 {transform: translate(0,0);}
    50% {transform: translate(0, 20px);}
    100% {transform: translate(0,0);}
}
</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>오답노트</h1>
			<div class="inner-section">
				<div class="testNameList">
					<c:if test="${empty testNameList}">
						<script>
							swal({
								title:"등록된 오답 노트가 없습니다!",
								text:"문제를 풀면서 오답 노트를 정리해주세요",
								confirmButtonText: "확인"
							}, function(isConfirm){
								location.replace("${pageContext.request.contextPath}/mock_test/");
							});
						</script>
					</c:if>
					<c:if test="${!empty testNameList}">
						<c:forEach var="obj" items="${testNameList}">
							<a href="" tno="${obj.tno}">${obj.tname}</a>
						</c:forEach>
					</c:if>
				</div>
				<div class="show-note-box">
					<c:forEach var="obj" items="${questionList}">
						<div class="each-question">
							<div class="subject-box">
								<p>${obj.tq_subject }</p>
							</div>
							<div class="question-box" tqanswer="${obj.tq_answer}">
								<p><span>${obj.tq_small_no}. </span><span>${obj.tq_question}</span></p>
							</div>
							<div class="image-box">
								<c:forEach var="image" items="${obj.imageList}">
									<p><img src="${pageContext.request.contextPath}/resources/upload/${image.imgsource}" alt="" /></p>
								</c:forEach>
							</div>
							<div class="example-box">
								<c:forEach var="example" items="${obj.exampleList}">
									<p><a href=""><span>${example.te_small_no}. </span>${example.te_content}</a></p>
								</c:forEach>
							</div>
							<div class="answer-box">
								<p>정답 : <span>${obj.tq_answer}</span></p>
								<p>내가 선택한 답 : ${obj.answer.sa_answer}</p>
								<p>내 정답률 : ${obj.tq_per}</p>
							</div>
							<div class="note-box" noteno="${obj.note.note_no}" tqno="${obj.tq_no}">
								<div class="note-box-inner">
									<p><label for="">풀이</label><textarea cols="50" rows="5" class="note_content" placeholder="여기에 오답 풀이 내용을 입력하세요">${obj.note.note_content}</textarea></p>
									<p><label for="">메모</label><textarea cols="50" rows="5" class="note_memo" placeholder="여기에 메모를 입력하세요">${obj.note.note_memo}</textarea></p>
									<div class="note-button-box">
										<span class='add'>
											<button class="addNoteBtn">등록</button>
										</span>
										<span class="up-and-del">
											<button class="updateNoteBtn">수정</button>
											<button class='delNoteBtn'>삭제</button>
										</span>
										<span class="com-and-can">
											<button class='updateCompleteBtn'>확인</button>
											<button class='updateCancelBtn'>취소</button>
										</span>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- ajax로딩 될 때 뜨는 이미지 -->
				<div class="loading-box">
					<div class="load-wrapp">
						<div class="loading-message">문제와 오답노트 가져오는 중</div>
						<div class="load-3">
							<div class="line"></div>
							<div class="line"></div>
							<div class="line"></div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
var firstTno = ${firstTestName.tno};
var firstTname = "${firstTestName.tname}";

$(document).on("ready", function(){
	//Ajax 로딩 이미지
	$(window).ajaxStart(function(){
		$(".loading-box").css("display", "block");
		$(".show-note-box").css("display","none");
	}).ajaxComplete(function(){
		$(".loading-box").css("display", "none");
		$(".show-note-box").css("display","block");
	});
	
	//오답문제 리스트 불러오기
	getQuestionAnswerNoteAjax(firstTno);
});

/*------------------------------------- 
	문제, 보기, 선택한 답, 정답, 노트 불러오기
-------------------------------------*/
function getQuestionAnswerNoteAjax(tno){
	$.ajax({
		url:"${pageContext.request.contextPath}/note/getQuestionAnswerNote",
		type:"post",
		data:{"tno":tno},
		success:function(result){
			console.log(result);
			makeTag(result);
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/note.js"></script>