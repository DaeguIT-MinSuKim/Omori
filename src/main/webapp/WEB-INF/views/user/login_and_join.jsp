<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="login-page">
	<div class="login-close">
		<a href=""><img src="${pageContext.request.contextPath}/resources/images/ic-close-button.png" alt="" /></a>
	</div>
	<div class="form">
		<form class="register-form" method="post" action="${pageContext.request.contextPath}/user/join">
			<h2 class="form-title">회원가입</h2>
			<input type="text" placeholder="아이디" name='uid' id="uid"/> 
			<input type="password" placeholder="비밀번호" name='upw' id="upw"/> 
			<input type="text" placeholder="이메일" name='uemail'id="uemail"/>
			<button>가입하기</button>
			<p class="message">
				이미 가입하셨나요? <a href="#">로그인</a>
			</p>
		</form>
		<form class="login-form" method="post" action="${pageContext.request.contextPath}/user/loginPost">
			<h2 class="form-title">로그인</h2>
			<input type="text" placeholder="아이디" name='uid' id="uid"/> 
			<input type="password" placeholder="비밀번호" name='upw' id="upw"/>
			<button>로그인</button>
			<p class="message">
				아이디가 없으신가요? <a href="#">회원가입</a>
			</p>
		</form>
	</div>
</div>
<script>
	/* 회원가입 */
	$(".register-form button").click(function(e){
		e.preventDefault();
		
		var id = $(".register-form").find("input#uid").val();
		var pw = $(".register-form").find("input#upw").val();
		var email = $(".register-form").find("input#uemail").val();
		
		if(id == "" || pw == "" || email == ""){
			swal("모든 항목을 채워주세요!");
			return false;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/user/join",
			type:"post",
			data:{uid:id, upw:pw, uemail:email},
			success:function(result){
				if(result == "success"){
					swal("성공적으로 가입되었습니다"); //plugin
					
					$('#btnLogin').click();
				}else if(result == "fail"){
					swal("이미 존재하는 아이디입니다"); //plugin
				}
			},
			error:function(result){
				swal("이미 존재하는 아이디입니다"); //plugin
			}
		});
		
		allInputInit(); //method
	});
	/* ........................................................ */
	
	/* 로그인 폼 이벤트 */
	$('.login-page .message a').click(function() {
		$('form').animate({
			height : "toggle",
			opacity : "toggle"
		}, "slow", function(){
			allInputInit();
		});
	});
	
	$('.login-page .login-close a').click(function(e){
		e.preventDefault();
		$('.login-container').fadeOut("slow", function(){
			allInputInit();
		});
	});
	/* ............................................. */
	
	
	/* 함수 */
	function allInputInit(){
		initInput( $(".register-form input#uid") ); //call method
		initInput( $(".register-form input#upw") );
		initInput( $(".register-form input#uemail") );
		initInput( $(".login-form input#uid") );
		initInput( $(".login-form input#upw") );
	}
	/* ............................................. */
</script>