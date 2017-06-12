<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.testname-add-box{
	display:none;
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
	padding:20px;
}
.how-to-name img, .how-to-question img, .how-to-example img{
	float:left;
	margin-right:12px;
	width:500px;
}
.how-to-name ul, .how-to-question ul{
	float:right;
	width:700px;
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
.clear{
	clear:both;
	width:100%;
	padding:20px;
}
.clear span{
	font-size:18px;
	color:#ff6666;
	display:block;
	padding-top:20px;
}
.upload-file{
	clear:both;
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
						<h3>기출문제 등록 방법</h3>
						<div class="how-to-name">
							<img src="${pageContext.request.contextPath}/resources/images/ex_name.png" alt="" />
							<ul>
								<li class='down-li'>
									<img src='${pageContext.request.contextPath}/resources/images/ic-download.png' class='icon-down'>
									<a href="${pageContext.request.contextPath}/admin/downloadExcel/name">testname.xlsx</a>
								</li>
								<li>
									1. 기출문제번호<br />
									<span>※ 기출문제번호는 기출문문제의 고유번호이기 때문에 모두 상이해야합니다</span>
								</li>
								<li>
									2. 기출문제명 : 기출문제명 - 시행년도 - 회차 순으로 입력해주세요 <br />
									<span>※  기출문제 목록을 가져올 때 이름순으로 가져오게 됩니다</span>
								</li>
								<li>
									3. 시험날짜 : 시험 시행 날짜
								</li>
							</ul>
						</div>
						<div class="clear"></div>
						<div class="how-to-question">
							<img src="${pageContext.request.contextPath}/resources/images/ex_question.gif" alt="" />
							<ul>
								<li class='down-li'>
									<img src='${pageContext.request.contextPath}/resources/images/ic-download.png' class='icon-down'>
									<a href="${pageContext.request.contextPath}/admin/downloadExcel/question">testquestion.xlsx</a>
								</li>
								<li>
									1. 문제고유번호<br />
									<span>
										※ 각 문제의 고유번호이기 때문에 모두 상이해야합니다<br />
										&nbsp;&nbsp;&nbsp;&nbsp;기출문제의 문제를 등록할 때 고유번호의 마지막 번호가 100이었다면 다음 기출문제의 문제의<br /> 
										&nbsp;&nbsp;&nbsp;&nbsp;고유번호는 101이 됩니다
									</span>
								</li>
								<li>
									2. 기출문제번호 : 등록하고자 하는 기출문제에 대응하는 기출문제번호
								</li>
								<li>
									3. 과목명 : 기출문제의 과목명
								</li>
								<li>
									4. 문제번호 : 각 문제번호<br />
									<span>
										※ 문제고유번호와 다릅니다<br />
										&nbsp;&nbsp;&nbsp;&nbsp;기출문제의 각 문제의 번호입니다
									</span>
								</li>
							</ul>
						</div>
						<div class="clear"></div>
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
						<div class="clear">
							<span>※ 각 문제에 해당하는 이미지는 문제 등록 후 나오는 리스트에서 등록하시면 됩니다</span>
						</div>
					</div>
					<div class="upload-file">
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
					
					<div class="testname-list-box">
						<label></label>
						<select id="testNameList"></select>	
						<a href="" id="btnMore">자격증을 더 등록하려면 여기를 클릭하세요</a>
					</div>
					<div class="testname-add-box">
						<label for="">자격증의 이름과 출제년도를 선택해주세요</label><br />
						<input type="text" id="tname" placeholder="ex)정보처리산업기사" required="required"/>
						<input type="date" id="tdate" required="required"/>
						<button>등록</button>
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
<script>

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

$(function(){
	$("#btnUpload").click(function(e){
		e.preventDefault();
		check();
	});
	
	/* 자격증 리스트 */
	setTestNameList();
	
	/* 자격증을 더 등록하려면 여기를 클릭하세요 */
	$("#btnMore").click(function(e){
		e.preventDefault();
		$(".testname-add-box").slideToggle("slow");
	});
	
	/* testname 등록 */
	$(".testname-add-box").find("button").click(function(e){
		e.preventDefault();
		
		insertTestName();
	});
	
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
				$(".testname-list-box").find("label").html("현재 등록된 기출문제가 없습니다");
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
