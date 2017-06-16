/**
 * 
 */

/*-------------------------
	이전, 다음버튼 클릭했을 때 
-------------------------*/
function clickPagingButton(){
	var index = 1;
	$("#next").click(function(){
		if(index == 10){
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

/*-------------------------
	받아온 점수를 태그로 만들기
-------------------------*/
function makeMarkResult(result){
	var maxCount = 0; //전채 개수
	var count = 0; //맞은 개수
	var sum = 0; //총점
	var subject = new Array();
	var subject_grade = new Array();
	
	var obj = result;
	
	maxCount += obj.ng_count;
	count += obj.nowgrade;
	sum += obj.nowgrade;
	
	//과목별 맞은 개수
	var $td_markResult = $(".table").find("td#markResult");
	var $p_nowGrade = $("<p>");
	$p_nowGrade.html("<span class='markSubjectName'>"+obj.tq_subject+"<span class='markNowGrade'>"+obj.nowgrade+" / "+obj.ng_count);
	$td_markResult.append($p_nowGrade);
	
	subject[0] = obj.tq_subject;
	subject_grade[0] = obj.nowgrade;
	
	var $td_markResult = $(".table").find("td#markResult");
	
	//최종 점수 및 맞은 개수
	var passCheck = "합격";
	var minGrade = 0;
	if(tname.indexOf("정보처리기사") > -1){
		minGrade = 20;
		sum = sum * 1;
	}
	if(sum < minGrade){
		passCheck = "불합격";
	}
	var $p_result = $("<p id='lastResult'>");
	$p_result.html("총점 : " + sum + " / " + minGrade + " <span>"+passCheck+"</span>");
	$td_markResult.append($p_result);
	
	//성적 저장 버튼
	var $p_saveGrade = $("<p class='save-grade-box'>").html("<button id='btnSaveGrade'>성적 저장하기");
	$p_saveGrade.attr("grade", count);
	$p_saveGrade.attr("subject", subject);
	$p_saveGrade.attr("subject_grade", subject_grade);
	
	$td_markResult.append($p_saveGrade);
}

/*-------------------
	성적 저장 버튼 클릭
-------------------*/
$(document).on("click", "#btnSaveGrade", function(e){
	e.preventDefault();
	
	var grade = $(this).parent(".save-grade-box").attr("grade");
	var sendSubject = $(this).parent(".save-grade-box").attr("subject");
	var subjectGrade = $(this).parent(".save-grade-box").attr("subject_grade");
	
	swal({
		title:"지금 본 모의고사의 성적을 저장할까요?",
		text:"회원님의 성적 통계에 반영됩니다.",
		showCancelButton:true,
		cancelButtonText: "아니오",
		confirmButtonText: "네",
		closeOnConfirm:false
	}, function(isConfirm){
		if(isConfirm){
			insertGradeOnlySubjectAjax(grade, sendSubject, subjectGrade);
			$("#btnSaveGrade").css("display", "none");
			swal.close();
		}
	});
});

/*------------------------------
	오답풀이의 등록, 수정, 삭제 버튼 
------------------------------*/
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