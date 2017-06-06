<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.section h1, .section label{
	color:#eee;
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

</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>기출문제 등록</h1>
			<div class="inner-section">
				<div class="testname-box">
					<h3>기출문제 선택</h3>
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
$(function(){
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
