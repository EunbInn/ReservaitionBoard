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
<link rel="stylesheet" type="text/css" href="./reservation.css">
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
				<%
				request.setCharacterEncoding("UTF-8");
				String selectMonth = request.getParameter("month");
				
				ResvService resvService = ResvServiceImpl.getInstance();
				List<GatherResv> monthReservation = resvService.monthReservation(selectMonth);
				String currentMonth = resvService.currentMonth();
				
				if (selectMonth == null) selectMonth = currentMonth;
				%>
				<br>
				<h1 id="header">Reservation</h1>
				<form method="POST">
					<input type="month" id="month" name="month" min="<%=currentMonth %>" value="<%=selectMonth%>">
					<button id="submit" formaction="./reservation.jsp">조회</button>
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
							
							<c:choose>
								<c:when test="${room1.name=='예약가능'}" >
								<td class="available">
									<a href="./reservPage.jsp?date=${resvList.date}&room=1"><i class="fas fa-unlock"></i> <c:out value="${room1.name}" /></a>
								</td>
								</c:when>
								<c:otherwise>
								<td class="notAvailable">
									<a><i class="fas fa-lock"></i> <c:out value="예약불가" /></a>
								</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${room2.name=='예약가능'}" >
								<td class="available">
									<a href="./reservPage.jsp?date=${resvList.date}&room=2"><i class="fas fa-unlock"></i> <c:out value="${room2.name}" /></a>
								</td>
								</c:when>
								<c:otherwise>
								<td class="notAvailable">
									<a><i class="fas fa-lock"></i> <c:out value="예약불가" /></a>
								</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${room3.name=='예약가능'}" >
								<td class="available">
									<a href="./reservPage.jsp?date=${resvList.date}&room=3"><i class="fas fa-unlock"></i> <c:out value="${room3.name}" /></a>
								</td>
								</c:when>
								<c:otherwise>
								<td class="notAvailable">
									<a><i class="fas fa-lock"></i> <c:out value="예약불가" /></a>
								</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
				<br>
				<button id="confirmReservation" onclick="location.href='resvConfirm.html'">예약 조회</button>
			</div>
		</section>
	</div>
</body>
</html>