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
.each-question{display: inline-block;width: 29%;margin: 12px;vertical-align: top;background: #fdf8e9;padding: 14px;border-radius: 5px; box-shadow: 1px 1px 1px 0.5px grey;}
.select-testname-box {text-align: center; margin-bottom:30px;}
.select-testname-box a{display: inline-block;margin: 0px 10px;color:#178da9; padding:10px 0; font-size: 14px;}
.select-testname-box a.selected-subject{border-bottom:2px solid #178da9; color: #000;}
.each-question .subject-box p{font-size:14px; color:#6e4a37;}
.each-question .question-box p{font-weight: bold; font-family: "돋움"; color:#6e4a37;}
.each-question .example-box{border-bottom: 1px dashed #6e4a37;}
.each-question .example-box p{padding-left:17px; font-size:13px; font-family: "돋움";}
.each-question .answer-box p{margin:5px 0; font-family: "돋움"; font-size:14px;}
.each-question .answer-box p:FIRST-CHILD{margin-top:15px;}
.each-question .answer-box p:LAST-CHILD{text-align: right;}
.each-question .answer-box p:LAST-CHILD span{color:#d74526 !important; font-weight: bold;}


.note-box label{font-size:14px; color:#6e4a37;}
.note-box textarea[disabled='disabled']{background: #f5f5f5; }
.note-box textarea{outline:0; background: #fff; border: 0;margin: 0 0 15px; padding: 10px; box-sizing: border-box; 
					font-size: 12px; display: block; color:#333; width:100%; height:100px;}

/* ------------
	로딩 이미지
-------------*/
.add-question-popup .login-page .form .login-form{display:none;}
.loading-box {display:none;}

</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<div class="inner-section">
				<h1>오답노트</h1>
				<div class="select-testname-box">
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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/note.js"></script>
<script>
var firstTno = ${firstTestName.tno};
var firstTname = "${firstTestName.tname}";

$(document).on("ready", function(){
	//Ajax 로딩 이미지
	$(window).ajaxStart(function(){
		$(".show-note-box").css("display","none");
		$(".loading-box").css("display", "block");
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
	$(".show-note-box").html("");
	
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
		$divAnswer.append("<p><span>내 정답률 : </span><span>"+obj.tq_per+" %</span></p>");
		$topDiv.append($divAnswer);
		
		//오답노트
		var $divTopNote = $("<div class='note-box' noteno='"+obj.note.note_no+"' tqno='"+obj.tq_no+"'>");
		var $divInnerNote = $("<div class='note-box-inner'>");
		$divInnerNote.append("<p><label>풀이</label><textarea class='note_content'>"+obj.note.note_content+"</textarea></p>");
		$divInnerNote.append("<p><label>메모</label><textarea class='note_memo'>"+obj.note.note_memo+"</textarea></p>");
		var $divButton = $("<div class='note-button-box'>");
		$divButton.append("<span class='add'><button class='addNoteBtn small-btn-style'>등록</button></span>");
		$divButton.append("<span class='up-and-del'><button class='updateNoteBtn small-btn-style'>수정</button><button class='delNoteBtn small-btn-style'>삭제</button></span>");
		$divButton.append("<span class='com-and-can'><button class='updateCompleteBtn small-btn-style'>확인</button><button class='updateCancelBtn small-btn-style'>취소</button></span>");
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
