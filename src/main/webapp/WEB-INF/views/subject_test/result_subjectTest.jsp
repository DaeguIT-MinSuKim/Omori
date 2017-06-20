<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}
.mocktest-box{width:84%;float:left;}
.omr-box{width:15%;float:right;}

/*-----------
	table
-----------*/
.table .table-left {padding-left:12px;padding-right:6px;border-right:2px solid #999;}
.table td#markResult{padding-top:20px;padding-bottom:20px;border-bottom:2px dashed #ebd0a7;}
.table td#markResult p{text-align: center; font-family: "나눔바른고딕"; margin:10px;}
.table td#markResult p .markSubjectName{display: inline-block; width:150px;}
.table td#markResult p#lastResult{font-size:18px;}
.table td#markResult p#lastResult #result{display: inline-block; color:#d74526; font-size:20px; margin-left:10px;}
.table td#markResult .save-grade-box button{border: none;border-radius: 5px;background: #e7c59a;padding: 5px 13px;font-size: 15px;color: #6e4a37;font-weight: bold;}
.table tr.question td:FIRST-CHILD span{position:relative; z-index:1;}
.table tr.question img.markimg{position:absolute;width:30px;margin-left:-8px;margin-top:-8px;}


/*------------ 
	보기 클릭 
------------*/
.answer-selected{color:#CC0000 !important;font-weight:bold;}
.changeColor{color:#ff0000 !important;}

/*------------- 
	로딩 이미지 
-------------*/
.table, .omr-box{display:none;}
.loading-box{display:none;}

/*----------- 
	오답풀이 
-----------*/
.note-box .bottom-button .up-and-del, .com-and-can{display:none;}
.note-box {border-top: 2px dotted #f7e9d5; display:none;}
.note-box label{font-size:12px; color:#6e4a37; font-weight: bold;}
.note-box textarea[disabled='disabled']{background: #f5f5f5; }
.note-box textarea{outline:0; background: #fff; border: 0;margin: 0 0 15px; padding: 10px; box-sizing: border-box; 
					font-size: 12px; display: block; color:#333; width:100%; height:100px;}
.notebtn-box .btnCreateNote{border-radius: 5px;padding: 5px 13px;background: none;color: #6e4a37;border: 1px solid #6e4a37;}
.notebtn-box .btnCreateNote:HOVER {background: #fbf9f2; font-weight: bold; border-color: rgba(0,0,0,0);}

</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<div class="inner-section">
				<h1>시험 결과</h1>
				<div class="mocktest-box">
					<table class='table'>
						<tr>
							<td colspan="2" id="testName">${testName.tname} <small>(${subject})</small></td>
						</tr>
						<tr>
							<td colspan="2" id="markResult"></td>
						</tr>
						<tr class="first-table">
							<td class="table-left">
								<table></table>
							</td>
							<td class="table-right">
								<table></table>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="paging">
								<button id="prev">이전</button>
								<span id="count"></span> / <span id="allPage"></span>
								<button id="next">다음</button>
							</td>
						</tr>
					</table>
				</div>
				<div class="omr-box">
					<input type="hidden" name="tno" value="${testName.tno}" />
					<table class="table">
						<tr>
							<td colspan="5" id="time-zone">정답</td>
						</tr>
					</table>
				</div>
				<!-- ajax로딩 될 때 뜨는 이미지 -->
				<div class="loading-box">
					<div class="load-wrapp">
						<div class="loading-message">시험 결과 가져오는 중</div>
						<div class="load-3">
							<div class="line"></div>
							<div class="line"></div>
							<div class="line"></div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</section>
</div>
<script src="${pageContext.request.contextPath}/resources/js/subject_test_result.js"></script>
<script>
var tno = ${testName.tno};
var tname = "${testName.tname}";
var subject = "${subject}";

$(function(){
	/* 로딩이미지띄우기 */
	$(window).ajaxStart(function(){
		$(".loading-box").css("display", "block");
	}).ajaxComplete(function(){
		$(".loading-box").css("display", "none");
		$(".table").css("display","table");
		$(".omr-box").css("display","table");
	});
	
	getMarkSubjectTestAjax();
	clickNoteButtons();
});

/*----------------------------------------
	채점을 하기위해 받아오는 questionList Ajax 
----------------------------------------*/
function getMarkSubjectTestAjax(){
	$.ajax({
		url:"${pageContext.request.contextPath}/subject_test/getMarkSubjectTest/",
		data:{"tno":tno, "tq_subject":subject},
		type:"post",
		success:function(result){
			getNowGradeAjax();
			makeTags(result);
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/*--------------------------- 
	방금 푼 모의고사 성적을 가져옴
---------------------------*/
function getNowGradeAjax(){
	$.ajax({
		url:"${pageContext.request.contextPath}/subject_test/getNowGrade/",
		data:{"tno":tno, "tq_subject":subject},
		type:"post",
		success:function(result){
			console.log("getNowGradeAjax....................");
			makeMarkResult(result);
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

/*---------------
	테이블 만들기
---------------*/
function makeTags(result){
	for(var i=0; i<result.length; i++){
		var obj = result[i];
		
		//테이블 생성 (좌 : 5개, 우 : 5개)
		var $table;
		if(i == 0){
			$table = $(".first-table").find(".table-left").find("table");
		}else if(i == 5){
			$table = $(".first-table").find(".table-right").find("table");
		}else if(i == 10){
			//.first-table을 더 생성
			var $copy_table = $(".first-table").html();
			var $new_table = $("<tr>").html($copy_table);
			$(".first-table").after($new_table);
			$new_table.addClass("added-table");
			$new_table.find("table").html("");
			
			$table = $(".added-table").last().find(".table-left").find("table");
		}else if(i == 15){
			$table = $(".added-table").last().find(".table-right").find("table");
		}else if(i == 20 || i == 30 || i == 40 || i== 50 || i == 60 || i == 70 || i == 80 || i == 90){
			var $copy_table = $(".first-table").html();
			var $new_table = $("<tr>").html($copy_table);
			$(".added-table").last().after($new_table);
			$new_table.addClass("added-table");
			$new_table.find("table").html("");
			
			$table = $(".added-table").last().find(".table-left").find("table");
		}else if(i == 25 || i == 35 || i == 45 || i == 55 || i == 65 || i == 75 || i == 85 || i == 95){
			$table = $(".added-table").last().find(".table-right").find("table");
		}
		
		//과목(과목명이 이전과 달라지면 그 때 과목명을 한 번 더 삽입)
		/* var $tr_subject = $("<tr>").html("<td colspan='2' class='subject'>"+obj.tq_subject+"</td>");
		if( i == 0 ){
			$table.append($tr_subject);
		}else if( (i>0) && (result[i-1].tq_subject != result[i].tq_subject) ){
			$table.append($tr_subject);
		} */
		
		//문제
		var $tr_question = $("<tr class='question'>");
		var markimg = "ic_mark_correct.png";
		if(obj.tq_answer != obj.answer.sa_answer){
			markimg = "ic_mark_incorrect.png";
		}
		$tr_question.append("<td><img src='${pageContext.request.contextPath}/resources/images/"+markimg+"' class='markimg'/><span>"+obj.tq_small_no+". </span></td>");
		$tr_question.append("<td>"+obj.tq_question+"</td>");
		$tr_question.attr("tqno", obj.tq_no);
		$tr_question.attr("tno", obj.testName.tno);
		$tr_question.attr("tqsubject", obj.tq_subject);
		$tr_question.attr("tqsmallno", obj.tq_small_no);
		$tr_question.attr("tqper", obj.tq_per);
		$tr_question.attr("tqanswer", obj.tq_answer);
		
		$table.append($tr_question);
		
		//이미지(이미지가 있을때만 삽입)
		var imageList = obj.imageList; 
		if(imageList.length > 0){
			for(var j=0; j<imageList.length; j++){
				var $tr_image = $("<tr>");
				$tr_image.append("<td></td>");
				$tr_image.append("<td><img src='${pageContext.request.contextPath}/resources/upload/"+imageList[j].imgsource+"'/></td>");
				$tr_image.attr("tqno", imageList[j].question.tq_no);
				
				$table.append($tr_image);
			}
		}
		
		//보기
		var exampleList = obj.exampleList;
		for(var j=0; j<exampleList.length; j++){
			var example = exampleList[j];
			var $tr_example = $("<tr class='example'>");
			$tr_example.append("<td></td>");
			
			//정답이면 빨간색 표시
			var $a = $("<a>").html("<span class='te_small_no'>"+example.te_small_no+"</span>"+example.te_content);
			if(obj.tq_answer == example.te_small_no){
				$a.addClass("answer-selected");
			}
			
			$tr_example.append($("<td>").html($a));
			$tr_example.attr("teno", example.te_no);
			$tr_example.attr("tqno", example.question.tq_no);
			$tr_example.attr("tesmallno", example.te_small_no);
			
			$table.append($tr_example);
		}
		
		//사용자가 선택한 답
		var answer = obj.answer;
		var $tr_selAnswer = $("<tr class='selectedAnswer'>");
		$tr_selAnswer.append($("<td>"));
		var answerText = answer.sa_answer;
		if(answerText == -1){
			answerText = "";
		}
		$tr_selAnswer.append($("<td>").html("선택한 답 : <span>"+answerText+"</span>"));
		$tr_selAnswer.attr("saanswer", answer.sa_answer);
		
		$table.append($tr_selAnswer);
		
		//오답풀이
		var $tr_note = $("<tr class='notebtn-box'>");
		$tr_note.append("<td>");
		$tr_note.append("<td><button class='btnCreateNote' tqno='"+obj.tq_no+"'>오답풀이 창 열기");
		$table.append($tr_note);
		
		//오답풀이 하는 창
		var $tr_existNote = $("<tr class='note'>");
		$tr_existNote.attr("tno", obj.testName.tno);
		$tr_existNote.attr("tqno", obj.tq_no);
		$tr_existNote.append("<td>");
		
		var $div_en = $("<div class='note-box'>");
		
		var $p1 = $("<p>");
			$p1.append($("<label>").html("내용"));
				var $textarea1 = $("<textarea name='note_content' class='note_content'>");
			$p1.append($textarea1);
		$div_en.append($p1);
		
		var $p2 = $("<p>");
			$p2.append($("<label>").html("메모"));
				var $textarea2 = $("<textarea name='note_memo' class='note_memo'>");
			$p2.append($textarea2);
		$div_en.append($p2);
		
		var $p3 = $("<p class='bottom-button'>");
			var $span1 = $("<span class='add'>").html("<button class='addNoteBtn small-btn-style'>등록</button>");
			$p3.append($span1);
			var $span2 = $("<span class='up-and-del'>").html("<button class='updateNoteBtn small-btn-style'>수정</button><button class='delNoteBtn small-btn-style'>삭제</button>");
			$p3.append($span2);
			var $span3 = $("<span class='com-and-can'>").html("<button class='updateCompleteBtn small-btn-style'>확인</button><button class='updateCancelBtn small-btn-style'>취소</button>");
			$p3.append($span3);
		$div_en.append($p3);
		
		$tr_existNote.append($("<td>").html($div_en));
		$table.append($tr_existNote);
		
		if(obj.note != null){
			$textarea1.html(obj.note.note_content);
			$textarea2.html(obj.note.note_memo);
			$textarea1.attr("disabled","disabled");
			$textarea2.attr("disabled","disabled");
			$span1.css("display", "none");
			$span2.css("display", "inline-block");
			$span3.css("display", "none");
		}
		
		//omr
		var $table_omr = $(".omr-box .table");
		var $tr_num = $("<tr class='num'>");
		var $tr_answer = $("<tr class='answer'>");
		if(i % 5 == 0){
			$table_omr.append($tr_num);
			$table_omr.append($tr_answer);	
		}
		
	}//end of for
	
	//omr
	for(var i = 0; i < result.length; i++){
		var obj = result[i];
		var index = 0;
		
		if(i < 5){ index = 0; }
		else if(i < 10){ index = 1; }
		else if(i < 15){ index = 2; }
		else if(i < 20){ index = 3; }
		else if(i < 25){ index = 4; }
		else if(i < 30){ index = 5; }
		else if(i < 35){ index = 6; }
		else if(i < 40){ index = 7; }
		else if(i < 45){ index = 8; }
		else if(i < 50){ index = 9; }
		else if(i < 55){ index = 10; }
		else if(i < 60){ index = 11; }
		else if(i < 65){ index = 12; }
		else if(i < 70){ index = 13; }
		else if(i < 75){ index = 14; }
		else if(i < 80){ index = 15; }
		else if(i < 85){ index = 16; }
		else if(i < 90){ index = 17; }
		else if(i < 95){ index = 18; }
		else if(i < 100){ index = 19; }
		
		var $tr_num = $(".omr-box .table").find("tr.num").eq(index);
		var $tr_answer = $(".omr-box .table").find("tr.answer").eq(index);
		
		$tr_num.append("<td tqno='"+obj.tq_no+"'>"+obj.tq_small_no+"</td>");
		
		var $td = $("<td tqno='"+obj.tq_no+"'>").html(obj.tq_answer);
		$td.append("<span></span>");
		$tr_answer.append($td);
	}//end of for
	
	//페이징
	$("td#paging").find("#count").html("1");
	var lastNum = 0;
	if(result.length-1 < 10) lastNum = 1
	else if(result.length-1 < 20) lastNum = 2
	else if(result.length-1 < 30) lastNum = 3
	else if(result.length-1 < 40) lastNum = 4
	else if(result.length-1 < 50) lastNum = 5
	else if(result.length-1 < 60) lastNum = 6
	else if(result.length-1 < 70) lastNum = 7
	else if(result.length-1 < 80) lastNum = 8
	else if(result.length-1 < 90) lastNum = 9
	else if(result.length-1 < 100) lastNum = 10
	$("td#paging").find("#allPage").text(lastNum);
	
	clickPagingButton();
}
/*-------------------
	오답노트추가 Ajax
-------------------*/
function insertNotePost(tqno, note_content, note_memo){
	$.ajax({
		url:"${pageContext.request.contextPath}/note/insertNotePost",
		type:"post",
		data:{tno:tno, tq_no:tqno, note_content:note_content, note_memo:note_memo},
		success:function(result){
			$("tr.note").each(function(i, obj){
				if($(obj).attr("tqno") == tqno){
					$(obj).find(".note-box .bottom-button .add").css("display", "none");
					$(obj).find(".note-box .bottom-button .up-and-del").css("display", "inline-block");
					$(obj).find(".note-box .bottom-button .com-and-can").css("display", "none");
					$(obj).find(".note-box").find("textarea.note_content").attr("disabled", "disabled");
					$(obj).find(".note-box").find("textarea.note_memo").attr("disabled", "disabled");
				}
			});
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

/*------------------- 
	오답노트수정 Ajax
-------------------*/
function updateNotePost(tqno, note_content, note_memo){
	$.ajax({
		url:"${pageContext.request.contextPath}/note/updateNotePost",
		type:"post",
		data:{tno:tno, tq_no:tqno, note_content:note_content, note_memo:note_memo},
		success:function(result){
			$("tr.note").each(function(i, obj){
				if($(obj).attr("tqno") == tqno){
					$(obj).find(".note-box .bottom-button .add").css("display", "none");
					$(obj).find(".note-box .bottom-button .up-and-del").css("display", "inline-block");
					$(obj).find(".note-box .bottom-button .com-and-can").css("display", "none");
					$(obj).find(".note-box").find("textarea.note_content").attr("disabled", "disabled");
					$(obj).find(".note-box").find("textarea.note_memo").attr("disabled", "disabled");
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
		data:{tno:tno, tq_no:tqno},
		success:function(result){
			$("tr.note").each(function(i, obj){
				if($(obj).attr("tqno") == tqno){
					$(obj).find(".note-box .bottom-button .add").css("display", "inline-block");
					$(obj).find(".note-box .bottom-button .up-and-del").css("display", "none");
					$(obj).find(".note-box .bottom-button .com-and-can").css("display", "none");
					$(obj).find(".note-box").find("textarea.note_content").val("");
					$(obj).find(".note-box").find("textarea.note_memo").val("");
					$(obj).find(".note-box").find("textarea.note_content").removeAttr("disabled");
					$(obj).find(".note-box").find("textarea.note_memo").removeAttr("disabled");
				}
			});
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

/*----------------
	성적저장 Ajax 
----------------*/
function insertGradeOnlySubjectAjax(grade, sendSubject, subjectGrade){
	$.ajax({
		url:"${pageContext.request.contextPath}/grade/insertGradeOnlySubject",
		type:"post",
		data:{"tno" : tno, "grade" : grade, "subject" : sendSubject, "subjectGrade" : subjectGrade},
		succes:function(result){
			console.log(result);
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

/*-------------------------- 
	오답풀이 하는 창 열기 버튼 클릭
--------------------------*/
$(document).on("click", ".notebtn-box td button", function() {
	var $thisButton = $(this);
	var tqno = $(this).attr("tqno");
	
	$(".note").each(function(i, obj) {
		if($(obj).attr("tqno") == tqno){
			if($thisButton.text() == "오답풀이 창 열기"){
				$(obj).find(".note-box").slideDown("slow");
			}else{
				$(obj).find(".note-box").slideUp("slow");
			}
		}
	});

	if($(this).text() == "오답풀이 창 열기"){
		$(this).text("오답풀이 창 닫기");
	}else{
		$(this).text("오답풀이 창 열기");
	}
});
</script>

