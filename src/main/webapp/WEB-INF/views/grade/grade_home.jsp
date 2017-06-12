<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<!-- graph -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/chart/chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/chart/utils.js"></script>

<style>
.section h1{
	color:#eee;
}
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}

/* ------------
	로딩 이미지 
---------------*/
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

/* -----------
	성적 그래프 
-------------- */
.graph-box-bar, .graph-box-pie, .graph-box-line{
	background-color:rgba(0,0,0,0.2);
	width:70%;
	margin:20px auto;
	padding:20px;
}
.graph-box-bar #canvasTest {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>

<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>성적통계</h1>
			<div class="inner-section">
				<c:if test="${empty testNameList}">
					<script>
						swal({
							title:"저장된 모의고사 성적이 없습니다!",
							text:"모의고사를 본 후 성적을 저장해주세요",
							confirmButtonText: "확인"
						}, function(isConfirm){
							location.replace("${pageContext.request.contextPath}/mock_test/");
						});
					</script>
				</c:if>
				<c:if test="${!empty testNameList}">
					<div class="graph-box-bar">
						<select name="" id="selectTestName">
							<c:forEach var="obj" items="${testNameList }">
								<option value="${obj.tno}">${obj.tname}</option>
							</c:forEach>
						</select>
						<h3 id='testName'>정보처리산업기사1회</h3>
						<canvas id="canvasTest"></canvas>
					</div>
					<div class="graph-box-pie">
						<select name="" id="selectTestNameForDate">
							<c:forEach var="obj" items="${testNameList }">
								<option value="${obj.tno}">${obj.tname}</option>
							</c:forEach>
						</select>
						<select name="" id="selectDate">
							<c:forEach var="obj" items="${dateList }">
								<option value="${obj}">${obj}</option>
							</c:forEach>
						</select>
						<canvas id="pie"></canvas>
					</div>
					<div class="graph-box-line">
						<select name="" id="stringTestName">
							<c:forEach var="obj" items="${testNameList }">
								<option value="${obj.tno}">${obj.tname}</option>
							</c:forEach>
						</select>
						<select name="" id="selectSubject">
							
						</select>
						<canvas id="canvasSubject"></canvas>
					</div>
				</c:if>
				
				<!-- ajax로딩 될 때 뜨는 이미지 -->
				<div class="loading-box">
					<div class="load-wrapp">
						<div class="loading-message">성적 불러오는 중</div>
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
	var g_date = "${dateList.get(0)}";
	var color = Chart.helpers.color; //차트에 사용될 color
	
	var $option01 = "<option value='데이터베이스' selected='selected'>데이터베이스</option>"
							+ "<option value='전자계산기구조'>전자계산기구조</option>"
							+ "<option value='운영체제'>운영체제</option>"
							+ "<option value='소프트웨어공학'>소프트웨어공학</option>"
							+ "<option value='데이터통신'>데이터통신</option>";
	
	$(function(){
		Chart.defaults.global.defaultFontColor = "#eee";
		
		getGradeGroupByTno(tno);
		getGradeListByDate(tno, g_date);
		
		var strTestName = $("#stringTestName").find("option:selected").text();
		if(strTestName.indexOf("정보처리기사") >= 0){
			$("#selectSubject").html($option01);
			
			var subject = $("#selectSubject").val();
			getGradeListBySubject(tno, subject);
		}
		
		/* 기출문제 선택(막대차트) */
		$(document).on("change", "#selectTestName", function(){
			var sendTno = $(this).val();
			
			
			$(this).parent(".graph-box-bar").slideUp("slow", function(){
				getGradeGroupByTno(sendTno);
				
				$(this).slideDown("slow");
			});
		});
		
		/* 날짜를 가져오기 위한 기출문제 선택(파이차트) */
		$(document).on("change", "#selectTestNameForDate", function(){
			var tnoForDate = $(this).val();
			
			getDateList(tnoForDate);
		});
		/* 가져온 날짜 선택(파이차트) */
		$(document).on("change", "#selectDate", function(){
			var sendDate = $(this).val();
			var sendTno = $("#selectTestNameForDate").find("option:selected").val();
			
			getGradeListByDate(sendTno, sendDate);
		});
		
		/* 기출문제 이름 선택(라인차트) */
		$(document).on("change", "#stringTestName", function(){
			var sendTno = $(this).find("option:selected").val();

			var strTestName = $(this).find("option:selected").text();
			if(strTestName.indexOf("정보처리기사") >= 0){
				$("#selectSubject").html($option01);
				
				var subject = $("#selectSubject").val();
				getGradeListBySubject(sendTno, subject);
			}
		});
		/* 과목 선택(라인차트) */
		$(document).on("change", "#selectSubject", function(){
			var sendTno = $("#stringTestName").find("option:selected").val();
			var sendSubject = $(this).val();
			
			getGradeListBySubject(sendTno, sendSubject);
		});
	});
	
	/* --------------------------------------
		getGradeGroupByTno : 기출문제 점수 가져오기
	----------------------------------------- */
	function getGradeGroupByTno(tno){
		$.ajax({
			url:"${pageContext.request.contextPath}/grade/getGradeGroupByTno",
			type:"post",
			data:{tno:tno},
			success:function(result){
				console.log("getGradeGroupByTno...................");
				makeBarChart(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다");
			}
		});
	}
	/* ------------------------
		makeBarChart : 막대 차트
	--------------------------- */
	var myBar;
	function makeBarChart(result){
		var maxSize = result.length < 5 ? result.length : 5;
		var date = new Array();
		var grade = new Array();
		var testName = result[0].testName.tname;
		
		for(var i=0; i<result.length; i++){
			var obj = result[i];
			date[i] = obj.g_date;
			grade[i] = obj.grade;
		}
		
		var barChartData = {
				labels:date,
				datasets:[{
					label:testName,
					backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
					borderColor: window.chartColors.red,
					borderWidth: 2,
					data:grade
				}]
		}
		
		if(window.myBar != null){
			window.myBar.destroy();
		}
		var ctx = document.getElementById("canvasTest").getContext("2d");
		window.myBar = new Chart(ctx, {
            type: 'bar',
            data: barChartData,
            options: {
                responsive: true,
                legend: {
                    position: 'top',
                },
                title: {
                    display: false,
                },
                scales: {
                    yAxes : [{
                        ticks : {
                            max : 100,    
                            min : 0,
                        },
                        gridLines:{
                    		color:"#999999"
                    	}
                    }],
                    xAxes : [{
                    	gridLines:{
                    		color:"#999999"
                    	}
                    }]
                },
            }
        });
	}
	/* ----------------------------------------
		getGradeListByDate : 날짜에 따른 점수 가져오기
	------------------------------------------- */
	function getGradeListByDate(tno, g_date){
		$.ajax({
			url:"${pageContext.request.contextPath}/grade/getGradeListByDate",
			type:"post",
			data:{tno:tno, g_date:g_date},
			success:function(result){
				console.log("getGradeByDate..............");
				makePieChart(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다");
			}
		});
	}
	/* -----------------------
		makePieChart : 파이 차트
	-------------------------- */
	var myPie;
	function makePieChart(result){
		var data = new Array();
		var subject = new Array();
		
		for(var i=0; i<result.length; i++){
			var obj = result[i];
			data[i] = obj.g_subject_grade;
			subject[i] = obj.g_subject;
		}
		
		var pieChartData = {
				labels : subject,
				datasets:[{
					data : data,
					label : 'Dataset 1',
					backgroundColor : [
						window.chartColors.red,
						window.chartColors.orange,
						window.chartColors.yellow,
						window.chartColors.green,
						window.chartColors.blue,
					]
				}]
		};
		
		if(myPie != null){
			myPie.destroy();
		}
		
		var ctx = document.getElementById("pie").getContext("2d");
		
		myPie = new Chart(ctx, {
	    	type: 'pie',
			data: pieChartData,
	        options: {
	            responsive: true,
	            maintainAspectRatio : false
	        }
	    });

		window.myPie = myPie;
	}
	/* --------------------------------
		getDateList : 저장된 리스트 가져오기 
	----------------------------------- */
	function getDateList(tnoForDate){
		$.ajax({
			url:"${pageContext.request.contextPath}/grade/getDateList",
			type:"post",
			data:{tno:tnoForDate},
			success:function(result){
				console.log("getDateList............................");
				makeSelectOption(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다");
			}
		});
	}
	function makeSelectOption(result){
		$("#selectDate").html("");
		
		for(var i=0; i<result.length; i++){
			var obj = result[i];
			var $option = $("<option value='"+obj+"'>").html(obj);
			$("#selectDate").append($option);
		}
		
		var sendDate = result[0];
		var sendTno = $("#selectTestNameForDate").find("option:selected").val();
		
		getGradeListByDate(sendTno, sendDate);
	}
	
	/* -------------------------------------
		getGradeListBySubject : 과목별 점수 보기
	---------------------------------------- */
	function getGradeListBySubject(tno, subject){
		$.ajax({
			url:"${pageContext.request.contextPath}/grade/getGradeListBySubject",
			type:"post",
			data:{tno:tno, g_subject:subject},
			success:function(result){
				makeLineChart(result);
			},
			error:function(e){
				alert("에러가 발생하였습니다.");
			}
		});
	}
	/* ------------------------
		makeLineChart : 라인 차트
	--------------------------- */
	function makeLineChart(result){
		var maxSize = result.length > 7 ? 7 : result.length;
		var grade = new Array();
		var date = new Array();
		var label = result[0].g_subject;
		
		for(var i=0; i<maxSize; i++){
			var obj = result[i];
			grade[i] = obj.g_subject_grade;
			date[i] = obj.g_date;
		}
		
		var lineChartData = {
				labels : date,
				datasets:[{
					data : grade,
					label : label,
					backgroundColor : window.chartColors.blue,
					borderColor: window.chartColors.blue,
					fill:false
				}]
		};
			
		if(window.myLine != null){
			window.myLine.destroy();
		}
		var ctx2 = document.getElementById("canvasSubject").getContext("2d");
       	window.myLine = new Chart(ctx2, {
        	type: 'line',
            data: lineChartData,
            options: {
                responsive: true,
                title:{
                    display:false,
                },
                tooltips: {
                    mode: 'index',
                    intersect: false,
                },
                hover: {
                    mode: 'nearest',
                    intersect: true
                },
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: '날짜'
                        },
                        gridLines:{
                    		color:"#999999"
                    	}
                    }],
                    yAxes: [{
                        display: true,
                        ticks : {
                            max : 100,    
                            min : 0,
                        },
                        gridLines:{
                    		color:"#999999"
                    	}
                    }]
                }
            }
        });
	}
</script>