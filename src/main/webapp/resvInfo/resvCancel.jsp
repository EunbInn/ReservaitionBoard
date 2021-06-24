<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Resv, kr.ac.kopo.kopo08.service.ResvService, kr.ac.kopo.kopo08.service.ResvServiceImpl" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약취소</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet" type="text/css" href="./navigation.css">
<link rel="stylesheet" type="text/css" href="./resvPage.css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String date = request.getParameter("date");
	String room = request.getParameter("room");
	int roomNumber = Integer.parseInt(room);
	
	ResvService resvService = ResvServiceImpl.getInstance();
	Resv resv = new Resv();
	
	resv.setDate(date);
	resv.setRoom(roomNumber);
	
	resvService.delete(resv);
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
				<table>
					<tr>
						<th>예약이 정상적으로 취소되었습니다</th>
					</tr>
				</table>
				<br>
				<input type="button" id="back" value="확인" onclick="location.href='./reservation.jsp'">
			</div>
		</section>
	</div>
</body>
</html>