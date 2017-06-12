<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login-join.css" />
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.section h1, .section label{
	color:#eee;
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
.preview img{
	max-width:200px;
	max-height:200px;
}
.how-to{
	background:rgba(0,0,0,0.5);
	padding:10px 20px;
}
.how-to-name img, .how-to-question img, .how-to-example img{
	float:left;
	margin-right:12px;
	width:510px;
}
.how-to-name ul, .how-to-question ul, .how-to-example ul{
	float:right;
	width:680px;
}
.how-to-name ul li, .how-to-question ul li, .how-to-example ul li{
	margin-bottom:14px;
	color:#99cccc;
}
.how-to-name ul li span, .how-to-question ul li span, .how-to-example ul li span{
	display:block;
	margin-left:20px;
	color:#cc9999;
}
li.down-li a{
	font-weight:bold;
	font-family: sans-serif;
}
li.down-li a:HOVER{
	text-decoration: underline;
}
img.icon-down{
	width:20px !important;
}
.clear-how{
	clear:both;
	width:100%;
	padding:20px 0 0;
}
.clear-how span{
	font-size:18px;
	color:#ff6666;
	display:block;
}
.clear-how #uploadForm p{
	display: inline-block;
	margin-right:30px;
}


/* ------------
	popup창 
-------------*/
.login-container .form {text-align: left;}

.add-question-popup .login-page {width:600px;}
.add-question-popup .login-page .form {max-width:600px;}
.add-question-popup .login-page .form label {display: inline-block; width:120px;}

.add-example-popup .login-page {width:700px; margin-top:-50px;}
.add-example-popup .login-page .form {max-width:700px; }
.add-example-popup .login-page .form div{clear:both;}
.add-example-popup .login-page .form div input[type='radio'] {width:15px; margin-top:10px;}
.add-example-popup .login-page .form div textarea{width:90%; float:right;}

a.can-sel-a{color:#333; font-weight: bold;}
a.selected-no{color:#cc0000;}
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
						<h3>기출문제 등록 방법(한꺼번에 등록하기)</h3>
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
									<span id='setLastTnoText'></span>
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
									<span id='setLastTqnoText'></span>
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
							<span>※ 각 문제에 해당하는 이미지는 문제 등록 후 나오는 리스트에서 등록하시면 됩니다</span>
							<form action="${pageContext.request.contextPath}/admin/uploadFile" method="post" enctype="multipart/form-data" id="uploadForm">
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
									<button id='btnUpload'>등록</button>
								</p>
							</form>
						</div>
						<hr />
						<c:if test="${nameList.size() < 1}">
							<div class="no-testname">
								<p>등록된 자격증이 없습니다. 자격증을 등록 후 기출문제를 등록해주세요. >> <a href="" id="btnAddTestName">자격증등록</a></p>
							</div>
						</c:if>
						<c:if test="${nameList.size() > 0}">
							<div class="testname-select-box">
								<p>자격증을 선택하면 기출문제 등록창이 나타납니다.</p>
								<div class='each-testname-box'>
									<c:forEach var="obj" items="${nameList}">
										<a href="" tno="${obj.tno}">${obj.tname}</a>
									</c:forEach>
								</div>
							</div>
						</c:if>
						<div class="testname-list-box">
						</div>
					</div>
				</div>
				<div class="testquestion-box">
					<h3>과목 선택</h3>
					<div>
						<select id="subjectNameList"></select>
					</div>
					<!-- tno, tq_subject, tq_subject_no, tq_small_no, tq_question, tq_answer, tq_per, tq_image -->
					<h3>문제 등록<button id="btnAddQuestion">추가</button></h3>
					<div class="testquestion-add-box">
						<form action="${pageContext.request.contextPath}/admin/insert_result" method="post" enctype="multipart/form-data">
							<input type="hidden" name='tno' id='tno'/>
							<input type="hidden" name='tq_subject' id='tq_subject'/>
							<input type="hidden" name='tq_subject_no' id='tq_subject_no'/>
							<div>
								<label for="">번호</label><input type="text" name='tq_small_no'/>
							</div>
							<div>
								<label for="">문제</label><textarea name='tq_question'></textarea>
							</div>
							<div>
								<label for="">정답</label><textarea name='tq_answer'></textarea>
							</div>
							<div>
								<label for="">보기이미지</label>
								<input type="file" multiple="multiple" id="tq_image" name='files'/>
								<div class="preview"></div>
							</div>
							<h3>보기 등록<button id="btnAddExample">추가</button><button id="btnDelExample">삭제</button></h3>
							<div class="testexample-box">
								<!-- tq_no, te_small_no, te_content -->
								<div>
									<input type="hidden" name='te_small_no' value='1'/>
									<label for="">보기 <span>1</span></label><textarea name="te_content"></textarea>
								</div>
							</div>
							<div class="button-box">
								<button>등록</button>
							</div>
						</form>
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
				<label for="">시험 날짜</label>
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
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-close-button.png" alt="" /></a>
		</div>
		<div class="form">
			<form class="login-form">
				<h2 class="form-title">보기 및 정답 등록</h2>
				<div><input type="radio" value='1'/> 1. <textarea id="example01" cols="30" rows="3"></textarea></div>
				<div><input type="radio" value='2'/> 2. <textarea id="example02" cols="30" rows="3"></textarea></div>
				<div><input type="radio" value='3'/> 3. <textarea id="example03" cols="30" rows="3"></textarea></div>
				<div><input type="radio" value='4'/> 4. <textarea id="example04" cols="30" rows="3"></textarea></div>
				<button id="btnInsertQueAndExForm">기출문제 등록</button>
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
				},
				error:function(e){
					alert("에러가 발생하였습니다");
				}
			});
		}
	});
}

/*-------------------------------
	마지막 tno, tqno 가져오는 ajax
-------------------------------*/
var lastTno;
var lastTqno;
function getLastTnoTqnoAjax(){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/getLastTnoTqno",
		type:"post",
		success:function(result){
			lastTno = result[0];
			lastTqno = result[1];
			
			$("#setLastTnoText").html("※ 지금까지 등록된 자격증번호는 "+ (lastTno-1) +"입니다<br>"
										+"&nbsp;&nbsp;&nbsp;&nbsp;엑셀로 등록할 때 자격증번호는 "+ lastTno +"로 작성해주십시오");
			
			$("#setLastTqnoText").html("※ 지금까지 등록된 문제고유번호는 "+ (lastTqno-1) +"입니다<br>"
										+"&nbsp;&nbsp;&nbsp;&nbsp;엑셀로 등록할 때 문제고유번호는 "+ lastTqno +"로 작성해주십시오");
			
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}

/* --------------------------
	문제 번호 리스트 가져오는 ajax
---------------------------*/
var tqSmallNoList = new Array();
function getTqSmallNoListAjax(no){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/getTqSmallNoList",
		data:{"tno":no},
		type:"post",
		success:function(result){
			if(result.length == 0){
				tqSmallNoList = null;	
			}else{
				for(var i=0; i<result.length; i++){
					tqSmallNoList[i] = result[i];
				}
			}
		},
		error:function(e){
			alert("에러가 발생하였습니다");
		}
	});
}


$(function(){
	getLastTnoTqnoAjax();
	
	$(".each-testname-box a").click(function(e){
		e.preventDefault();
		$(".add-question-popup").fadeIn("fast");
	});
	
	$(".add-question-popup #btnInsertExample").click(function(e){
		e.preventDefault();
		$(".add-example-popup").fadeIn("fast");
	});
	

	$("#btnUpload").click(function(e){
		e.preventDefault();
		check();
	});
	
	
	/* 자격증 리스트 */
	//setTestNameList();
	
	
	/* 자격증 선택하면 그에 해당하는 과목이 나오도록 */
	$(document).on("change", "#testNameList", function(){
		if($(this).val() != 0){
			getSubjectNames($(this).val());
			$("input#tno").val($(this).val());
		}
	});
	
	/* 과목 선택 */
	$(document).on("change", "#subjectNameList", function(){
		if($(this).val() != 0){
			var tq_subject = $(this).find("option:selected").text();
			var tq_subject_no = $(this).val();
			$("input#tq_subject").val(tq_subject);
			$("input#tq_subject_no").val(tq_subject_no);
		}
	});
	
	/* 문제 등록 추가 */
	$("#btnAddQuestion").click(function(e){
		e.preventDefault();
	});
	
	/* 보기 이미지 등록 */
	$("#tq_image").change(function(){
		var isImage = true;
		var files = document.getElementById("tq_image").files;
		
		for(var i=0; i<files.length; i++){
			if ( (files[i].type).indexOf("image") < 0 ) {
				alert("이미지 파일을 등록해주세요!");
				isImage = false;
				break;
			}
		}

		//이미지파일이 아니면 return
		if( !isImage ){
			$(this).val("");
			$(".preview").html("");
			return false;
		}
		
		//이미지 태그 생성
		for(var i=0; i<files.length; i++){
			var file = files[i];
			var reader = new FileReader();
			reader.onload = function (e) {
				var $img = $("<img>").attr("src", e.target.result);
				$(".preview").append($img);
	        }
			reader.readAsDataURL(file);
		}
	});
	
	/* 보기추가 */
	$("#btnAddExample").click(function(e){
		e.preventDefault();
		
		var $div = $(".testexample-box").find("div").last();
		var no = Number($div.find("span").html()) + 1;
		
		var $newDiv = $("<div>");
		$newDiv.append( $("<input type='hidden' name='te_small_no' value='"+no+"'>") );
		$newDiv.append( $("<label>").html("보기 ").append( $("<span>").html(no)) );
		$newDiv.append( $("<textarea name='te_content'>"));
		
		$(".testexample-box").append($newDiv);
	});
	
	/* 보기삭제 */
	$("#btnDelExample").click(function(e){
		e.preventDefault();
		
		if($(".testexample-box").find("div").last().find("label span").html() == 1){
			return;
		}
		$(".testexample-box").find("div").last().remove();
	})
});

function check() {
	var file1 = $("#nameFile").val();
	var file2 = $("#questionFile").val();
	var file3 = $("#exampleFile").val();
	
	if (file1 == "" || file1 == null
		|| file2 == "" || file2 == null
		|| file3 == "" || file3 == null) {
		swal({
			title:"파일을 선택해주세요",
			confirmButtonText: "확인"
		});
		return false;
	} else if ( !checkFileType(file1, file2, file3) ) {
		swal({
			title:"엑셀(xlsx) 파일만 업로드 가능합니다",
			confirmButtonText: "확인"
		});
		return false;
	}
	
	swal({
		title:"기출문제를 등록하시겠습니까?",
		showCancelButton:true,
		cancelButtonText: "아니오",
		confirmButtonText: "네",
	}, function(isConfirm){
		if(isConfirm){
			$("form#uploadForm").submit();
		}
	});
}

function checkFileType(file1, file2, file3) {
	var format1 = file1.split(".");
	var format2 = file2.split(".");
	var format3 = file3.split(".");
	
	if (format1.indexOf("xlsx") > -1 && format2.indexOf("xlsx") > -1 && format3.indexOf("xlsx") > -1) {
		return true;
	} else {
		return false;
	}
}



	function getSubjectNames(no){
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/selectSubjectNames",
			type:"post",
			data:{tno : no},
			success:function(result){
				if(result.length > 0){
					$("#subjectNameList").html( $("<option value='0' selected='selected'>").html("과목을 선택해주세요.") );
					for(var i=0; i<result.length; i++){
						var $option = $("<option value="+(i+1)+">").html(result[i]);
						$("#subjectNameList").append($option);
					}
				}
			},
			error:function(result){
				console.log(result);
			}
		});
	}//getSubjectNames
	
	function setTestNameList(){
		selectAllTestName("${pageContext.request.contextPath}/admin/selectAllTestName").done(function(data){
			console.log("selectAllTestName()의 데이터 ...............");
			console.log(data);
			
			if(data.length <= 0){
				//$(".testname-list-box").find("label").html("현재 등록된 기출문제가 없습니다");
				$(".testname-list-box").find("select").css("display", "none");
			}else{
				$(".testname-list-box").find("label").html("현재 등록된 기출문제");
				$("#testNameList").css("display", "inline-block");
				
				var $option = "<option selected='selected' value='0'>기출문제를 선택해주세요.</option>";
				for(var i = 0; i < data.length; i++){
					$option += "<option value="+data[i].tno+">"
								+ "<span>"+data[i].tname+"</span>"
								+ "<span>"+data[i].tdate+"</span>"
								+ "</option>";
				}
				$("#testNameList").html($option);
			}
		});
	}//setTestNameList
	
	function insertTestName(){
		var name = $("#tname").val();
		var date = $("#tdate").val();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/insertTestName",
			type:"post",
			data:{tname: name, tdate: date},
			success:function(result){
				if(result == "success"){
					alert("자격증이 등록되었습니다.");
					selectAllTestName();
					$("#btnMore").click();
				}
			}
		});
	}//insertTestName
</script>
<script src="${pageContext.request.contextPath}/resources/js/insert-exam.js"></script>
