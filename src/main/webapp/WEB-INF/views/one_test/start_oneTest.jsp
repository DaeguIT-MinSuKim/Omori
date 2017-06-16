<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">

<!-- slick -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/slick/slick/slick.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/slick/slick/slick-theme.css">
<style>
.inner-section{background:#ebf4f9;min-height:0px;}
.section h1{
	color:#000;
}
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}

.test-name-box #testName{text-align: center;font-size: 20px;color: #000;}
.select-subject-box .jeong-bo-gisa{text-align: center;}
.select-subject-box .jeong-bo-gisa a{display: inline-block;margin: 0px 10px;width: 130px; color:#598cb5; padding:10px 0;}
.select-subject-box .jeong-bo-gisa a.selected-subject{border-bottom:2px solid #598cb5; color: #000;}
.each-question{color: #000;}

/* 토글 버튼 */
figure{margin-top: 40px; margin-left: 20%; display:block;width:100%;}
figure span{position:relative; top:-13px;}
#switchAnswer, 
#switchNote {width:65px; padding:5px; border:4px solid #4a95d2; box-sizing:border-box; opacity:0.5;
			-webkit-filter:grayscale(100%); -webkit-transition:all 03s; transition:all 0.3s;border-radius:540px;cursor:pointer;
			display: inline-block; margin-right:25px;}
#switchAnswer .toggle, 
#switchNote .toggle{width:15px;height:15px; background:#4a95d2; border-radius:100%; position:relative;
  					transition:all 0.3s; left:0; -webkit-transition:all 0.3s;}
#switchAnswer.hover .toggle,
#switchNote.hover .toggle{left:33px;}
#switchAnswer.hover,
#switchNote.hover {-webkit-filter:none; opacity:1;}

/*------------------------------ 
	문제, 보기, 정답, 오답노트 영역
------------------------------*/
.slider {width: 60%; height:60%; margin: 0px auto;}
.slick-slide {margin: 0px 20px;}
.slick-slide img {max-width: 600px; max-height:400px;}
.slick-prev{left:-45px !important;}
.slick-prev:before, .slick-next:before {color: #000; padding:10px;}

.each-question{font-family: "돋움";}
.question-box img{width:30px; position:absolute; margin-left:-10px; margin-top:-5px; visibility: hidden;}
.question-box p{position:relative;}
.each-question .example-box a{color:#333333;}
.each-question .example-box a:HOVER{color:#cc0000;}

a.answer-selected{color:#CC0000 !important;font-weight:bold;}
*:FOCUS{outline: none;}

/*-------------
	로딩 이미지
-------------*/
.loading-box{display:none;}
.load-wrapp {
    float: left;
    width: 100%;
   	text-align: center;
    margin-top:200px;
}
.loading-message{
	color:#eee;
	font-size:20px;
	margin-bottom:10px;
}
.line {
    display: inline-block;
    width: 25px;
    height: 25px;
    margin:5px 4px 0;
    border-radius: 15px;
    background-color: #4b9cdb;
}
.clear{
	clear:both;
}

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
			<h1>한 문제씩 풀기</h1>
			<div class="inner-section">
				<div class="test-name-box">
					<p id="testName">${testName.tname} <small>(${testName.tdate})</small></p>
				</div>
				<div class="select-subject-box">
					<div class="jeong-bo-gisa">
						<a href="">데이터베이스</a>
						<a href="">전자계산기구조</a>
						<a href="">운영체제</a>
						<a href="">소프트웨어공학</a>
						<a href="">데이터통신</a>
					</div>
				</div>
				
				<div class="one-test-box">
					<figure>
						<span>정답</span>
						<div id="switchAnswer" class="hover">
							<div class="toggle"></div>
						</div>
						<span>오답노트</span>
						<div id="switchNote" class="hover">
							<div class="toggle"></div>
						</div>
					</figure>
					<div class="fade slider">
						<c:forEach var="obj" items="${questionList}">
							<div class='each-question slider1'>
								<div class="question-box" tqanswer="${obj.tq_answer}">
									<div>
										<img src="${pageContext.request.contextPath}/resources/images/ic_mark_correct.png" class='correct' alt="" />
										<img src="${pageContext.request.contextPath}/resources/images/ic_mark_incorrect.png" class='incorrect' alt="" />
										<p><span>${obj.tq_small_no}. </span><span>${obj.tq_question} </span><button class="markBtn">채점</button></p>
									</div>
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
				</div>
				<!-- ajax로딩 이미지 -->
				<div class="loading-box">
					<div class="load-wrapp">
						<div class="loading-message">기출문제 불러오는 중</div>
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
<!-- slick -->
<script src="${pageContext.request.contextPath}/resources/slick/slick/slick.js" type="text/javascript" charset="utf-8"></script>

<script src="${pageContext.request.contextPath}/resources/js/one_test_start.js" type="text/javascript" charset="utf-8"></script>
<script>
var tno = ${testName.tno};

$(document).on("ready", function() {
	$(".fade").slick({
		dots: true,
		infinite: false,
		swipe:false,
		slidesToShow: 1,
		focusOnSelect: true,
		adaptiveHeight: true
	});
});

/*-------------------
	오답노트추가 ajax
-------------------*/
function insertNotePost(tqno, content, memo){
	$.ajax({
		url:"${pageContext.request.contextPath}/note/insertNotePost",
		type:"post",
		data:{"tno":tno, "tq_no":tqno, "note_content":content, "note_memo":memo},
		success:function(result){
			swal({
				title:"등록되었습니다",
				confirmButtonText: "확인"
			});
			
			$(".note-box").each(function(i, obj) {
				if($(obj).attr("tqno") == tqno){
					$(obj).find("textarea").attr("disabled", "disabled");
					$(obj).find(".add").hide();
					$(obj).find(".up-and-del").show();
				}
			});
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

/*------------------- 
	오답노트수정 ajax
-------------------*/
function updateNotePost(tqno, content, memo){
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
function deleteNotePost(tqno){
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
					$(obj).find("textarea").val("");
					$(obj).find("textarea").removeAttr("disabled");
					$(obj).find(".add").show();
					$(obj).find(".up-and-del").hide();
				}
			});
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}
</script>
