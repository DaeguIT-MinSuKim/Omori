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
	$(".btnAddTestName").click(function(e){
		e.preventDefault();
		$(".add-testname-popup").find("#addTno").val(lastTno);
		$(".add-testname-popup").fadeIn("fast");
	});
	
	/* 자격증등록 팝업창이 뜨고 등록 버튼을 눌렀을 때 */
	$(".add-testname-popup #btnInsertTestNameForm").click(function(e){
		e.preventDefault();
		insertTestNameAjax();
	});
	
	/*자격증 수정 이미지 클릭하면 자격증 수정 팝업창 뜸*/
	$(document).on("click", ".icon-edit", function(e){
		e.preventDefault();
		
		var tno = $(this).parent("div").find("a").attr("tno");
		var tname = $(this).parent("div").find("a").text();
		var tdate = $(this).parent("div").find("a").attr("tdate");
		
		$(".edit-testname-popup").find("#editTno").val(tno);
		$(".edit-testname-popup").find("#editTname").val(tname);
		$(".edit-testname-popup").find("#editTdate").val(tdate);
		$(".edit-testname-popup").fadeIn("fast");
	});
	
	/*자격증 수정 팝업 뜬 후 수정버튼 클릭했을 때*/
	$("#btnUpTestName").click(function(e){
		e.preventDefault();
		updateTestNameAjax();
	});
	
	/*자격증 수정 팝업 뜬 후 삭제버튼 클릭했을 때*/
	$("#btnDelTestName").click(function(e){
		e.preventDefault();
		var tname = $("#editTname").val();
		
		swal({
			html:true,
			title:tname,
			text:"기출문제가 모두 삭제됩니다<br>그래도 삭제하시겠습니까?",
			showCancelButton:true,
			cancelButtonText: "아니오",
			confirmButtonText: "네",
			closeOnConfirm:false
		}, function(isConfirm){
			if(isConfirm){
				deleteTestNameAjax();
			}
		});
	});
	
	/*기출문제 등록 팝업에서 보기 및 정답 등록 버튼 클릭*/
	$(".add-question-popup #btnInsertExample").click(function(e){
		e.preventDefault();
		$(".add-example-popup").fadeIn("fast");
	});
	
	/*정답 체크(라디오버튼)*/
	$(".add-example-popup input[type='radio']").click(function(){
		$("input[type='radio']").prop("checked", false);
		$(this).prop("checked", true);
	});
	
	/*문제와 보기 제출하기*/
	$(".add-example-popup #btnInsertQueAndExForm").click(function(e){
		e.preventDefault();
		insertQuestionExampleAjax();
	});
	
	var $option = "<option value='데이터베이스'>데이터베이스</option>"
		+ "<option value='전자계산기구조'>전자계산기구조</option>"
		+ "<option value='운영체제'>운영체제</option>"
		+ "<option value='소프트웨어공학'>소프트웨어공학</option>"
		+ "<option value='데이터통신'>데이터통신</option>";

	/* 기출문제를 등록하기 위해 자격증이름을 클릭했을 때 */
	$(document).on("click", ".each-testname-box a", function(e){
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

	/*문제 번호 클릭하면 색깔이 변함*/
	$(document).on("click", ".add-question-popup .tqsmallno-box a", function(e){
		e.preventDefault();
		
		if( !$(this).hasClass("cant-sel-a") ){
			$(".tqsmallno-box").find("a").removeClass("selected-no");
			$(this).addClass("selected-no");
		}
	});

	/*엑셀파일 등록 버튼*/
	$("#btnUpload").click(function(e){
		e.preventDefault();
		check();
	});
});

/*문제 번호 태그로 만들기*/
function makeTqSmallNoButton(){
	var $div = $(".add-question-popup .login-form .tqsmallno-box");
	$div.html("");
	
	//문제중에 빈 문제가 있으면 선택가능함
	for(var i=0; i<100; i++){
		var text;
		if( i+1 < 10 ){
			text = "0"+(i+1);
		}else{
			text = (i+1);
		}
		var $a = $("<a href='' tqsmallno='"+text+"'>").html(text);
		for(var j=0; j<tqSmallNoList.length; j++){
			if(tqSmallNoList[j] == (i+1)){
				$a.addClass("cant-sel-a");
			}
		}
		if(i > 9 && i % 10 == 0){
			$div.append("<br>");
		}
		$div.append($a);
	}	
}