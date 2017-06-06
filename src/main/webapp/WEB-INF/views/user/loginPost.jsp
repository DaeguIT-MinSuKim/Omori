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
	title:"아이디가 존재하지 않습니다!",
	type:"error"
}, function(){
	self.location = "${pageContext.request.contextPath}/user/login";	
});

</script>
</body>
</html>