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
.table tr.question td:FIRST-CHILD{
	text-align: left;
}

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

/* .omr-box */
.omr-box .table{
	width:100%;
	border-collapse: collapse;
}
.omr-box .table td{
	width:25px;
	text-align:center;
	padding:7px 5px;
	border:1px solid #999;
}
.omr-box .table td a{
	color:#333;
}
.omr-box .table td:FIRST-CHILD{
	color:#303030;
	font-weight: bold;
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
							<td colspan="2" id="testName"></td>
						</tr>
						<tr class="first-table">
							<td class='table-left'>
								<table></table>
							</td>
							<td class='table-right'>
								<table></table>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="paging"></td>
						</tr>
					</table>
				</div>
				<div class="omr-box">
					<table class="table">
						<tr>
							<td colspan="5" id="time-zone">00 : 00 : 00</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
</div>


<%-- <c:if test="${login.isadmin == true}">
	<script>
		$(function(){
			
		});
	</script>
</c:if> --%>
<c:if test="${login.isadmin == false}">
	<script>
		$(function(){
			swal({
				title: "최근에 푼 기출문제를 가져올까요?",
				showCancelButton:true,
				cancelButtonText: "아니오",
				confirmButtonText: "네",
				closeOnConfirm:false
			}, function(isConfirm){
				if(isConfirm){
					latestTestName();
				}
			});
			
			/* 보기 번호를 누르면 색깔이 빨강색으로 바뀌고 OMR답안지의 숫자도 체크됨 */
			$(document).on("click", ".mocktest-box .table .example td a", function(e){
				e.preventDefault();
				
				var tqno = $(this).parent().parent(".example").attr("tqno");
				
				$(".mocktest-box .table .example").each(function(i, obj){
					if( $(obj).attr("tqno") == tqno ){
						$(obj).find("td a").removeClass("answer-selected");
					}
				});
				
				var tesmallno = $(this).parent().parent(".example").attr("tesmallno");
				
				$(".omr-box .table tr").each(function(i, obj){
					if( $(obj).attr("tqno") == tqno ){
						$(obj).find("td").removeClass("answer-selected");
						$(obj).find("td").css("background", "none");
						
						$(obj).find("td").eq(tesmallno).addClass("answer-selected");
						$(obj).find("td").eq(tesmallno).css("background","#fff");
					}
				});

				$(this).addClass("answer-selected");
			});
			
			/* paging버튼 눌렀을 때 */
			$(document).on("click", "#paging button", function(){
				var index = $(this).index();
				if(index == 0){
					$(".first-table").css("display", "table-row");
					$(".added-table").css("display", "none");
				}else{
					$(".first-table").css("display", "none");
					$(".added-table").css("display", "none");
					$(".added-table").eq(index-1).css("display", "table-row");
				}

				var offset = $(".width1400 h1").offset();
		        $('html, body').animate({scrollTop : offset.top}, 400);
			});
		});//end of ready
		
		function latestTestName(){
			var res;
			$.ajax({
				url:"${pageContext.request.contextPath}/mock_test/latestTestName",
				type:"post",
				async:false,
				success:function(result){
					console.log("latestTestName------------------");
					console.log(result);
					res = result;
				},
				error:function(e){
					alert("에러가 발생하였습니다.");
				}
			});
			
			/* 최근에 푼 기출문제가 없으면 새로 선택해서 풀도록 함 */
			if(res == ""){
				setTestNameList();
			}
			/* 최근에 푼 기출문제가 있을 때 */
			else{
				location.replace("${pageContext.request.contextPath}/mock_test/start_test/"+res.tno);
				//$("#testName").html(res.tname);
				//getMockTest(res.tno);
				//setTimer(res.tname);
				//swal.close();
			}
			
			//var map = $.map(data, function(value, key){
				//최근에 푼 기출문제가 없으면 새로 선택해서 풀도록 함
				//if(value == "null"){
					//setTestNameList();
				//}else{
					
				//}
			//});
		}//latestTestName
		
		function setTestNameList(){
			selectAllTestName("${pageContext.request.contextPath}/admin/selectAllTestName").done(function(data){
				console.log("selectAllTestName data : " + data);
				
				/* select태그 생성 */
				var $option = "<select id='testNameList'><option selected='selected' value='0'>기출문제를 선택해주세요.</option>";
				for(var i = 0; i < data.length; i++){
					$option += "<option value="+data[i].tno+">"
								+ "<span>"+data[i].tname+"</span>"
								+ " <span>"+data[i].tdate+"</span>"
								+ "</option>";
				}
				$option += "</select>";
				
				/* 옵션에서 선택된 기출문제 */
				var tno = 0;
				var tname = "";
				$(document).on("change", "#testNameList", function(){
					tno = $(this).val();
					tname = $(this).find("option:selected").text();
				});
				
				/* 확인버튼을 누르면 그 기출문제를 가져옴 */
				swal({
					title: "최근에 푼 기출문제가 없습니다",
					html:true,
					text: $option,
					confirmButtonText: "확인",
					closeOnConfirm:false
				}, function(isConfirm){
					if(tno != 0){
						$("#testName").html(tname);
						setTimer(tname); /* 타이머설정 */
						getMockTest(tno); /* 태그생성 */
						swal.close();
					}else{
						return false;
					}
				});
				
				//data가 없을 때
				//if(data == ""){
					//alert("null");
				//}
			});
		}//setTestNameList
		
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
		}//setTimer
		
		function getMockTest(tno){
			$.ajax({
				url:"${pageContext.request.contextPath}/mock_test/mockTestQAndE/"+tno,
				type:"post",
				success:function(result){
					makeTags(result); /* 태그로 만들기 */
				},
				error:function(e){
					alert("에러가 발생하였습니다.");
				}
			});
		}//getMockTest
		
		function makeTags(result){
			var keys = Object.keys(result);
			var values = Object.values(result);
			var mapSize = Object.keys(result).length;
			
			// values[0][0] : TestQuestionVO
			// values[20][1] : ImageVO
			// values[0][2] : TestExampleVO
			
			for(var i = 0; i < mapSize; i++ ){
				var value = values[i][0];
				
				var table;
				
				//table생성(좌 5개, 우 5개)
				if(i < 5){
					table = $(".first-table").find(".table-left").find("table");
				}else if(i < 10){
					table = $(".first-table").find(".table-right").find("table");
				}else if(i == 10){
					//.first-table을 복사하여 하나 더 생성
					var $copy_table = $(".first-table").html();
					var $new_table = $("<tr>").html($copy_table);
					$(".first-table").after($new_table);
					$new_table.addClass("added-table");
					$new_table.find("table").html("");
					
					table = $(".added-table").last().find(".table-left").find("table");
				}else if(i == 15){
					table = $(".added-table").last().find(".table-right").find("table");
				}else if(i == 20 || i == 30 || i == 40 || i== 50 || i == 60 || i == 70 || i == 80 || i == 90){
					var $copy_table = $(".first-table").html();
					var $new_table = $("<tr>").html($copy_table);
					$(".added-table").last().after($new_table);
					$new_table.addClass("added-table");
					$new_table.find("table").html("");
					
					table = $(".added-table").last().find(".table-left").find("table");
				}else if(i == 25 || i == 35 || i == 45 || i == 55 || i == 65 || i == 75 || i == 85 || i == 95){
					table = $(".added-table").last().find(".table-right").find("table");
				}
				
				//과목이름
				/* 과목명이 이전과 달라지면 그 때 과목명을 한 번 더 삽입 */
				var $tr_subject = $("<tr>").html($("<td colspan='2' class='subject'>").html(value.tq_subject));
				if( i == 0 ){
					table.append($tr_subject);
				}
				if( (i > 0) && ((values[(i-1)][0].tq_subject) != (value.tq_subject)) ){
					table.append($tr_subject);
				}
				
				//문제
				var $tr_question = $("<tr class='question'>");
				$tr_question.append("<td>"+value.tq_small_no+". </td>");
				$tr_question.append("<td>"+value.tq_question+"</td>");
				$tr_question.attr("tqno", value.tq_no);
				$tr_question.attr("tno", value.tno);
				$tr_question.attr("tqsubject", value.tq_subject);
				$tr_question.attr("tqsubjectno", value.tq_subject_no);
				$tr_question.attr("tqsmallno", value.tq_small_no);
				$tr_question.attr("tqper", value.tq_per);
				$tr_question.attr("tqanswer", value.tq_answer);
				table.append($tr_question);
				
				//보기 이미지
				var imageList = values[i][1];
				
				if(imageList.length > 0){
					for(var j=0; j<imageList.length; j++){
						var $tr_image = $("<tr>");
						$tr_image.append("<td></td>");
						$tr_image.append("<td><img src='${pageContext.request.contextPath}/resources/upload/"+imageList[j].imgsource+"'/></td>");
						$tr_image.attr("tqno", imageList[j].tq_no);
						
						table.append($tr_image);
					}
				}
				
				//보기
				var exampleList = values[i][2];
				
				for(var j=0; j<exampleList.length; j++){
					var obj = exampleList[j];
					
					var $tr_example = $("<tr class='example'>");
					$tr_example.append("<td></td>");
					$tr_example.append("<td><a href='#'><span class='te_small_no'>"+obj.te_small_no+"</span>"+obj.te_content+"</a></td>");
					$tr_example.attr("teno", obj.te_no);
					$tr_example.attr("tqno", obj.tq_no);
					$tr_example.attr("tesmallno", obj.te_small_no);
					
					table.append($tr_example);
				}
				
				//omr
				var table_omr = $(".omr-box .table");
				var $tr_omr = $("<tr>");
				$tr_omr.attr("tqno", value.tq_no);
				$tr_omr.append("<td>"+value.tq_small_no+"</td>");
				
				for(var j=0; j<exampleList.length; j++){
					var obj = exampleList[j];
					
					$tr_omr.append("<td>"+obj.te_small_no+"</td>");
				}
				table_omr.append($tr_omr);
				
				//paging버튼
				if(i == 10){
					var button1 = "<button>1 ~ 10</button>";
					var button2 = "<button>11 ~ 20</button>";
					$("#paging").append(button1);
					$("#paging").append(button2);
				}else if(i > 10 && (i%10) == 0){
					var button = "<button>"+(i+1)+" ~ "+(i+10)+"</button>";
					$("#paging").append(button);
				}
			
			}//end of for
			
			//omr제출버튼
			var table_omr = $(".omr-box .table");
			table_omr.append("<tr><td colspan='5' id='btnSendAnswer'><a href=''>답안 제출</a></td></tr>");
			
		}//makeTags
	</script>
</c:if>

