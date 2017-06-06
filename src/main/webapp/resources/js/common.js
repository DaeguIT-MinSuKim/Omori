$(function(){
	
});

function initInput( $input ){
	$input.val("");
}

function selectAllTestName(path){
	return $.ajax({
		url:path,
		type:"post",
		asynce:false,
		success:function(result){
			
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}

function selectOneTestName(path, no){
	return $.ajax({
		url:path,
		type:"post",
		data:{tno : no},
		success:function(result){
			
		},
		error:function(e){
			alert("에러가 발생하였습니다.");
		}
	});
}
