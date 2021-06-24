<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Resv, kr.ac.kopo.kopo08.service.ResvService, kr.ac.kopo.kopo08.service.ResvServiceImpl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약확인</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="./navigation.css">
<link rel="stylesheet" type="text/css" href="./resvPage.css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String date = request.getParameter("date");
	String room = request.getParameter("room");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	
	int roomNumber = 0;
	String month = "";
	String roomName = "";
	
	ResvService resvService = ResvServiceImpl.getInstance();
	Resv resv = null;
	if (name == null) {
		roomNumber = Integer.parseInt(room);
		month = date.split("-")[0] + "-" + date.split("-")[1];
		resv = resvService.selectOne(date, roomNumber);
	} else {
		resv = resvService.selectOne(date, name, tel);
		roomNumber = resv.getRoom();
		month = resvService.currentMonth();
	}
	
	if (roomNumber == 1) {
		roomName = "Suite(스위트)";
	} else if (roomNumber == 2) {
		roomName = "Delux(디럭스)";
	} else if (roomNumber == 3) {
		roomName = "Delux Double(디럭스 더블)";
	}
	
	%>
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
				<br>
				<h1 id="header">Reservation</h1>
				<c:set var="resv" value="<%=resv %>" />
				<c:choose>
					<c:when test="${resv.name==null}">
						<table>
							<tr>
								<th>예약자 정보와 일치하는 내용이 없습니다</th>
							</tr>
						</table>
						<br>
						<input type="button" id="back" value="돌아가기" onclick="location.href='./reservation.jsp?'">
						<button id="submit" onclick="location.href='./resvConfirm.html'">다시조회</button>
					</c:when>
					<c:otherwise>
						<form method="POST">
							<table>
								<tr>
									<th>예약일</th>
									<td><input type="text" name="date" id="date" value="<%=date %>" readonly></td>
								</tr>
								<tr>
									<th>예약실</th>
									<td><input type="text" name="room" id="room" value="<%=roomNumber %>" readonly>: <%=roomName %></td>
								</tr>
								<tr>
									<th>예약신청일</th>
									<td><%=resv.getWriteDate() %></td>
								</tr>
								<tr>
									<th>예약자명</th>
									<td><%=resv.getName() %></td>
								</tr>
								<tr>
									<th>예약자 전화번호</th>
									<td><%=resv.getTel() %></td>
								</tr>
								<tr>
									<th>예약자 주소</th>
									<td><%=resv.getAddr() %></td>
								</tr>
								<tr>
									<th>입금자명</th>
									<td><%=resv.getInName() %></td>
								</tr>
								<tr>
									<th>남기실 말</th>
									<td><%=resv.getComment() %></td>
								</tr>
							</table>
							<br>
							<input type="button" id="back" value="확인" onclick="location.href='./reservation.jsp?month=<%=month %>'">
							<button id="submit" formaction="./resvCancel.jsp">예약취소</button>
						</form>
					</c:otherwise>
				</c:choose>
			</div>
		</section>
	</div>
	<script>
		$(function() {
			$('#submit').click(function() {
				if (confirm('예약을 쥐소 하시겠습니까?') == true) {
					return true;
				} else {
					return false;
				}
			})
		})
	</script>
</body>
</html>