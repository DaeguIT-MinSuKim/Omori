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
.mocktest-box{
	width:84%;
	float:left;
}
.omr-box{
	width:15%;
	float:right;
}
/* ............ */
/* table 		*/
/* ............ */
.added-table{
	display:none;
}
.table{
	width:100%;
	border:2px solid #999;
	background:rgba(240,240,240,1);
}
.table td{
	font-family: "돋움";
}
.table td#testName{
	padding-top:20px;
	padding-bottom:20px;
	text-align: center;
	font-weight:bold;
	font-size:20px;
	color:#222;
	border-bottom:2px solid #999;
}
.table td#markResult{
	padding-top:20px;
	padding-bottom:20px;
	border-bottom:2px solid #999;
}
.table td.subject{
	color:#3333cc;
	font-weight: bold;
	font-size:18px;
	text-align: center;
	padding-top:30px;
}
.table #paging{
	padding-top:20px;
	padding-bottom:20px;
	text-align: left;
	border-top:2px solid #999;
}
.table tr.question{
	vertical-align: top;
	font-weight: bold;
	color:#303030;
}
.table tr.question td{
	padding-top:30px;
	padding-bottom:10px;
	font-size:14px;
}
.table tr.question td:FIRST-CHILD{
	text-align: left;
}
.table tr.question td:FIRST-CHILD span{
	position:relative;
	z-index:1;
}
.table tr.question img.markimg{
	position:absolute;
	width:30px;
	margin-left:-8px;
	margin-top:-8px;
}

.table tr.example td{
	padding:5px 5px;
}
.table tr.example a{
	line-height:22px;
	color:#333;
	font-size:12px;
}
.table tr.example span.te_small_no{
	border: 1px solid #cc0000;
    width: 20px;
    height: 20px;
    margin-right: 10px;
    padding:2px 6px;
}

.table-left, .table-right{
	width:500px;
	vertical-align: top;
	padding-bottom:30px;
}
.table-left {
	padding-left:12px;
	padding-right:6px;
	border-right:2px solid #999;
}
.table-right{
	padding-right:12px;
	padding-left:6px;
}

/* 보기 클릭 */
.answer-selected{
	color:#CC0000 !important;
	font-weight:bold;
}
.changeColor{
	color:#ff0000 !important;
}

/* .omr-box */
.omr-box .table{
	width:100%;
	border-collapse: collapse;
}
.omr-box .table td{
	width:25px;
	text-align:center;
	font-size:14px;
	padding:3px 5px;
	border:1px solid #999;
}
.omr-box .table td a{
	color:#333;
}
.omr-box .table tr.num td{
	color:#303030;
	font-weight: bold;
}
.omr-box .table tr.answer td{
	font-size:12px;
	height:25px;
	color:#cc0000;
}
.omr-box #time-zone, #btnSendAnswer{
	color:#303030;
	font-size:20px;
	font-weight:bold;
	padding:20px 0;
}
.omr-box #time-zone{
	color:#ff3333;
}

/* 로딩 이미지 */
.table, .omr-box{
	display:none;
}

.loading-box{
	display:none;
}

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

/* 오답풀이 */
.note-box .bottom-button .up-and-del, .com-and-can{
	display:none;
}
</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>채점결과</h1>
			<div class="inner-section">
				<div class="mocktest-box">
					<table class='table'>
						<tr>
							<td colspan="2" id="testName">${testName.tname} <small>(${testName.tdate})</small></td>
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
			</div>
		</div>
	</section>
</div>
<script>
	var tno = ${testName.tno};
	var tname = "${testName.tname}";
	
	$(function(){
		/* 로딩이미지띄우기 */
		$(window).ajaxStart(function(){
			$(".loading-box").css("display", "block");
		}).ajaxComplete(function(){
			$(".loading-box").css("display", "none");
			$(".table").css("display","table");
			$(".omr-box").css("display","table");
		});
		
		markMockTest();
		
		/* 성적 저장 버튼 클릭 */
		$(document).on("click", "#btnSaveGrade", function(e){
			e.preventDefault();
			
			var grade = $(this).parent(".save-grade-box").attr("grade");
			var arrSubject = $(this).parent(".save-grade-box").attr("subject");
			var arrSubjectGrade = $(this).parent(".save-grade-box").attr("subject_grade");
			
			swal({
				title:"지금 본 모의고사의 성적을 저장할까요?",
				text:"회원님의 성적 통계에 반영됩니다.",
				showCancelButton:true,
				cancelButtonText: "아니오",
				confirmButtonText: "네",
				closeOnConfirm:false
			}, function(isConfirm){
				if(isConfirm){
					insertGradeAllAjax(grade, arrSubject, arrSubjectGrade);
					$("#btnSaveGrade").css("display", "none");
					swal.close();
				}
			});
		});
		
		clickNoteButtons();
	});
	
	/* markMockTest : 채점을 하기위해 받아오는 TestQuestionList */
	function markMockTest(){
		$.ajax({
			url:"${pageContext.request.contextPath}/mock_test/markMockTest/"+tno,
			type:"post",
			success:function(result){
				console.log("markMockTest............");
				getNowGradeList();
				makeTags(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다");
			}
		});
	}
	
	/* 방금 푼 모의고사 성적을 가져옴 */
	function getNowGradeList(){
		$.ajax({
			url:"${pageContext.request.contextPath}/mock_test/getNowGradeList/"+tno,
			type:"post",
			success:function(result){
				console.log("getNowGradeList....................");
				makeMarkResult(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다.");
			}
		});
	}
	
	/* makeTags : 테이블 만드는 함수 */
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
			var $tr_subject = $("<tr>").html("<td colspan='2' class='subject'>"+obj.tq_subject+"</td>");
			if( i == 0 ){
				$table.append($tr_subject);
			}else if( (i>0) && (result[i-1].tq_subject != result[i].tq_subject) ){
				$table.append($tr_subject);
			}
			
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
			$tr_note.append("<td><button class='btnCreateNote'>오답풀이");
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
				var $span1 = $("<span class='add'>").html("<button class='addNoteBtn'>등록</button>");
				$p3.append($span1);
				var $span2 = $("<span class='up-and-del'>").html("<button class='updateNoteBtn'>수정</button><button class='delNoteBtn'>삭제</button>");
				$p3.append($span2);
				var $span3 = $("<span class='com-and-can'>").html("<button class='updateCompleteBtn'>확인</button><button class='updateCancelBtn'>취소</button>");
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
	
	/* makeMarkResult : 받아온 점수를 태그로 만들기 */
	function makeMarkResult(result){
		var maxCount = 0; //전채 개수
		var count = 0; //맞은 개수
		var sum = 0; //총점
		var subject = new Array();
		var subject_grade = new Array();
		
		for(var i = 0; i < result.length; i++){
			var obj = result[i];
			
			maxCount += obj.ng_count;
			count += obj.nowgrade;
			sum += obj.nowgrade;
			
			//과목별 맞은 개수
			var $td_markResult = $(".table").find("td#markResult");
			var $p_nowGrade = $("<p>");
			$p_nowGrade.html("<span class='markSubjectName'>"+obj.tq_subject+"<span class='markNowGrade'>"+obj.nowgrade+" / "+obj.ng_count);
			$td_markResult.append($p_nowGrade);
			
			subject[i] = obj.tq_subject;
			subject_grade[i] = obj.nowgrade;
			
		}//end of for
		
		var $td_markResult = $(".table").find("td#markResult");
		
		//최종 점수 및 맞은 개수
		var passCheck = "합격";
		var minGrade = 0;
		if(tname.indexOf("정보처리기사") >= 0){
			minGrade = 60;
			sum = sum * 1;
		}
		if(sum < minGrade){
			passCheck = "불합격";
		}
		var $p_result = $("<p id='lastResult'>");
		$p_result.html("총점 : " + sum + " / " + minGrade + " (맞은 개수 : "+ count +" / "+ maxCount +") <span>"+passCheck+"</span>");
		$td_markResult.append($p_result);
		
		//성적 저장 버튼
		var $p_saveGrade = $("<p class='save-grade-box'>").html("<button id='btnSaveGrade'>성적 저장하기");
		$p_saveGrade.attr("grade", count);
		$p_saveGrade.attr("subject", subject);
		$p_saveGrade.attr("subject_grade", subject_grade);
		
		$td_markResult.append($p_saveGrade);
	}
	
	/* clickPagingButton : 이전, 다음버튼 클릭했을 때 */
	function clickPagingButton(){
		var index = 1;
		var lastNum = Number($("td#paging").find("#allPage").text());
		$("#next").click(function(){
			if(index == lastNum){
				return;
			}
			if($(".first-table").css("display") != "none"){
				index = 1;
			}
			$(".first-table").css("display", "none");
			$(".added-table").css("display", "none");
			$(".added-table").eq(index-1).css("display", "table-row");
			
			index++;
			
			$("td#paging").find("#count").html(index);
		});
		
		$("#prev").click(function(){
			if(index == 1){
				return;
			}
			
			index--;
			
			$("td#paging").find("#count").html(index);
			$(".added-table").css("display", "none");

			if(index == 1){
				$(".first-table").css("display", "table-row");
			}else{
				$(".added-table").eq(index-2).css("display", "table-row");
			}
		});
	}
	
	/* 오답풀이의 등록, 수정, 삭제 버튼 */
	function clickNoteButtons(){
		//등록
		$(document).on("click", ".note-box .addNoteBtn", function(){
			var tqno = $(this).parents(".note").attr("tqno");
			var note_content = $(this).parents('.note-box').find("textarea.note_content").val();
			var note_memo = $(this).parents('.note-box').find("textarea.note_memo").val();
			
			insertNotePost(tqno, note_content, note_memo);
		});
		
		//수정
		$(document).on("click", ".note-box .up-and-del .updateNoteBtn", function(){
			$(this).parents(".note-box").find(".add").css("display", "none");
			$(this).parents(".note-box").find(".up-and-del").css("display", "none");
			$(this).parents(".note-box").find(".com-and-can").css("display", "inline-block");
			$(this).parents('.note-box').find("textarea.note_content").removeAttr("disabled");
			$(this).parents('.note-box').find("textarea.note_memo").removeAttr("disabled");
		});
		
		//삭제
		$(document).on("click", ".note-box .up-and-del .delNoteBtn", function(){
			var tqno = $(this).parents(".note").attr("tqno");
			
			swal({
				title:"오답풀이의 내용을 정말 삭제하시겠습니까?",
				showCancelButton:true,
				cancelButtonText: "아니오",
				confirmButtonText: "네",
			}, function(isConfirm){
				if(isConfirm){
					deleteNotePost(tqno);	
				}
			});
		});
		
		//수정취소
		$(document).on("click", ".note-box .com-and-can .updateCancelBtn", function(){
			$(this).parents(".note-box").find(".add").css("display", "none");
			$(this).parents(".note-box").find(".up-and-del").css("display", "inline-block");
			$(this).parents(".note-box").find(".com-and-can").css("display", "none");
			$(this).parents('.note-box').find("textarea.note_content").attr("disabled", "disabled");
			$(this).parents('.note-box').find("textarea.note_memo").attr("disabled", "disabled");
		});
		
		//수정확인
		$(document).on("click", ".note-box .com-and-can .updateCompleteBtn", function(){
			var tqno = $(this).parents(".note").attr("tqno");
			var note_content = $(this).parents('.note-box').find("textarea.note_content").val();
			var note_memo = $(this).parents('.note-box').find("textarea.note_memo").val();
			
			updateNotePost(tqno, note_content, note_memo);
		});
	}
	
	/* 오답노트추가 ajax */
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
	
	/* 오답노트수정 ajax */
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
	
	/* 오답노트삭제 ajax */
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
	
	/* 성적저장 ajax */
	function insertGradeAllAjax(grade, arrSubject, arrSubjectGrade){
		$.ajax({
			url:"${pageContext.request.contextPath}/grade/insertGradeAll",
			type:"post",
			data:{tno : tno, grade : grade, arrSubject : arrSubject, arrSubjectGrade : arrSubjectGrade},
			succes:function(result){
				console.log(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다.");
			}
		});
	}
</script>