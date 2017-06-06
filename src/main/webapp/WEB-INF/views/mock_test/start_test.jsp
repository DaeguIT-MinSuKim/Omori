<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- alert -->
<script src="${pageContext.request.contextPath}/resources/alert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/alert/dist/sweetalert.css">
<style>
.section h1{
	color:#eee;
}
.sweet-alert{
	width:400px !important;
	top:40% !important;
	margin-left: -217px !important;
}
.mocktest-box{
	width:84%;
	float:left;
}
.omr-box{
	width:15%;
	float:right;
}
/* ............ */
/* table 		*/
/* ............ */
.added-table{
	/* display:none; */
}
.table{
	width:100%;
	border:2px solid #999;
	background:rgba(240,240,240,1);
}
.table td{
	font-family: "돋움";
}
.table #testName{
	padding-top:20px;
	padding-bottom:20px;
	text-align: center;
	font-weight:bold;
	font-size:20px;
	color:#222;
	border-bottom:2px solid #999;
	
}
.table td.subject{
	color:#3333cc;
	font-weight: bold;
	font-size:18px;
	text-align: center;
	padding-top:30px;
}
.table #paging{
	padding-top:20px;
	padding-bottom:20px;
	text-align: left;
	border-top:2px solid #999;
}
.table tr.question{
	vertical-align: top;
	font-weight: bold;
	color:#303030;
}
.table tr.question td:FIRST-CHILD{
	text-align: left;
}

.table tr.question td{
	padding-top:30px;
	padding-bottom:10px;
	font-size:14px;
}
.table tr.example td{
	padding:5px 5px;
}
.table tr.example a{
	line-height:22px;
	color:#333;
	font-size:12px;
}
.table tr.example a:HOVER{
	color:#cc0000;
}
.table tr.example span.te_small_no{
	border: 1px solid #cc0000;
    width: 20px;
    height: 20px;
    margin-right: 10px;
    padding:2px 6px;
}
.table-left, .table-right{
	width:500px;
	vertical-align: top;
	padding-bottom:30px;
}
.table-left {
	padding-left:12px;
	padding-right:6px;
	border-right:2px solid #999;
}
.table-right{
	padding-right:12px;
	padding-left:6px;
}

/* 보기 클릭 */
.answer-selected{
	color:#CC0000 !important;
	font-weight:bold;
}

/* .omr-box */
.omr-box .table{
	width:100%;
	border-collapse: collapse;
}
.omr-box .table td{
	width:25px;
	text-align:center;
	padding:7px 5px;
	border:1px solid #999;
}
.omr-box .table td a{
	color:#333;
}
.omr-box .table td:FIRST-CHILD{
	color:#303030;
	font-weight: bold;
}
.omr-box #time-zone, #btnSendAnswer{
	color:#303030;
	font-size:20px;
	font-weight:bold;
	padding:20px 0;
}
.omr-box #time-zone{
	color:#ff3333;
}
</style>
<div class="wrapper">
	<%@ include file="../include/header.jsp" %>
	<section class="section">
		<div class="width1400">
			<h1>모의고사</h1>
			<div class="inner-section">
				<div class="mocktest-box">
					<table class='table'>
						<tr>
							<td colspan="2" id="testName">${testName.tname} <small>(${testName.tdate})</small></td>
						</tr>
						<c:forEach var="question" items="${questionList}" varStatus="s">
							<c:if test="${s.index == 0 }">
								<tr class="first-table">
									<td class="table-left">
										<table></table>
									</td>
									<td class="table-right">
										<table></table>
									</td>
								</tr>
							</c:if>
							<c:if test="${s.index % 10 == 0}">
								<tr class="added-table">
									<td class="table-left">
										<table></table>
									</td>
									<td class="table-right">
										<table></table>
									</td>
								</tr>
							</c:if>
						</c:forEach>
						<tr>
							<td colspan="2" id="paging"></td>
						</tr>
					</table>
				</div>
				<div class="omr-box">
					<table class="table">
						<tr>
							<td colspan="5" id="time-zone">00 : 00 : 00</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
</div>
<script>
	var trtd = "";
</script>
<c:forEach var="question" items="${questionList}" varStatus="s">
	<c:if test="${s.index < 5}">
		<script>
			trtd += "<tr>"
					+ 	"<td class='subject' colspan='2'>"+"${question.tq_subject}"+"</td>"
					+ "</tr>"
					+ "<tr class='question'>"
					+ 	"<td>${question.tq_small_no}. </td>"
					+ 	"<td>${question.tq_question}</td>"
					+ "</tr>";
		</script>
		
		<c:if test="${question.imageList.size() > 0 }">
			<c:forEach var="image" items="${question.imageList}">
				<script>
					trtd += "<tr>"
							+ 	"<td></td>"
							+	"<td><img src='${pageContext.request.contextPath}/resources/upload/"+"${image.imgsource}"+"' alt='' /></td>"
							+ "</tr>";
				</script>
			</c:forEach>
		</c:if>
		<c:forEach var="example" items="${question.exampleList}">
			<script>
				console.log("${example.te_content}");
				trtd += "<tr class='example'>"
						+ 	"<td></td>"
						+ 	"<td><a href=''>"
						+ 		"<span class='te_small_no'>"+"${example.te_small_no }"+"</span>"
						+		""
						+	"</a></td>"
						+ "</tr>";
						
				alert(x );
			</script>
		</c:forEach>
		<script>
			$(function(){
				$(".first-table").find(".table-left").find("table").html(trtd);
			});
		</script>
	</c:if>
</c:forEach>