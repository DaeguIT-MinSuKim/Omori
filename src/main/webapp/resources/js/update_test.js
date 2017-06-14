/**
 * 
 */
$(document).on("click", ".btnUpdatePopup", function(){
	var $option = "<option value='데이터베이스'>데이터베이스</option>"
		+ "<option value='전자계산기구조'>전자계산기구조</option>"
		+ "<option value='운영체제'>운영체제</option>"
		+ "<option value='소프트웨어공학'>소프트웨어공학</option>"
		+ "<option value='데이터통신'>데이터통신</option>";
	
	if($("#testName").text().indexOf("정보처리기사") > -1){
		$(".edit-que-ex-popup").find("#subjectList").html($option);
	}
	
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
		if($(obj).attr("tqno") == 1){
			contents[index] = $(obj).find("td").last().text();
			tenoList[index] = $(obj).attr("teno");
			index++;
		}
	});
	
	$(".edit-que-ex-popup").find("#example01").val(contents[0]);
	$(".edit-que-ex-popup").find("#example01").attr("teno1", tenoList[0]);
	$(".edit-que-ex-popup").find("#example02").val(contents[1]);
	$(".edit-que-ex-popup").find("#example01").attr("teno2", tenoList[1]);
	$(".edit-que-ex-popup").find("#example03").val(contents[2]);
	$(".edit-que-ex-popup").find("#example01").attr("teno3", tenoList[2]);
	$(".edit-que-ex-popup").find("#example04").val(contents[3]);
	$(".edit-que-ex-popup").find("#example01").attr("teno4", tenoList[3]);
	
	$(".edit-que-ex-popup").fadeIn("fast");
});