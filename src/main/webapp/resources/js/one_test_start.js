/**
 * param
 * var tno;
 */
$(document).on("ready", function(){
	//시작하면 데이터베이스 선택되어있음
	$(".jeong-bo-gisa").find("a").first().addClass("selected-subject");
	
	//시작하자마자 정답 감추기
	$("#switchAnswer").removeClass("hover");
	$(".answer-box").find("p").css("display", "none");
	
	//시작하자마자 오답노트 감추기
	$("#switchNote").removeClass("hover");
	$(".note-box").find(".note-box-inner").css("display", "none");
	
	//오답노트가 존재하면 수정, 삭제 버튼이 보이고
	//존재하지 않으면 등록버튼이 보임
	$(".note-box").each(function(i, obj) {
		if($(obj).attr("noteno") == ""){
			$(obj).find(".up-and-del").hide();
			$(obj).find(".com-and-can").hide();
		}else{
			$(obj).find("textarea").attr("disabled", "disabled");
			$(obj).find(".add").hide();
			$(obj).find(".com-and-can").hide();
		}
	});
});

/*-------------------------------------
	수정 버튼을 누르면 수정 확인, 취소 버튼 보임
-------------------------------------*/
var preContent = ""; //수정을 취소했을 때 이전에 가지고 있던 오답 노트 내용
var preMemo = "";
$(".note-box .up-and-del .updateNoteBtn").click(function() {
	$(this).parents(".note-box").find("textarea").removeAttr("disabled");
	$(this).parents(".note-box").find(".up-and-del").hide();
	$(this).parents(".note-box").find(".com-and-can").show();
	
	preContent = $(this).parents(".note-box").find(".note_content").val();
	preMemo = $(this).parents(".note_box").find(".note_memo").val();
});

/*---------------------
	수정 취소 버튼을 클릭
---------------------*/
$(".note-box .com-and-can .updateCancelBtn").click(function() {
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
$(".note-box .com-and-can .updateCompleteBtn").click(function() {
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
			updateNotePost(tqno, content, memo);
		}
	});
});
/*----------------
	등록 버튼 클릭
----------------*/
$(".note-box .add .addNoteBtn").click(function() {
	var tqno = $(this).parents(".note-box").attr("tqno");
	var content = $(this).parents(".note-box").find(".note_content").val();
	var memo = $(this).parents(".note-box").find(".note_memo").val();
	
	swal({
		title:"오답노트를 등록하겠습니까?",
		showCancelButton: true,
		cancelButtonText: "취소",
		confirmButtonText: "확인",
		closeOnConfirm: false
	}, function(isConfirm){
		if(isConfirm){
			insertNotePost(tqno, content, memo);
		}
	});
});

/*----------------
	삭제 버튼 클릭
----------------*/
$(".note-box .up-and-del .delNoteBtn").click(function() {
	var tqno = $(this).parents(".note-box").attr("tqno");
	
	swal({
		title:"오답노트를 삭제하시겠습니까?",
		showCancelButton: true,
		cancelButtonText: "취소",
		confirmButtonText: "확인",
		closeOnConfirm: false
	}, function(isConfirm){
		if(isConfirm){
			deleteNotePost(tqno);
		}
	});
});

/*----------------
	보기 선택 클릭
----------------*/
$(".example-box a").click(function(e) {
	e.preventDefault();
	
	$(this).parents(".example-box").find("a").removeClass("answer-selected");
	$(this).addClass("answer-selected");
});
/*----------------
	채점 버튼 클릭
----------------*/
$(".question-box .markBtn").click(function() {
	var answer = Number($(this).parents(".question-box").attr("tqanswer"));
	var selNo = -1; 
	
	$(this).parents(".each-question").find(".example-box a").each(function(i, obj) {
		if($(obj).hasClass("answer-selected")){
			selNo = i+1;
		}
	});
	
	if(selNo == answer){
		$(this).parents(".question-box").find(".incorrect").css('visibility', "hidden");
		$(this).parents(".question-box").find(".correct").css('visibility', "visible");
	}else{
		$(this).parents(".question-box").find(".correct").css('visibility', "hidden");
		$(this).parents(".question-box").find(".incorrect").css('visibility', "visible");
	}
	
	$("#switchAnswer").addClass("hover");
	$(".answer-box").find("p").slideDown("slow");
});

/*-------------------------
	정답감추기, 정답보이기 토글
-------------------------*/
$("#switchAnswer").click(function() {
	$(this).toggleClass("hover");
	
	if($(this).hasClass("hover")){
		$(".answer-box").find("p").slideDown("slow");
	}else{
		$(".answer-box").find("p").slideUp("slow");
	}
});

/*--------------------------
	오답노트 보이기, 감추기 토글
--------------------------*/
$("#switchNote").click(function() {
	$(this).toggleClass("hover");
	
	if($(this).hasClass("hover")){
		$(".note-box").find(".note-box-inner").slideDown("slow");
	}else{
		$(".note-box").find(".note-box-inner").slideUp("slow");
	}
});

/*---------------
	과목 버튼 클릭
---------------*/
$(".jeong-bo-gisa a").click(function(e) {
	e.preventDefault();

	if($(this).index() == 0)	$("ul.slick-dots").find("li").first().find("button").click();
	else if($(this).index() == 1)	$("ul.slick-dots").find("li").eq(20).find("button").click();
	else if($(this).index() == 2)	$("ul.slick-dots").find("li").eq(40).find("button").click();
	else if($(this).index() == 3)	$("ul.slick-dots").find("li").eq(60).find("button").click();
	else if($(this).index() == 4)	$("ul.slick-dots").find("li").eq(80).find("button").click();
});

$(document).on("click", "ul.slick-dots li button", function(){
	$(".jeong-bo-gisa").find("a").removeClass("selected-subject");
	
	if($(this).parent("li").index() < 20){
		$(".jeong-bo-gisa").find("a").first().addClass("selected-subject");
	}else if($(this).parent("li").index() < 40){
		$(".jeong-bo-gisa").find("a").eq(1).addClass("selected-subject");
	}else if($(this).parent("li").index() < 60){
		$(".jeong-bo-gisa").find("a").eq(2).addClass("selected-subject");
	}else if($(this).parent("li").index() < 80){
		$(".jeong-bo-gisa").find("a").eq(3).addClass("selected-subject");
	}else if($(this).parent("li").index() < 100){
		$(".jeong-bo-gisa").find("a").eq(4).addClass("selected-subject");
	}
});