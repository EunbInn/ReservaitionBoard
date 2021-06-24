<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Resv, kr.ac.kopo.kopo08.service.ResvService, kr.ac.kopo.kopo08.service.ResvServiceImpl" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="./navigation.css">
<link rel="stylesheet" type="text/css" href="./resvPage.css">
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
				String date = request.getParameter("date");
				String room = request.getParameter("room");
				int roomNumber = Integer.parseInt(room);
				String roomName = "";
				
				if (roomNumber == 1) {
					roomName = "Suite(스위트)";
				} else if (roomNumber == 2) {
					roomName = "Delux(디럭스)";
				} else if (roomNumber == 3) {
					roomName = "Delux Double(디럭스 더블)";
				}
				
				ResvService resvService = ResvServiceImpl.getInstance();
				String currentMonth = resvService.currentMonth();

				%>
				<br>
				<h1 id="header">Reservation</h1>
				<form method="POST">
					<table>
						<tr>
							<th>예약일</th>
							<td><input type="text" name="date" id="date" value="<%=date %>" readonly></td>
						</tr>
						<tr>
							<th>예약실</th>
							<td><input type="text" name="room" id="room" value="<%=room %>" readonly>: <%=roomName %></td>
						</tr>
						<tr>
							<th>예약자명</th>
							<td><input type="text" name="name" id="name" maxlength="20" placeholder="성함을 입력해주세요"></td>
						</tr>
						<tr>
							<th>예약자 전화번호</th>
							<td><input type="text" name="tel" id="tel" maxlength="13" placeholder="-없이 숫자만 입력"></td>
						</tr>
						<tr>
							<th>예약자 주소</th>
							<td><input type="text" name="addr" id="addr" maxlength="50" placeholder="읍면동까지만 입력"></td>
						</tr>
						<tr>
							<th>입금자명</th>
							<td><input type="text" name="inName" id="inName" maxlength="20" placeholder="입금자명"></td>
						</tr>
						<tr>
							<th>남기실 말</th>
							<td><textarea name="comment" id="comment"></textarea></td>
						</tr>
					</table>
					<br>
					<input type="button" id="back" value="뒤로가기" onclick="location.href='./reservation.jsp'">
					<button id="submit" formaction="./resvInsert.jsp">예약하기</button>
				</form>				
			</div>
		</section>
	</div>
	<script>
		function filter(str) {
			var filter = /^[가-힣a-zA-Z\s]{2,}$/;
			if (filter.test(str)) {
				return true;
			} else {
				return false;
			}
		}
	
		$(function() {
			$(document).on('keyup', '#tel', function() { 
				$(this).val( 
						$(this).val().replace(/[^0-9]/g, "")
						.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3")
						.replace("--", "-") ); });

		});
		
		$(function() {
			$('#submit').click(function() {
				var name = $('#name').val();
				var inName = $('#inName').val();
				var tel = $('#tel').val();
				
				if ($.trim(name) == "") {
					alert('예약자 명을 입력해주세요');
					return false;
				}
				
				if(!filter(name)) {
					alert('이름은 공백 포함 20자 내로 작성해주세요');
					return false;
				}
				
				if ($.trim(inName) == "") {
					alert('입금자명을 입력해주세요');
					return false;
				}
				
				if(!filter(inName)) {
					alert('입금자명은 공백 포함 20자 내로 작성해주세요');
					return false;
				}
				
				if (tel.length < 11) {
					alert('전화번호를 입력해주세요');
					return false;
				}
				
				if ($.trim(name) != "" && tel.length > 11 != "" && filter(name) &&
						$.trim(inName) != "" && filter(inName)) {
					return true;
				}
			});
		});
	</script>
</body>
</html>