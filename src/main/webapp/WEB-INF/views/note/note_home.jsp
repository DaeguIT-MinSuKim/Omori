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
.each-question{display: inline-block; background:#ff0000; width:31%; margin-left:20px; vertical-align: top;}
    
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
				<div class="show-note-box"></div>
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
		/* $(".show-note-box").css("display","none"); */
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
			
			//오답노트가 존재하는 것만 보여지기 때문에 수정, 삭제버튼만 나타나게 하고
			//textarea는 disabled시킴
			$(".note-box").find("textarea").attr("disabled", "disabled");
			$(".note-box").find(".up-and-del").show();
			$(".note-box").find(".add").hide();
			$(".note-box").find(".com-and-can").hide();
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/*--------------- 
	태그로 만들기
---------------*/
function makeTag(result){
	for(var i=0; i<result.length; i++){
		var obj = result[i];
		var $topDiv = $("<div class='each-question' tno='"+obj.testName.tno+"'>");
		
		//과목
		var $divSubject = $("<div class='subject-box'>")
		$divSubject.html("<p>"+obj.tq_subject+"</p>");
		$topDiv.append($divSubject);
		
		//문제
		var $divQuestion = $("<div class='question-box' tqanswer='"+obj.tq_answer+"'>");
		$divQuestion.html("<p><span>"+obj.tq_small_no+". </span><span>"+obj.tq_question+"</span></p>");
		$topDiv.append($divQuestion);
		
		//이미지
		var $divImage = $("<div class='image-box'>");
		for(var j = 0; j < obj.imageList.length; j++){
			var image = obj.imageList[j];
			$divImage.append("<p><img src='${pageContext.request.contextPath}/resources/upload/"+image.imgsource+"'></p>");
		}
		$topDiv.append($divImage);

		//보기
		var $divExample = $("<div class='example-box'>");
		for(var j = 0; j < obj.exampleList.length; j++){
			var example = obj.exampleList[j];
			$divExample.append("<p><span>"+example.te_small_no+". </span>"+example.te_content+"</p>");	
		}
		$topDiv.append($divExample);
		
		//정답, 내가 선택한 답, 정답률
		var $divAnswer = $("<div class='answer-box'>");
		$divAnswer.append("<p><span>정답 : </span><span>"+obj.tq_answer+"</span></p>");
		var myAnswer = "X";
		if(obj.answer != null){
			myAnswer = obj.answer.sa_answer;
		}
		$divAnswer.append("<p><span>내가 최근에 선택한 답 : </span><span>"+myAnswer+"</span></p>");
		$divAnswer.append("<p><span>내 정답률 : </span><span>"+obj.tq_per+"</span></p>");
		$topDiv.append($divAnswer);
		
		//오답노트
		var $divTopNote = $("<div class='note-box' noteno='"+obj.note.note_no+"' tqno='"+obj.tq_no+"'>");
		var $divInnerNote = $("<div class='note-box-inner'>");
		$divInnerNote.append("<p><label>풀이</label><textarea class='note_content'>"+obj.note.note_content+"</textarea></p>");
		$divInnerNote.append("<p><label>메모</label><textarea class='note_memo'>"+obj.note.note_memo+"</textarea></p>");
		var $divButton = $("<div class='note-button-box'>");
		$divButton.append("<span class='add'><button class='addNoteBtn'>등록</button></span>");
		$divButton.append("<span class='up-and-del'><button class='updateNoteBtn'>수정</button><button class='delNoteBtn'>삭제</button></span>");
		$divButton.append("<span class='com-and-can'><button class='updateCompleteBtn'>확인</button><button class='updateCancelBtn'>취소</button></span>");
		$divInnerNote.append($divButton);
		$divTopNote.append($divInnerNote);
		$topDiv.append($divTopNote);
		
		$(".show-note-box").append($topDiv);
	}
}

/*------------------- 
	오답노트수정 ajax
-------------------*/
function updateNotePost(tno, tqno, content, memo){
	$.ajax({
		url:"${pageContext.request.contextPath}/note/updateNotePost",
		type:"post",
		data:{"tno":tno, "tq_no":tqno, "note_content":content, "note_memo":memo},
		success:function(result){
			swal({
				title:"수정되었습니다",
				confirmButtonText: "확인"
			});
			
			$(".note-box").each(function(i, obj) {
				if($(obj).attr("tqno") == tqno){
					$(obj).find("textarea").attr("disabled", "disabled");
					$(obj).find(".up-and-del").show();
					$(obj).find(".com-and-can").hide();
				}
			});
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

/*------------------- 
	오답노트삭제 Ajax
-------------------*/
function deleteNotePost(tno, tqno){
	$.ajax({
		url:"${pageContext.request.contextPath}/note/deleteNotePost",
		type:"post",
		data:{"tno":tno, "tq_no":tqno},
		success:function(result){
			swal({
				title:"삭제되었습니다",
				confirmButtonText: "확인"
			});
			
			$(".note-box").each(function(i, obj) {
				if($(obj).attr("tqno") == tqno){
					$(obj).parents(".each-question").fadeOut("slow");
					/* $(obj).find("textarea").val("");
					$(obj).find("textarea").removeAttr("disabled");
					$(obj).find(".add").show();
					$(obj).find(".up-and-del").hide(); */
				}
			});
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/note.js"></script>