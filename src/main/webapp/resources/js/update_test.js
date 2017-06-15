/**
 * 
 */
/*수정 팝업 띄우는 버튼 클릭*/
$(document).on("click", ".btnUpdatePopup", function(){
	var $option = "<option value='데이터베이스'>데이터베이스</option>"
		+ "<option value='전자계산기구조'>전자계산기구조</option>"
		+ "<option value='운영체제'>운영체제</option>"
		+ "<option value='소프트웨어공학'>소프트웨어공학</option>"
		+ "<option value='데이터통신'>데이터통신</option>";
	
	if($("#testName").text().indexOf("정보처리기사") > -1){
		$(".edit-que-ex-popup").find("#subjectList").html($option);
	}
	var tqsubject = $(this).parents("tr.question").attr("tqsubject");
	$("#subjectList").find("option").each(function(i, obj) {
		if($(obj).text() == tqsubject){
			$(obj).attr("selected", "selected");
		}
	})
	
	
	
	var tqanswer = $(this).parents("tr.question").attr("tqanswer");
	$(".edit-que-ex-popup").find(".answer-box span").each(function(i, obj){
		$(obj).removeClass("selected-answer");
		if($(obj).text() == tqanswer){
			$(obj).addClass("selected-answer");
		}
	});
	$(".edit-que-ex-popup").find(".answer-box").find("span").click(function() {
		$(".edit-que-ex-popup").find(".answer-box").find("span").removeClass("selected-answer");
		$(this).addClass("selected-answer");
	});
	
	
	var tqno = $(this).parents("tr.question").attr("tqno");
	var tqsmallno = $(this).parents("tr.question").attr("tqsmallno");
	$(".edit-que-ex-popup").find("#edit-small-no").html(tqsmallno);
	$(".edit-que-ex-popup").find("#edit-small-no").attr("tqno", tqno);
	var question = $(this).parent("td").find("a").text();
	$(".edit-que-ex-popup").find("#edit-quesiton").val(question);
	
	var contents = new Array();
	var tenoList = new Array();
	var index = 0;
	$(".example").each(function(i, obj){
		if($(obj).attr("tqno") == tqno){
			contents[index] = $(obj).find("td").last().text().substring(1);
			tenoList[index] = $(obj).attr("teno");
			index++;
		}
	});
	
	$(".edit-que-ex-popup").find("#example01").val(contents[0]);
	$(".edit-que-ex-popup").find("#example01").attr("teno", tenoList[0]);
	$(".edit-que-ex-popup").find("#example02").val(contents[1]);
	$(".edit-que-ex-popup").find("#example01").attr("teno", tenoList[1]);
	$(".edit-que-ex-popup").find("#example03").val(contents[2]);
	$(".edit-que-ex-popup").find("#example01").attr("teno", tenoList[2]);
	$(".edit-que-ex-popup").find("#example04").val(contents[3]);
	$(".edit-que-ex-popup").find("#example01").attr("teno", tenoList[3]);
	
	$(".edit-que-ex-popup").fadeIn("fast");
});

/*수정 팝업창에서 수정버튼클릭*/
$("#btnUpQueAndEx").click(function(e){
	e.preventDefault();
	var tqsmallno = $("#edit-small-no").text();
	swal({
		title:"문제 "+tqsmallno+"번과 보기를 수정하시겠습니까?",
		showCancelButton:true,
		cancelButtonText: "취소",
		confirmButtonText: "수정"
	}, function(isConfirm){
		if(isConfirm){
			updateQueAndExAjax();
		}
	});
});

/*팝업창 X버튼 클릭*/
$(".login-close").find("a").click(function(e){
	e.preventDefault();
	$(".login-container").fadeOut("fast");
});