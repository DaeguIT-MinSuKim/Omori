/**
 * 
 */
/*수정 팝업 띄우는 버튼 클릭*/
$(document).on("click", ".btnUpdatePopup", function(){
	//과목 불러오기
	var $option = "<option value='데이터베이스'>데이터베이스</option>"
		+ "<option value='전자계산기구조'>전자계산기구조</option>"
		+ "<option value='운영체제'>운영체제</option>"
		+ "<option value='소프트웨어공학'>소프트웨어공학</option>"
		+ "<option value='데이터통신'>데이터통신</option>";
	
	if($("#testName").text().indexOf("정보처리기사") > -1){
		$(".edit-que-ex-popup").find("#subjectList").html($option);
	}
	var tqsubject = $(this).parents("tr.question").attr("tqsubject");
	$("#subjectList").find("option").each(function(i, obj) {
		if($(obj).text() == tqsubject){
			$(obj).attr("selected", "selected");
		}
	});
	
	//정답 불러오기
	var tqanswer = $(this).parents("tr.question").attr("tqanswer");
	$(".edit-que-ex-popup").find(".answer-box span").each(function(i, obj){
		$(obj).removeClass("selected-answer");
		if($(obj).text() == tqanswer){
			$(obj).addClass("selected-answer");
		}
	});
	$(".edit-que-ex-popup").find(".answer-box").find("span").click(function() {
		$(".edit-que-ex-popup").find(".answer-box").find("span").removeClass("selected-answer");
		$(this).addClass("selected-answer");
	});
	
	//문제 내용 불러오기
	var question = $(this).parent("td").find("span").text();
	$(".edit-que-ex-popup").find("#edit-question").val(question);
	
	//문제 번호 불러오기
	var tqno = $(this).parents("tr.question").attr("tqno");
	var tqsmallno = $(this).parents("tr.question").attr("tqsmallno");
	$(".edit-que-ex-popup").find("#edit-small-no").html(tqsmallno);
	$(".edit-que-ex-popup").find("#edit-small-no").attr("tqno", tqno);
	
	//이미지가 존재하면 이미지를 보여주고 input file창 숨기기
	var dbSrc = "";
	$(".edit-que-ex-popup").find(".preview").html("");
	$("#add-img").removeAttr("preImgDel");
	$(".image").each(function(i, obj) {
		if($(obj).attr("tqno") == tqno){
			if($(obj).find("img").length > 0){
				var src = $(obj).find("img").attr("src");
				dbSrc = src;
				$(".edit-que-ex-popup").find(".preview").append("<img src='"+src+"'>");
				$(".edit-que-ex-popup").find(".preview").append("<a href=''>X</a>");
			}
		}
	});
	//새로운 이미지 추가
	$("#add-img").change(function() {
		$(".preview").html("");
		var files = document.getElementById("add-img").files;
		
		if( files != null){
			//이미지 파일이 아니면 리턴
			if( (files[0].type).indexOf("image") < 0 ){
				swal({
					title:"이미지 파일만 등록해주세요!",
					confirmButtonText:"확인"
				});
				return false;
			}
			
			//이미지 태그 생성
			var file = files[0];
			var reader = new FileReader();
			reader.onload = function (e) {
				var $img = $("<img>").attr("src", e.target.result);
				var $a = $("<a>").html("X");
				$(".preview").append($img);
				$(".preview").append($a);
	        }
			reader.readAsDataURL(file);
		}
	});
	//이미지가 존재할 때 이미지 옆 X버튼을 클릭하면
	$(document).on("click", ".preview a", function(e) {
		e.preventDefault();
		
		var src = $(this).parent(".preview").find("img").attr("src");
		
		swal({
			title:"보기 이미지를 삭제하시겠습니까?",
			showCancelButton: true,
			cancelButtonText: "취소",
			confirmButtonText:"삭제",
		},function(isConfirm){
			if(isConfirm){
				$(".preview").html("");
				$("#add-img").val("");
				//db에 저장된 이미지와 현재 삭제할 이미지의 src가 같으면 #add-img에 삭제할 src 추가
				if(src == dbSrc){
					src = src.replace("/omori/resources/upload/", "");
					$("#add-img").attr("preImgDel", src);
				}
			}
		});
	});
	
	//보기 내용
	var contents = new Array();
	var tenoList = new Array();
	var index = 0;
	$(".example").each(function(i, obj){
		if($(obj).attr("tqno") == tqno){
			contents[index] = $(obj).find("td").last().text().substring(1);
			tenoList[index] = $(obj).attr("teno");
			index++;
		}
	});
	$(".edit-que-ex-popup").find("#example01").val(contents[0]);
	$(".edit-que-ex-popup").find("#example01").attr("teno", tenoList[0]);
	$(".edit-que-ex-popup").find("#example02").val(contents[1]);
	$(".edit-que-ex-popup").find("#example02").attr("teno", tenoList[1]);
	$(".edit-que-ex-popup").find("#example03").val(contents[2]);
	$(".edit-que-ex-popup").find("#example03").attr("teno", tenoList[2]);
	$(".edit-que-ex-popup").find("#example04").val(contents[3]);
	$(".edit-que-ex-popup").find("#example04").attr("teno", tenoList[3]);
	
	//팝업 띄우기
	$(".edit-que-ex-popup").fadeIn("fast");
});

/*수정 팝업창에서 수정버튼클릭*/
$("#btnUpQueAndEx").click(function(e){
	e.preventDefault();
	var tqsmallno = $("#edit-small-no").text();
	swal({
		title:"문제 "+tqsmallno+"번과 보기를 수정하시겠습니까?",
		showCancelButton:true,
		cancelButtonText: "취소",
		confirmButtonText: "수정",
		closeOnConfirm: false
	}, function(isConfirm){
		if(isConfirm){
			updateQueAndExAjax();
		}
	});
});

/*팝업창 X버튼 클릭*/
$(".login-close").find("a").click(function(e){
	e.preventDefault();
	$(".login-container").fadeOut("fast");
});