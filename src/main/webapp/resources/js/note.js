/**
 * param
 * var firstTno
 * var firstTname
 */
$(document).on("ready", function() {
	//시작하면 첫번째 기출문제 선택되어있음
	$(".select-testname-box").find("a").first().addClass("selected-subject");
});
/*---------------
	과목 버튼 클릭
---------------*/
$(".select-testname-box a").click(function(e) {
	e.preventDefault();
	$(".select-testname-box").find("a").removeClass("selected-subject");
	$(this).addClass("selected-subject");
	
	var tno = $(this).attr("tno");
	getQuestionAnswerNoteAjax(tno);
});

/*-------------------------------------
	수정 버튼을 누르면 수정 확인, 취소 버튼 보임
-------------------------------------*/
var preContent = ""; //수정을 취소했을 때 이전에 가지고 있던 오답 노트 내용
var preMemo = "";
$(document).on("click", ".note-box .up-and-del .updateNoteBtn", function(e) {
	$(this).parents(".note-box").find("textarea").removeAttr("disabled");
	$(this).parents(".note-box").find(".up-and-del").hide();
	$(this).parents(".note-box").find(".com-and-can").show();
	
	preContent = $(this).parents(".note-box").find(".note_content").val();
	preMemo = $(this).parents(".note_box").find(".note_memo").val();
});
/*---------------------
	수정 취소 버튼을 클릭
---------------------*/
$(document).on("click", ".note-box .com-and-can .updateCancelBtn", function() {
	var $thisBtn = $(this);
	
	swal({
		title:"수정을 취소하시겠습니까?",
		showCancelButton: true,
		cancelButtonText: "취소",
		confirmButtonText: "확인"
	}, function(isConfirm){
		if(isConfirm){
			//풀이 내용 및 메모 초기화
			$thisBtn.parents(".note-box").find(".note_content").val(preContent);
			$thisBtn.parents(".note-box").find(".note_memo").val(preMemo);
			preContent = "";
			preMemo = "";
			
			$thisBtn.parents(".note-box").find("textarea").attr("disabled", "disabled");
			$thisBtn.parents(".note-box").find(".up-and-del").show();
			$thisBtn.parents(".note-box").find(".com-and-can").hide();
		}
	});
});
/*-------------------
	수정 확인 버튼 클릭
-------------------*/
$(document).on("click", ".note-box .com-and-can .updateCompleteBtn", function() {
	var tno = $(this).parents(".each-question").attr("tno");
	var tqno = $(this).parents(".note-box").attr("tqno");
	var content = $(this).parents(".note-box").find(".note_content").val();
	var memo = $(this).parents(".note-box").find(".note_memo").val();
	
	swal({
		title:"오답노트를 수정하시겠습니까?",
		showCancelButton: true,
		cancelButtonText: "취소",
		confirmButtonText: "확인",
		closeOnConfirm: false
	}, function(isConfirm){
		if(isConfirm){
			updateNotePost(tno, tqno, content, memo);
		}
	});
});
/*----------------
	삭제 버튼 클릭
----------------*/
$(document).on("click", ".note-box .up-and-del .delNoteBtn", function() {
	var tno = $(this).parents(".each-question").attr("tno");
	var tqno = $(this).parents(".note-box").attr("tqno");
	
	swal({
		title:"오답노트를 삭제하시겠습니까?",
		showCancelButton: true,
		cancelButtonText: "취소",
		confirmButtonText: "확인",
		closeOnConfirm: false
	}, function(isConfirm){
		if(isConfirm){
			deleteNotePost(tno, tqno);
		}
	});
});

