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
}
.table tr.example a{
	line-height:22px;
	color:#333;
	font-size:12px;
}
.table tr.example a:HOVER{
	color:#cc0000;
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
	font-size:18px;
	font-family:"digital-7";
	height:30px;
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

</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>모의고사</h1>
			<div class="inner-section">
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
								<button id="prev">이전</button>
								<span id="count"></span> / <span id="allPage"></span>
								<button id="next">다음</button>
							</td>
						</tr>
					</table>
				</div>
				<div class="omr-box">
					<!-- form영역 -->
					<form action="${pageContext.request.contextPath}/mock_test/test_result" method="post" id="formSendAnswer">
						<input type="hidden" name="tno" value="${testName.tno}" />
						<table class="table">
							<tr>
								<td colspan="5" id="time-zone">00 : 00 : 00</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="clear"></div>
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
			</div>
		</div>
	</section>
</div>
<script>
	var tno = ${testName.tno};
	var originalName = "${testName.tname}";
	var substrName;
	if(originalName.indexOf("정보처리기사") > -1){
		substrName = "정보처리기사";
	}else if(originalName.indexOf("컴퓨터활용능력 1급") > -1){
		substrName = "컴퓨터활용능력 1급";
	}
	
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
		clickEachExampleButton();
		
		/* 답안제출버튼클릭했을 때 */
		$(document).on("click", "td#btnSendAnswer a", function(e){
			e.preventDefault();
			
			var emptyCheck = true;
			
			$(".omr-box tr.answer td").each(function(i, obj){
				//답을 선택하지 않았으면 input에는 -1이 들어가도록 함
				if($(obj).find("span").html() == ""){
					$(obj).find("input[name='sa_answer']").val(-1);
					
					$(".omr-box tr.num td").each(function(j, element){
						if($(obj).attr("tqno") == $(element).attr("tqno")){
							$(element).addClass("changeColor");
						}
					});
					
					emptyCheck = false;
				}
			});
			
			if(!emptyCheck){
				swal({
					title:"남은 문제가 있습니다",
					text:"답안을 제출하시겠습니까?",
					showCancelButton:true,
					cancelButtonText: "아니오",
					confirmButtonText: "네",
					closeOnConfirm:false
				}, function(isConfirm){
					if(isConfirm){
						$("#formSendAnswer").submit();
					}
				});
			}else{
				swal({
					title:"답안을 제출하시겠습니까?",
					showCancelButton:true,
					cancelButtonText: "아니오",
					confirmButtonText: "네",
					closeOnConfirm:false
				}, function(isConfirm){
					if(isConfirm){
						$("#formSendAnswer").submit();
					}
				});
			}
		});
	});
	
	/* getQuestionAndExampleByTno : ajax로 문제 리스트 받아오기 */
	function getQuestionAndExampleByTno(){
		$.ajax({
			url:"${pageContext.request.contextPath}/mock_test/getQuestionAndExampleByTno/"+tno,
			type:"post",
			success:function(result){
				makeTags(result);
				
				swal({
					html:true,
					title:"지금 보시는 시험은 "+substrName+" 입니다",
					text:"제한 시간은 총 <b>2시간 30분</b>이며,<br>한 과목당 제한 시간은 <b>30분</b>입니다<br>확인을 누르면 시험이 시작됩니다",
					confirmButtonText: "확인"
				}, function(isConfirm){
					setTimer(result[0].testName.tname);
				});
			},
			error:function(e){
				alert("에러가 발생하였습니다.");
			}
		});
	}
	
	/* 타이머 설정 함수 */
	function setTimer(tname){
		if(tname.indexOf("정보처리기사") != -1){
			var hour = 2;
			var minute = 30;
			var second = 00;
			$(".omr-box .table #time-zone").html( ((hour < 10) ? '0'+hour : hour ) + " : "
												+ ((minute < 10) ? '0'+minute : minute ) + " : "
												+ ((second < 10) ? '0'+second : second ));
			
			var timer;
			timer = setInterval(function() {
				second--;
				if(second < 0){
					second = 59;
					minute--;
				}
				if(minute < 0){
					minute = 59;
					hour--;
				}
				
				$(".omr-box .table #time-zone").html( ((hour < 10) ? '0'+hour : hour )+ " : " + ((minute < 10) ? '0'+minute : minute ) + " : " + ((second < 10) ? '0'+second : second ));
				
				if(hour == 0 && minute == 0 && second == 0){
					clearInterval(timer);
					swal({
						title:"시간이 종료되었습니다",
						text:"계속 푸시겠습니까 ?",
						showCancelButton:true,
						cancelButtonText: "아니오",
						confirmButtonText: "네",
						closeOnConfirm:false
					},function(isConfirm){
						/* 아니오를 클릭하면 답안 제출 */
					});
				}
			}, 1000);
		}
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
				$tr_example.append("<td><a href=''><span class='te_small_no'>"+example.te_small_no+"</span>"+example.te_content+"</a></td>");
				$tr_example.attr("teno", example.te_no);
				$tr_example.attr("tqno", example.question.tq_no);
				$tr_example.attr("tesmallno", example.te_small_no);
				
				$table.append($tr_example);
			}
			
			//omr
			var $table_omr = $(".omr-box .table");
			var $tr_num = $("<tr class='num'>");
			var $tr_answer = $("<tr class='answer'>");
			if(i % 5 == 0){
				$table_omr.append($tr_num);
				$table_omr.append($tr_answer);	
			}
			if(i == result.length - 1){
				$table_omr.append("<tr><td colspan='5' id='btnSendAnswer'><a href=''>답안 제출</a></td></tr>");
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
			
			var $td = $("<td tqno='"+obj.tq_no+"'>");
			$td.append("<span></span>");
			$td.append("<input type='hidden' name='sa_answer'/>");
			$td.append("<input type='hidden' name='tq_no' value='"+obj.tq_no+"'/>");
			$tr_answer.append($td);
		}
		
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
	
	/* clickEachExampleButton : 보기번호 클릭하면 색깔이 빨강색으로 바뀜 */
	function clickEachExampleButton(){
		$(document).on("click", ".mocktest-box .table .example td a", function(e){
			e.preventDefault();
			
			var tqno = $(this).parent().parent(".example").attr("tqno");
			
			$(".mocktest-box .table .example").each(function(i, obj){
				if( $(obj).attr("tqno") == tqno ){
					$(obj).find("td a").removeClass("answer-selected");
				}
			});
			
			var tesmallno = $(this).parent().parent(".example").attr("tesmallno");
			
			$(".omr-box .table tr.answer td").each(function(i, obj){
				if( $(obj).attr("tqno") == tqno ){
					$(obj).find("span").html(tesmallno);
					$(obj).find("input[name='sa_answer']").val(tesmallno);
				}
			});
			$(".omr-box .table tr.num td").each(function(i, obj){
				if( $(obj).attr("tqno") == tqno ){
					$(obj).removeClass("changeColor");
				}
			});

			$(this).addClass("answer-selected");
		});
	}
</script>