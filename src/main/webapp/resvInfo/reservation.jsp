<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Resv, kr.ac.kopo.kopo08.service.ResvService, kr.ac.kopo.kopo08.service.ResvServiceImpl, kr.ac.kopo.kopo08.dto.GatherResv" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet" type="text/css" href="./navigation.css">
<style>
	#box {
		width: 900px;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}

	#content-wrap {
		width: 100%;
		display: flex;
		flex-direction: column;
		justify-contents: center;
		text-align: center;
		align-items: center;
	}

	#header {
		color: rgb(80, 80, 80);
	}
	
	table {
		border: 1px solid rgb(120, 120, 120);
		border-collapse: collapse;
		width: 800px;
	}	
	
	th {
		color: rgb(80, 80, 80);
	}
	
	.room {
		width: 210px;
	}
</style>
</head>
<body>
	<div id="box">
		<!--gnu-->
		<div id="nav-box">
			<nav class="gnb">
				<ul class="nav-container">
					<li class="nav-item"><a href="../index.html"><i class="fas fa-home"></i></a></li>
					<li class="nav-item checked"><a href="./reservation.jsp">Reservation</a></li>
					<li class="nav-item"><a href="./showRooms/showRooms.jsp">Rooms</a></li>
				</ul>
			</nav>
		</div>
		<section>
			<div id="content-wrap">
				<h1 id="header">Reservation</h1>
				<hr>
				<%
				request.setCharacterEncoding("UTF-8");
				String selectMonth = request.getParameter("month");
				
				ResvService resvService = ResvServiceImpl.getInstance();
				List<GatherResv> monthReservation = resvService.monthReservation(selectMonth);
				%>
				<form method="POST">
					<input type="month" id="month" name="month">
					<button formaction="./reservation.jsp">조회</button>
				</form>
				<br>
				<table border="1px solid rgb(120, 120, 120)">
					<tr>
						<th>날짜</th>
						<th class="room">Suite</th>
						<th class="room">Delux</th>
						<th class="room">Delux Double</th>
					</tr>
					<c:set var="resvLists" value="<%=monthReservation %>"/>
					<c:forEach var="resvList" items="${resvLists}" varStatus="status">
						<c:set var="room1" value="${resvList.room1}" />
						<c:set var="room2" value="${resvList.room2}" />
						<c:set var="room3" value="${resvList.room3}" />
						<tr>
							<td><c:out value="${resvList.date}" /></td>
							<td>
							<c:choose>
								<c:when test="${room1.name eq '예약가능'}" >
									<a href="./reservPage.jsp?date=${resvList.date}&room=1" class=""><c:out value="${room1.name}" /></a>
								</c:when>
								<c:otherwise>
									<a href="./reservView.jsp?date=${resvList.date}&room=1" disable><c:out value="${room1.name}" /></a>
								</c:otherwise>
							</c:choose>
							</td>
							<td>
							<c:choose>
								<c:when test="${room2.name eq '예약가능'}" >
									<a href="./reservPage.jsp?date=${resvList.date}&room=2"><c:out value="${room2.name}" /></a>
								</c:when>
								<c:otherwise>
									<a href="./reservView.jsp?date=${resvList.date}&room=2" disable><c:out value="${room2.name}" /></a>
								</c:otherwise>
							</c:choose>
							</td>
							<td>
							<c:choose>
								<c:when test="${room3.name eq '예약가능'}" >
									<a href="./reservPage.jsp?date=${resvList.date}&room=3"><c:out value="${room3.name}" /></a>
								</c:when>
								<c:otherwise>
									<a href="./reservView.jsp?date=${resvList.date}&room=3" disable><c:out value="${room3.name}" /></a>
								</c:otherwise>
							</c:choose>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	</div>
</body>
</html>