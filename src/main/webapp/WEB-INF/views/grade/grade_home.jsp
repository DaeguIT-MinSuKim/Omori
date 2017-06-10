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
.graph-box{
	background-color:rgba(0,0,0,0.2);
	width:70%;
	margin:20px auto;
	padding:20px;
}
.graph-box #canvasTest {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
.graph-bx #pie{
	size: 300;
}
</style>

<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>성적통계</h1>
			<div class="inner-section">
				<c:if test="${testNameList.size() < 1}">
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
				<c:if test="${testNameList.size() > 0}">
					<div class="graph-box">
						<select name="" id="selectTestName">
							<c:forEach var="obj" items="${testNameList }">
								<option value="${obj.tno}">${obj.tname}</option>
							</c:forEach>
						</select>
						<h3 id='testName'>정보처리산업기사1회</h3>
						<canvas id="canvasTest"></canvas>
					</div>
					<div class="graph-box">
						<canvas id="pie"></canvas>
					</div>
					<div class="graph-box">
						<h3>데이터베이스</h3>
						<canvas id="canvasSubject"></canvas>
					</div>
				</c:if>
				
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
	var color = Chart.helpers.color;
	var barChartData = {
	    labels: ["January", "February", "March", "April", "May", "June", "July"],
	    datasets: [{
	    	label:"점수",
	        backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
	        borderColor: window.chartColors.red,
	        borderWidth: 2,
	        data: [ 10, 20, 30, 40, 55, 60, 81 ]
	    }, ]
	};
	
	/* ------------
		pie chart
	--------------- */
	var config = {
			type: 'pie',
			data: {
				datasets: [{
					data: [10,20,30,40,50],
					backgroundColor: [
						window.chartColors.red,
						window.chartColors.orange,
						window.chartColors.yellow,
	                    window.chartColors.green,
	                    window.chartColors.blue,
					],
					label: 'Dataset 1'
				}],
				labels: [
					"Red",
	                "Orange",
	                "Yellow",
	                "Green",
	                "Blue"
				]
			},
	        options: {
	            responsive: true
	        }
	   };
	
	$(function(){
		/* ----------
			시험별 차트
		-------------*/
		Chart.defaults.global.defaultFontColor = "#eee";
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
        
        /* ----------
			과목별 차트
		-------------*/
        var ctx2 = document.getElementById("canvasSubject").getContext("2d");
        window.myLine = new Chart(ctx2, {
        	type: 'line',
            data: {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [{
                    label: "점수",
                    backgroundColor: window.chartColors.blue,
                    borderColor: window.chartColors.blue,
                    data: [
                           5,10,15,20,30,60,70
                    ],
                    fill: false,
                }]
            },
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
                            labelString: 'Month'
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
        
        
        /* 파이차트 */
        var ctx3 = document.getElementById("pie").getContext("2d");
        window.myPie = new Chart(ctx3, {
        	type: 'pie',
			data: {
				datasets: [{
					data: [10,20,30,40,50],
					backgroundColor: [
						window.chartColors.red,
						window.chartColors.orange,
						window.chartColors.yellow,
	                    window.chartColors.green,
	                    window.chartColors.blue,
					],
					label: 'Dataset 1'
				}],
				labels: [
					"Red",
	                "Orange",
	                "Yellow",
	                "Green",
	                "Blue"
				]
			},
	        options: {
	            responsive: true,
	            maintainAspectRatio : false
	        }
        });
	})
</script>