<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
</head>
<body>
<script>
swal({ //plugin
	title:"아이디나 비밀번호를 확인하여주십시오",
	type:"error"
}, function(){
	self.location = "${pageContext.request.contextPath}/user/login";	
});

</script>
</body>
</html>