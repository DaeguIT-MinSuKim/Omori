<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login-join.css" />
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.section h1, .section label{
	color:#6e4a37;
}
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}
.testquestion-box textarea{
	width:300px;
	height:50px;
}
.how-to{padding:10px 20px;}
.how-to ul{float:right;width:680px;}
.how-to ul li{margin-bottom:14px;color:#4a927d;}
.how-to ul li span{display:block;margin-left:20px;color:#ea6149;}
.how-to ul li span.more-emphasis{color:#de3232  !important;}
.how-to ul li.down-li a{font-weight:bold; font-family: sans-serif;}
.how-to ul li.down-li a:HOVER{text-decoration: underline;}
.how-to img {float:left;margin-right:12px;width:510px;}

.clear-how{clear:both;width:100%;padding:20px 0 0;}
.clear-how span{font-size:18px;color:#ff6666;display:block;}
.clear-how #uploadForm p{display: inline-block;margin-right:30px;}

img.icon-down{width:20px !important;}
img.icon-edit{width:20px !important; float:none; cursor: pointer; position:relative; 
			padding:0 5px; margin-left:5px; margin-bottom:-5px;}

.testname-select-box{}
.testname-select-box .btnAddTestName{font-size:20px; position: relative;}
.each-testname-box div{margin:10px; display: inline-block;}
.each-testname-box div a{padding:5px 0; color:#d74526;}

/* ------------
	popup창 
-------------*/
.login-container .form {text-align: left;}

.add-question-popup .login-page {width:600px;}
.add-question-popup .login-page .form {max-width:600px;}
.add-question-popup .login-page .form label {display: inline-block; width:120px;}
.add-question-popup .login-page .tqsmallno-box{text-align: center;}
.add-question-popup .login-page .tqsmallno-box a[tqsmallno='91']{margin-left:13px;}
.add-question-popup .login-page #q-tname{color:#d74526}

.add-example-popup .login-page {width:700px; margin-top:-100px;}
.add-example-popup .login-page .form {max-width:700px; }
.add-example-popup .login-page .form div{clear:both;}
.add-example-popup .login-page .form div input[type='radio'] {width:15px; margin-top:10px;}
.add-example-popup .login-page .form div textarea{width:90%; float:right;}
.add-example-popup .login-page .form input[type='file']{background: none;display: inline-block;width: 80%;}
.add-example-popup .login-page .login-close{text-align: left;}
.preview{padding:0 15px 15px;}
.preview img{max-width:200px; max-height:130px;}
.preview a{cursor: pointer; background: #4caf50;position: absolute;margin-left: -15px;margin-top: -10px;padding: 5px;
			border-radius: 50%;border: 2px solid #eee;box-shadow: 0.5px 0.5px 1px black; width: 15px; height: 15px;
    		display: inline-block;font-weight: bold;text-align: center;}

.edit-testname-popup .login-page .form .button-box{text-align: center;}
.edit-testname-popup .login-page .form .button-box button{width:49%;}

.add-question-popup .login-page .tqsmallno-box a{color:#333; font-weight: bold; padding:4px; margin:2px 4px;}
a.cant-sel-a{cursor: default; color:#ddd !important; font-weight: lighter !important;}
a.selected-no{color:#cc0000 !important;}


/* ------------
	로딩 이미지
-------------*/
.add-question-popup .login-page .form .login-form{display:none;}

.loading-box {display:none;}
.loading-box .load-wrapp {float: left; width: 100%; text-align: center;}
.loading-box .load-wrapp .loading-message{color:#303030;font-size:20px;margin-bottom:10px;}
.loading-box .load-wrapp .load-3 .line {display: inline-block; width: 25px; height: 25px; margin:5px 4px 0; 
										border-radius: 15px; background-color: #4b9cdb;}
.loading-box .clear{clear:both;}

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
			<h1>기출문제 등록</h1>
			<div class="inner-section">
				<div class="testname-box">
					<div class="how-to">
						<h3>기출문제 한꺼번에 등록하는 방법</h3>
						<div class="how-to-name">
							<img src="${pageContext.request.contextPath}/resources/images/ex_name.png" alt="" />
							<ul>
								<li class='down-li'>
									<img src='${pageContext.request.contextPath}/resources/images/ic-download.png' class='icon-down'>
									<a href="${pageContext.request.contextPath}/admin/downloadExcel/name">testname.xlsx</a>
								</li>
								<li>
									1. 자격증번호<br />
									<span>※ 각 자격증의 고유번호이기 때문에 모두 상이해야합니다</span>
									<span id='setLastTnoText' class='more-emphasis'></span>
								</li>
								<li>
									2. 자격증명 : 자격증명 - 시행년도 - 회차 순으로 입력해주세요 <br />
									<span>※ 기출문제 목록을 가져올 때 이름순으로 가져오게 됩니다</span>
								</li>
								<li>
									3. 시험날짜 : 시험 시행 날짜
								</li>
							</ul>
						</div>
						<div class="clear-how"></div>
						<div class="how-to-question">
							<img src="${pageContext.request.contextPath}/resources/images/ex_question.PNG" alt="" />
							<ul>
								<li class='down-li'>
									<img src='${pageContext.request.contextPath}/resources/images/ic-download.png' class='icon-down'>
									<a href="${pageContext.request.contextPath}/admin/downloadExcel/question">testquestion.xlsx</a>
								</li>
								<li>
									1. 문제고유번호<br />
									<span>
										※ 각 문제의 고유번호이기 때문에 모두 상이해야합니다<br />
										&nbsp;&nbsp;&nbsp;&nbsp;ex) 기출문제의 문제를 등록할 때 고유번호의 마지막 번호가 100이었다면 다음 기출문제의 문제의<br /> 
										&nbsp;&nbsp;&nbsp;&nbsp;고유번호는 101이 됩니다
									</span>
									<span id='setLastTqnoText' class='more-emphasis'></span>
								</li>
								<li>
									2. 자격증번호 : 등록하고자 하는 기출문제에 대응하는 기출문제번호를 입력해주세요
								</li>
								<li>
									3. 과목명 : 기출문제의 과목명
								</li>
								<li>
									4. 문제번호 : 각 문제번호<br />
									<span>
										※ 문제고유번호와 다릅니다<br />
										&nbsp;&nbsp;&nbsp;&nbsp;기출문제 내 각 문제의 번호입니다
									</span>
								</li>
							</ul>
						</div>
						<div class="clear-how"></div>
						<div class="how-to-example">
							<img src="${pageContext.request.contextPath}/resources/images/ex_example.png" alt="" />
							<ul>
								<li class='down-li'>
									<img src='${pageContext.request.contextPath}/resources/images/ic-download.png' class='icon-down'>
									<a href="${pageContext.request.contextPath}/admin/downloadExcel/example">testexample.xlsx</a>
								</li>
								<li>
									1. 문제고유번호 : 각 문제에 대응하는 문제고유번호
								</li>
								<li>
									2. 보기번호 : 각 문제의 보기 번호
								</li>
							</ul>
						</div>
						<div class="clear-how">
							<span>※ 각 문제에 해당하는 이미지는 기출문제 수정 메뉴에서 수정 / 등록하시면 됩니다</span>
							<form action="" method="post" enctype="multipart/form-data" id="uploadForm">
								<p>
									<label for="">기출문제 : </label><input type="file" name='nameFile' id='nameFile'/>
								</p>
								<p>
									<label for="">문제 : </label><input type="file" name='questionFile' id='questionFile'/>
								</p>
								<p>
									<label for="">보기 : </label><input type="file" name='exampleFile' id='exampleFile'/>
								</p>
								<p>
									<button id='btnUpload' class="same-button-style">등록</button>
								</p>
							</form>
						</div>
						<hr />
						<h3>기출문제 낱개로 등록</h3>
						<c:if test="${nameList.size() < 1}">
							<div class="no-testname">
								<p>등록된 자격증이 없습니다. 자격증을 등록 후 기출문제를 등록해주세요. >> <a href="" class="btnAddTestName same-button-style">자격증등록</a></p>
							</div>
						</c:if>
						<div class="testname-select-box">
							<p>자격증을 선택하면 기출문제 등록창이 나타납니다. >> <a href="" class="btnAddTestName">자격증 더 등록하기</a></p>
							<div class='each-testname-box'>
								<%-- <a href="" tno="${obj.tno}">${obj.tname}</a> --%>
							</div>
						</div>
						<div class="testname-list-box">
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<!-- 자격증 등록 팝업 -->
<div class="login-container add-testname-popup">
	<div class="login-page">
		<div class="login-close">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-close-button.png" alt="" /></a>
		</div>
		<div class="form">
			<form class="login-form">
				<h2 class="form-title">자격증 등록</h2>
				<label for="">자격증 번호</label>
				<input type="text" value='1' id='addTno' disabled="disabled"/>
				<label for="">자격증 이름</label>
				<input type="text" placeholder="정보처리기사 2016년 1회" id='addTname'/>
				<label for="">시행 날짜</label>
				<input type="text" placeholder="2016-03-06" id='addTdate'/>
				<button id="btnInsertTestNameForm">등록</button>
			</form>
		</div>
	</div>
</div>

<!-- 문제등록 팝업 -->
<div class="login-container add-question-popup">
	<div class="login-page">
		<div class="login-close">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-close-button.png" alt="" /></a>
		</div>
		<div class="form">
			<!-- ajax로딩 될 때 뜨는 이미지 -->
			<div class="loading-box">
				<div class="load-wrapp">
					<div class="loading-message">문제번호를 불러오는 중입니다</div>
					<div class="load-3">
						<div class="line"></div>
						<div class="line"></div>
						<div class="line"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<form class="login-form">
				<h2 class="form-title">기출문제 등록</h2>
				<div><label for="">자격증 번호</label><span id='q-tno'>1</span></div>
				<div><label for="">자격증 이름</label><span id='q-tname'>정보처리기사 2016년 1회</span></div>
				<div><label for="">문제 고유 번호</label><span id='q-tqno'>1</span></div>
				<div><label for="">과목</label><select id="subjectList"></select></div>
				<div>
					<label for="">문제 번호</label>
					<div class="tqsmallno-box"></div>
				</div>
				<label for="">문제 내용</label>
				<textarea id="q-question" cols="30" rows="3"></textarea>
				<button id="btnInsertExample">보기 및 정답 등록</button>
			</form>
		</div>
	</div>
</div>

<!-- 보기 등록 팝업 -->
<div class="login-container add-example-popup">
	<div class="login-page">
		<div class="login-close">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-back-button.png" alt="" /></a>
		</div>
		<div class="form">
			<form class="login-form">
				<h2 class="form-title">보기 및 정답 등록</h2>
				<div>
					<label for="">보기이미지</label><input type="file" id="add-img" /><br />
					<div class="preview"></div>
				</div>
				<div><input type="radio" value='1'/> 1. <textarea id="example01" cols="30" rows="3"></textarea></div>
				<div><input type="radio" value='2'/> 2. <textarea id="example02" cols="30" rows="3"></textarea></div>
				<div><input type="radio" value='3'/> 3. <textarea id="example03" cols="30" rows="3"></textarea></div>
				<div><input type="radio" value='4'/> 4. <textarea id="example04" cols="30" rows="3"></textarea></div>
				<button id="btnInsertQueAndExForm">기출문제 등록</button>
			</form>
		</div>
	</div>
</div>

<!-- 자격증 수정 팝업 -->
<div class="login-container edit-testname-popup">
	<div class="login-page">
		<div class="login-close">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-close-button.png" alt="" /></a>
		</div>
		<div class="form">
			<form class="login-form">
				<h2 class="form-title">자격증 수정</h2>
				<label for="">자격증 번호</label>
				<input type="text" id='editTno' disabled="disabled"/>
				<label for="">자격증 이름</label>
				<input type="text" id='editTname'/>
				<label for="">시행 날짜</label>
				<input type="text" id='editTdate'/>
				<div class='button-box'>
					<button id="btnUpTestName">수정</button>
					<button id="btnDelTestName" class='negative-btn-style'>삭제</button>
				</div>
			</form>
		</div>
	</div>
</div>


<script>
/*---------------
	자격증등록 ajax
-----------------*/
function insertTestNameAjax(){
	var tname = $("#addTname").val();
	var tdate = $("#addTdate").val();
	
	if(tname == "" || tdate == ""){
		swal({
			title: "모든 입력창을 채워주세요!",
			confirmButtonText: "확인",
		});
		return;
	}
	
	swal({
		title: tname,
		text:"등록하시겠습니까?",
		showCancelButton:true,
		cancelButtonText: "취소",
		confirmButtonText: "등록",
		closeOnConfirm:false
	}, function(isConfirm){
		if(isConfirm){
			$.ajax({
				url:"${pageContext.request.contextPath}/admin/insertTestName",
				type:"post",
				data:{"tname" : tname, "tdate":tdate},
				success:function(result){
					getLastTnoTqnoAjax();
					$(".no-testname").css("display", "none");
					
					swal({
						title:"성공적으로 등록되었습니다",
						confirmButtonText: "확인"
					});
					$(".login-container").fadeOut("fast");
					
					getTestNameListAjax();
					
					$(".add-testname-popup #addTname").val("");
					$(".add-testname-popup #addTdate").val("");
				},
				error:function(e){
					alert("에러가 발생하였습니다");
				}
			});
		}
	});
}

/* ----------------
	자격증 수정 ajax
-----------------*/
function updateTestNameAjax(){
	var tno = $("#editTno").val();
	var tname = $("#editTname").val();
	var tdate = $("#editTdate").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/updateTestName",
		type:"post",
		data:{"tno":tno, "tname":tname, "tdate":tdate},
		success:function(result){
			getLastTnoTqnoAjax();
			getTestNameListAjax();
			
			swal({
				title:"자격증이 수정되었습니다",
				confirmButtonText: "확인"
			});
			
			$(".login-container").fadeOut("fast");
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/*-----------------
	자격증삭제 ajax
-----------------*/
function deleteTestNameAjax(){
	var tno = $("#editTno").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/deleteTestName",
		type:"post",
		data:{"tno":tno},
		success:function(result){
			getLastTnoTqnoAjax();
			getTestNameListAjax();
			
			swal({
				title:"삭제되었습니다",
				confirmButtonText: "확인"
			});
			
			$(".login-container").fadeOut("fast");
		},
		error:function(e){
			alert("에러가 발생하였습니다");	
		}
	});
}

/*----------------------------------------------
	자격증 마지막 tno, 기출문제 마지막 tqno 가져오는 ajax
----------------------------------------------*/
var lastTno;
var lastTqno;
function getLastTnoTqnoAjax(){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/getLastTnoTqno",
		type:"post",
		success:function(result){
			lastTno = result[0];
			lastTqno = result[1];
			
			$("#setLastTnoText").html("※ 지금까지 등록된 자격증번호는 <b>"+ (lastTno-1) +"</b>입니다<br>"
										+"&nbsp;&nbsp;&nbsp;&nbsp;엑셀로 작성할 때 자격증번호는 <b>"+ lastTno +"</b>(으)로 시작해주십시오<br>"
										+"&nbsp;&nbsp;&nbsp;&nbsp;그렇지 않으면 덮어 씌워서 등록이 됩니다");
			
			$("#setLastTqnoText").html("※ 지금까지 등록된 문제고유번호는 <b>"+ (lastTqno-1) +"</b>입니다<br>"
										+"&nbsp;&nbsp;&nbsp;&nbsp;엑셀로 작성할 때 문제고유번호는 <b>"+ lastTqno +"</b>(으)로 시작해주십시오<br>"
										+"&nbsp;&nbsp;&nbsp;&nbsp;그렇지 않으면 덮어 씌워서 등록이 됩니다");
			
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}
/* -----------------------
	자격증 목록 가져오는 ajax
------------------------*/
function getTestNameListAjax(){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/getTestNameList",
		type:"post",
		success:function(result){
			$(".testname-select-box").find(".each-testname-box").html("");
			for(var i=0; i<result.length; i++){
				var obj = result[i];
				var $a = "<a href='' tno='"+obj.tno+"' tdate='"+obj.tdate+"'>"+obj.tname+"</a>";
				var $img = "<img src='${pageContext.request.contextPath}/resources/images/ic-edit-button.png' class='icon-edit'/>";
				var $div = $("<div>");
				$div.append($a);
				$div.append($img);
				$(".testname-select-box").find(".each-testname-box").append($div);
				$(".testname-select-box").css("display", "block");
			}
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/* --------------------------
	문제 번호 리스트 가져오는 ajax
---------------------------*/
var tqSmallNoList;
function getTqSmallNoListAjax(no){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/getTqSmallNoList",
		data:{"tno":no},
		type:"post",
		success:function(result){
			tqSmallNoList = new Array();
			for(var i=0; i<result.length; i++){
				tqSmallNoList[i] = result[i];
			}
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/* -----------------------
	믄제 및 보기 등록하는 ajax
------------------------*/
function insertQuestionExampleAjax(){
	//$(".add-question-popup").find()
	var sendTno = $("#q-tno").text();
	var sendTqSubject =  $("#subjectList").val();
	var sendTqSmallNo = $(".tqsmallno-box").find("a.selected-no").text();
	var sendTqQuestion = $("#q-question").val();
	//$(".add-example-popup").find()
	var sendTqAnswer = $(".add-example-popup").find("input[type='radio']:checked").val();
	var example1 = $("#example01").val();
	var example2 = $("#example02").val();
	var example3 = $("#example03").val();
	var example4 = $("#example04").val();
	
	var formData = new FormData();
	formData.append("tno", sendTno);
	formData.append("tq_subject", sendTqSubject);
	formData.append("tq_small_no", sendTqSmallNo);
	formData.append("tq_question", sendTqQuestion);
	formData.append("tq_answer", sendTqAnswer);
	formData.append("example1", example1);
	formData.append("example2", example2);
	formData.append("example3", example3);
	formData.append("example4", example4);
	formData.append("file", $("#add-img")[0].files[0]);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/insertQuestionExample",
		type:"post",
		processData: false,
	    contentType: false,
		data:formData,
		success:function(result){
			getLastTnoTqnoAjax();
			
			swal({
				title:"등록되었습니다",
				confirmButtonText: "확인"
			});
			$(".login-container").fadeOut("fast");
			
			$("#example04").val("");
			$("#example03").val("");
			$("#example02").val("");
			$("#example01").val("");
			$(".add-example-popup").find("input[type='radio']").prop("checked", false);
			$("#q-question").val("");
			$("#add-img").val("");
		},
		error:function(e){
			alert("에러가 발생하였습니다");	
		}
	});
}

/*---------------------
	엑셀 파일 업로드 ajax 
---------------------*/
function check() {
	var file1 = $("#nameFile").val();
	var file2 = $("#questionFile").val();
	var file3 = $("#exampleFile").val();
	
	if ( (file1 == "" || file1 == null)
		&& (file2 == "" || file2 == null)
		&& (file3 == "" || file3 == null) ) {
		swal({
			title:"파일을 하나 이상 등록해주세요",
			confirmButtonText: "확인"
		});
		return false;
		
	} else {
		if(file1 != "" && file1 != null){
			if( !checkFileType(file1) ){
				swal({
					title:"엑셀(.xlsx) 파일만 업로드 가능합니다",
					confirmButtonText: "확인"
				});
				return false;
			}
		}
		
		if(file2 != "" && file2 != null){
			if( !checkFileType(file2) ){
				swal({
					title:"엑셀(.xlsx) 파일만 업로드 가능합니다",
					confirmButtonText: "확인"
				});
				return false;
			}
		}
		
		if(file3 != "" && file3 != null){
			if( !checkFileType(file3) ){
				swal({
					title:"엑셀(.xlsx) 파일만 업로드 가능합니다",
					confirmButtonText: "확인"
				});
				return false;
			}
		}
	}
	
	swal({
		title:"기출문제를 등록하시겠습니까?",
		showCancelButton:true,
		cancelButtonText: "아니오",
		confirmButtonText: "네",
		showLoaderOnConfirm: true,
		closeOnConfirm:false
	}, function(isConfirm){
		if(isConfirm){
			var sendForm = $("form#uploadForm")[0];
			var formData = new FormData(sendForm);
			
			$.ajax({
				url:"${pageContext.request.contextPath}/admin/uploadExcelFile",
				method:"post",
				enctype:"multipart/form-data",
				data:formData,
				processData: false,
                contentType: false,
				success:function(result){
					
					var title;
					var text = "";
					if(result == "success"){
						title = "정상적으로 등록되었습니다";
					}else if(result == "matchingError"){
						title = "파일이 일치하지 않습니다!";
						text = "각 분야에 맞는 파일을 넣었는지 확인해주세요";
					}else if(result == "testNameNull"){
						title = "기출문제가 존재하지 않습니다!";
						text = "자격증을 먼저 등록하고 수행해주세요";
					}else if(reuslt == "testQuestionNull"){
						title = "문제가 존재하지 않습니다!";
						text = "문제를 먼저 등록하고 수행해주세요";
					}
					
					swal({
						title:title,
						text:text,
						confirmButtonText: "확인"
					});

					getLastTnoTqnoAjax();
					getTestNameListAjax();
					$(".no-testname").css("display","none");
					
					$("#uploadForm input[type='file']").val("");
				},
				error:function(e){
					alert("에러가 발생하였습니다");
				}
			});
		}
	});
}

function checkFileType(file) {
	var format = file.split(".");
	
	if (format.indexOf("xlsx") > -1) {
		return true;
	} else {
		return false;
	}
}

$(function(){
	getLastTnoTqnoAjax();
	
	/*등록된 자격증이 없으면 자격증리스트 숨기기 있으면 보여줌*/
	if($(".no-testname").css("display") == "block"){
		$(".testname-select-box").css("display", "none");
	}else{
		getTestNameListAjax();
	}
});

</script>
<script src="${pageContext.request.contextPath}/resources/js/insert_test.js"></script>
