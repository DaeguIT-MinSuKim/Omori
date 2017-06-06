<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="item" items="${imgList}">
	파일이름 : ${item.imgsource}	<br>
	<img src="${pageContext.request.contextPath}/resources/upload/${item.imgsource}" width="500px" /><br />
</c:forEach><br />

<!-- tno, tq_subject, tq_subject_no, tq_small_no, tq_question, tq_answer, tq_per, tq_image -->
tno : ${TestQuestionVO.testName.tno} <br />
tq_subject : ${TestQuestionVO.tq_subject} <br />
tq_subject_no : ${TestQuestionVO.tq_subject_no} <br />
tq_small_no : ${TestQuestionVO.tq_small_no} <br />
tq_question : ${TestQuestionVO.tq_question} <br />
tq_answer : ${TestQuestionVO.tq_answer} <br />
tq_per : ${TestQuestionVO.tq_per} <br />

<c:forEach var="item" items="${exampleList}">
	${item.question.tq_no } <br />
	${item.te_small_no } <br />
	${item.te_content } <br /><br />
</c:forEach>

</body>
</html>