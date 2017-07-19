/**
 * 
 */
/*------------------------- 
	이전, 다음버튼 클릭했을 때
-------------------------*/
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

/*----------------------------------
	보기번호 클릭하면 색깔이 빨강색으로 바뀜 
----------------------------------*/
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

/*-----------------
	타이머 설정 함수
-----------------*/
function setTimer(tname){
	if(tname.indexOf("정보처리기사") > -1){
		var hour = 0;
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

/*-----------------------
	답안제출버튼클릭했을 때 
-----------------------*/
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
			}else{
				
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
			}else{
				
			}
		});
	}
	
});