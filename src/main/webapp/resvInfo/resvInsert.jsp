<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Resv, kr.ac.kopo.kopo08.service.ResvService, kr.ac.kopo.kopo08.service.ResvServiceImpl" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String date = request.getParameter("date");
	String room = request.getParameter("room");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String addr = request.getParameter("addr");
	String inName = request.getParameter("inName");
	String comment = request.getParameter("comment");
	if (addr == null) addr = "";
	if (comment == null) comment = "";
	int roomNumber = Integer.parseInt(room);
	
	ResvService resvService = ResvServiceImpl.getInstance();
	Resv resv = new Resv();
	
	resv.setName(name);
	resv.setRoom(roomNumber);
	resv.setDate(date);
	resv.setTel(tel);
	resv.setAddr(addr);
	resv.setInName(inName);
	resv.setComment(comment);
	resvService.create(resv);
	
	response.sendRedirect("./resvView.jsp?room=" + room + "&date=" + date );
	%>
</body>
</html>