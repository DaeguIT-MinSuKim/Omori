<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login-join.css" />
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
	width:100%;
	float:left;
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
.table .btnUpdatePopup{position: absolute;}
.table td{
	font-family: "돋움";
}
.table td img{max-width:500px; max-height:300px;}
.table #testName{
	padding-top:20px;
	padding-bottom:20px;
	text-align: center;
	font-weight:bold;
	font-size:20px;
	color:#222;
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
.table tr.question td:FIRST-CHILD{text-align: left;}
.table tr.question td{
	padding-top:30px;
	padding-bottom:10px;
	font-size:14px;
}
.table tr.example td{
	padding:5px 5px;
	font-size:12px;
	line-height:22px;
	color:#333;
}
.table tr.example span.te_small_no{
	border: 1px solid #cc0000;
    width: 20px;
    height: 20px;
    margin-right: 10px;
    padding:2px 6px;
}
.table-left, .table-right{
	width:50%;
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

/* 로딩 이미지 */
.table, .omr-box{
	display:none;
}

.loading-box{
	display:none;
}

/* ------------
	popup창 
-------------*/
.login-container .form {text-align: left;}

.edit-que-ex-popup .login-page {width:700px; margin-top:-130px;}
.edit-que-ex-popup .login-page .form {max-width:700px;}
.edit-que-ex-popup .login-page .form hr{margin-bottom:25px;}
.edit-que-ex-popup .login-page .form label {display: inline-block; width:80px; float:left;}
.edit-que-ex-popup .login-page .form .answer-box span{cursor: pointer; display: inline-block; padding:0 4px; margin-right:10px;}
.edit-que-ex-popup .login-page .form textarea#edit-question{width:86.8% !important;display: inline-block;}
.edit-que-ex-popup .login-page .form div {clear:both; margin-bottom:5px;}
.edit-que-ex-popup .login-page .form .ex p {width:15px; display:inline-block; clear:both;}
.edit-que-ex-popup .login-page .form .ex textarea{width:96%; float:right;}
.edit-que-ex-popup .login-page .form .button-box{text-align: center;}
.edit-que-ex-popup .login-page .form .button-box button{width:49%;}
.edit-que-ex-popup input[type='file']{background: none;display: inline-block;width: 80%; padding: 0 !important; 
										padding-left: 20px !important;margin-top: -5px !important;}
span.selected-answer{color:#cc0000 !important; font-weight: bold;}

.preview img{max-width:200px;max-height:100px; padding-left: 25px;margin-top: 15px;margin-bottom: 15px;}
.preview a{cursor: pointer; background: #4caf50;position: absolute;margin-left: -15px;padding: 5px; width: 15px; height: 15px;
			border-radius: 50%;border: 2px solid #eee;box-shadow: 0.5px 0.5px 1px black;
    		display: inline-block;font-weight: bold;text-align: center;}

</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<div class="inner-section">
				<h1>기출문제 수정</h1>
				<div class="mocktest-box">
					<table class='table'>
						<tr>
							<td colspan="2" id="testName">${testName.tname} <small>(${testName.tdate})</small></td>
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
								<button id="prev" class='same-button-style'>이전</button>
								<span id="count"></span> / <span id="allPage"></span>
								<button id="next" class='same-button-style'>다음</button>
							</td>
						</tr>
					</table>
				</div>
				<!-- ajax로딩 될 때 뜨는 이미지 -->
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
				<div class="clear"></div>
			</div>
		</div>
	</section>
</div>

<!-- 기출문제 수정 팝업 -->
<div class="login-container edit-que-ex-popup">
	<div class="login-page">
		<div class="login-close">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-close-button.png" alt="" /></a>
		</div>
		<div class="form">
			<form class="login-form">
				<h2 class="form-title">기출문제 수정</h2>
				<div><label for="">문제 번호</label><span id="edit-small-no"></span></div>
				<div><label for="">과목</label><select id="subjectList"></select></div>
				<div class='answer-box'>
					<label for="">정답</label>
					<span>1</span><span>2</span><span>3</span><span>4</span>
				</div>
				<label for="">문제 내용</label>
				<textarea id="edit-question" cols="30" rows="3"></textarea>
				<hr />
				<div>
					<label for="">보기이미지</label>
					<input type="file" id='add-img' />
					<div class="preview"></div>
				</div>
				<div class='ex'><p>1. </p><textarea id="example01" cols="30" rows="3"></textarea></div>
				<div class='ex'><p>2. </p><textarea id="example02" cols="30" rows="3"></textarea></div>
				<div class='ex'><p>3. </p><textarea id="example03" cols="30" rows="3"></textarea></div>
				<div class='ex'><p>4. </p><textarea id="example04" cols="30" rows="3"></textarea></div>
				<div class="button-box">
					<button id="btnUpQueAndEx">수정</button>
					<button id="btnDelQueAndEx" class='negative-btn-style'>삭제</button>
				</div>
			</form>
		</div>
		
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/update_test.js"></script>
<script>
/*----------------
	문제 및 보기 수정
----------------*/
function updateQueAndExAjax(){
	var tqno = $("#edit-small-no").attr("tqno");
	var subject = $("#subjectList").val();
	var answer = $(".answer-box").find(".selected-answer").text();
	var question = $("#edit-question").val();
	var teno1 = $("#example01").attr("teno");
	var ex1 = $("#example01").val();
	var teno2 = $("#example02").attr("teno");
	var ex2 = $("#example02").val();
	var teno3 = $("#example03").attr("teno");
	var ex3 = $("#example03").val();
	var teno4 = $("#example04").attr("teno");
	var ex4 = $("#example04").val();
	var preDelImg = null;
	if($("#add-img").attr("preImgDel") != null){
		preDelImg = $("#add-img").attr("preImgDel");
	}
	
	var formData = new FormData();
	formData.append("tqno", tqno);
	formData.append("subject", subject);
	formData.append("answer", answer);
	formData.append("question", question);
	formData.append("teno1", teno1);
	formData.append("ex1", ex1);
	formData.append("teno2", teno2);
	formData.append("ex2", ex2);
	formData.append("teno3", teno3);
	formData.append("ex3", ex3);
	formData.append("teno4", teno4);
	formData.append("ex4", ex4);
	formData.append("file", $("#add-img")[0].files[0]);
	formData.append("preDelImg", preDelImg);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/updateQueAndEx",
		processData: false,
	    contentType: false,
		data:formData,
		type:"post",
		success:function(result){
			swal({
				title:"수정되었습니다",
				confirmButtonText: "확인",
				closeOnConfirm: false
			}, function(isConfirm){
				updateTable();
				$("#add-img").val("");
				$(".edit-que-ex-popup").find(".preview").html("");
				swal.close();
			});
			
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/*---------------------
	이미지 가져오는 ajax
---------------------*/
function getImageAjax(tqno){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/getImage",
		data:{"tqno" : tqno},
		type:"post",
		success:function(result){
			if(result.length > 0){
				$(".image").each(function(i, obj) {
					if($(obj).attr("tqno") == tqno){
						$(obj).html("<td></td><td><img src='${pageContext.request.contextPath}/resources/upload/"+result[0].imgsource+"'/></td>");
					}
				});
			}else{
				$(".image").each(function(i, obj) {
					if($(obj).attr("tqno") == tqno){
						$(obj).html("");
					}
				});
			}
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

function updateTable(){
	var tqno = $("#edit-small-no").attr("tqno");
	var subject = $("#subjectList").val();
	var answer = $(".answer-box").find(".selected-answer").text();
	var question = $("#edit-question").val();
	var teno1 = $("#example01").attr("teno");
	var ex1 = $("#example01").val();
	var teno2 = $("#example02").attr("teno");
	var ex2 = $("#example02").val();
	var teno3 = $("#example03").attr("teno");
	var ex3 = $("#example03").val();
	var teno4 = $("#example04").attr("teno");
	var ex4 = $("#example04").val();
	
	//이미지있으면 뿌리기
	getImageAjax(tqno);
	
	$(".question").each(function(i, obj) {
		if($(obj).attr("tqno") == tqno){
			$(obj).find("span").text(question);
		}
	});
	$(".answer").each(function(i, obj) {
		if($(obj).attr("tqno") == tqno){
			$(obj).find("td").last().text("정답 : "+ answer);
		}
	});
	$(".example").each(function(i, obj){
		if($(obj).attr("tqno") == tqno){
			if($(obj).attr("teno") == teno1){
				$(obj).find("td").last().html("<span class='te_small_no'>1</span>"+ex1);
			}else if($(obj).attr("teno") == teno2){
				$(obj).find("td").last().html("<span class='te_small_no'>2</span>"+ex2);
			}else if($(obj).attr("teno") == teno3){
				$(obj).find("td").last().html("<span class='te_small_no'>3</span>"+ex3);
			}else if($(obj).attr("teno") == teno4){
				$(obj).find("td").last().html("<span class='te_small_no'>4</span>"+ex4);
			}
		}
	});

	$(".login-container").fadeOut("fast");
}



var tno = ${testName.tno};
	
$(function(){
	/* 로딩이미지띄우기 */
	$(window).ajaxStart(function(){
		$(".loading-box").css("display", "block");
	}).ajaxComplete(function(){
		$(".loading-box").css("display", "none");
		$(".table").css("display","table");
		$(".omr-box").css("display","table");
	});
	
	getQuestionAndExampleByTno();
});//end of ready

/* getQuestionAndExampleByTno : ajax로 문제 리스트 받아오기 */
function getQuestionAndExampleByTno(){
	$.ajax({
		url:"${pageContext.request.contextPath}/mock_test/getQuestionAndExampleByTno/"+tno,
		type:"post",
		success:function(result){
			makeTags(result);
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
		$tr_question.append("<td>"+obj.tq_small_no+". </td>");
		$tr_question.append("<td><span class='que'>"+obj.tq_question+"</span><button class='btnUpdatePopup small-btn-style'>수정</button></td>");
		$tr_question.attr("tqno", obj.tq_no);
		$tr_question.attr("tno", obj.testName.tno);
		$tr_question.attr("tqsubject", obj.tq_subject);
		$tr_question.attr("tqsubjectno", obj.tq_subject_no);
		$tr_question.attr("tqsmallno", obj.tq_small_no);
		$tr_question.attr("tqper", obj.tq_per);
		$tr_question.attr("tqanswer", obj.tq_answer);
		
		$table.append($tr_question);
		
		//정답
		var $tr_answer = $("<tr class='answer' tqno='"+obj.tq_no+"'>");
		$tr_answer.append($("<td>"));
		$tr_answer.append($("<td>").html("정답 : "+obj.tq_answer));
		$table.append($tr_answer);
		
		//이미지
		var imageList = obj.imageList; 
		if(imageList.length > 0){
			for(var j=0; j<imageList.length; j++){
				var $tr_image = $("<tr class='image' tqno='"+obj.tq_no+"'>");
				$tr_image.append("<td></td>");
				$tr_image.append("<td><img src='${pageContext.request.contextPath}/resources/upload/"+imageList[j].imgsource+"'/></td>");
				$tr_image.attr("tqno", imageList[j].tq_no);
				
				$table.append($tr_image);
			}
		}else{
			var $tr_image = $("<tr class='image' tqno='"+obj.tq_no+"'>");
			$table.append($tr_image);
		}
		
		//보기
		var exampleList = obj.exampleList;
		for(var j=0; j<exampleList.length; j++){
			var example = exampleList[j];
			var $tr_example = $("<tr class='example'>");
			$tr_example.append("<td></td>");;
			$tr_example.append("<td><span class='te_small_no'>"+example.te_small_no+"</span>"+example.te_content+"</td>");
			$tr_example.attr("teno", example.te_no);
			$tr_example.attr("tqno", example.question.tq_no);
			$tr_example.attr("tesmallno", example.te_small_no);
			
			$table.append($tr_example);
		}
		
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
</script>
