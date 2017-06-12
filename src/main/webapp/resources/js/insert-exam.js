/**
 * param
 * var lastTno;
 * var lastTqno;
 * var tqSmallNoList = new Array();
 */
$(function(){
	/* 팝업창 X버튼 클릭 */
	$(".login-close").find("a").click(function(e){
		e.preventDefault();
		if($(".add-example-popup").css("display") == "block"){
			$(".add-example-popup").fadeOut("fast");
			return;
		}
		$(".login-container").fadeOut("fast");
	});
	
	/* 자격증등록 버튼을 클릭하면 팝업창 띄우도록*/
	$(".no-testname #btnAddTestName").click(function(e){
		e.preventDefault();
		$(".add-testname-popup").find("#addTno").val(lastTno);
		$(".add-testname-popup").fadeIn("fast");
	});
	
	/* 자격증등록 팝업창이 뜨고 등록 버튼을 눌렀을 때 */
	$(".add-testname-popup #btnInsertTestNameForm").click(function(e){
		e.preventDefault();
		insertTestNameAjax();
	});
	
	var $option = "<option value='데이터베이스'>데이터베이스</option>"
				+ "<option value='전자계산기구조'>전자계산기구조</option>"
				+ "<option value='운영체제'>운영체제</option>"
				+ "<option value='소프트웨어공학'>소프트웨어공학</option>"
				+ "<option value='데이터통신'>데이터통신</option>";
	
	/* 기출문제를 등록하기 위해 자격증이름을 클릭했을 때 */
	$(".each-testname-box a").click(function(e){
		e.preventDefault();
		
		$(".add-question-popup").fadeIn("fast");
		$(".add-question-popup").find("#q-tno").html($(this).attr("tno"));
		$(".add-question-popup").find("#q-tname").html($(this).text());
		$(".add-question-popup").find("#q-tqno").html(lastTqno);
		if( $(this).text().indexOf("정보처리기사") > -1 ){
			$(".add-question-popup").find("#subjectList").html($option);
		}
		
		/* 로딩이미지띄우기 */
		$(window).ajaxStart(function(){
			$(".loading-box").css("display", "block");
		}).ajaxComplete(function(){
			$(".loading-box").css("display", "none");
			$(".add-question-popup .login-form").css("display", "block");
			makeTqSmallNoButton();
		});
		
		var no = $(this).attr("tno");
		getTqSmallNoListAjax(no);
	});
	
	/*정답 체크(라디오버튼)*/
	$(".add-example-popup input[type='radio']").click(function(){
		$("input[type='radio']").prop("checked", false);
		$(this).prop("checked", true);
	});
	
	/*문제와 보기 제출하기*/
	$(".add-example-popup #btnInsertQueAndExForm").click(function(e){
		e.preventDefault();
		
//		$(".add-question-popup").find()
		var sendTno = $("#q-tno").text();
		var sendTqSubject =  $("#subjectList").val();
		var sendTqSmallNo = $(".tqsmallno-box").find("a.selected-no").text();
		var sendTqQuestion = $("#q-question").val();
//		$(".add-example-popup").find()
		var sendTqAnswer = $(".add-example-popup").find("input[type='radio']:checked").val();
		var sendTeContent = [$("#example01").val(), $("#example02").val(), $("#example03").val(), $("#example04").val()];
		
	});
});

/*문제 번호 태그로 만들기*/
function makeTqSmallNoButton(){
	var $div = $(".add-question-popup .login-form .tqsmallno-box");
	$div.html("");
	
	if(tqSmallNoList == null){
		var $a = $("<a href='' tqsmallno='1'>").html(1);
		$a.addClass("can-sel-a");
		$div.html($a);
		
		return;
	}
}

/*문제 번호 클릭하면 색깔이 변함*/
$(document).on("click", "a.can-sel-a", function(e){
	e.preventDefault();
	
	$("a.can-sel-a").removeClass("selected-no");
	$(this).addClass("selected-no");
});