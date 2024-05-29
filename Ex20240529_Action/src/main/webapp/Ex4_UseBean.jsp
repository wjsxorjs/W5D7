<%@page import="pm.vo.DataVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex4_UseBean</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
	/*
	DataVO dvo = new DataVO();
	String mid = request.getParameter("mid");
	dvo.setMid(mid);
	*/
	
%>

<jsp:useBean id="vo" class="pm.vo.DataVO" />

<jsp:setProperty name="vo" property="*" />
<!--
	setM_id(mid)를 부르는 것. 이때, mid는 파라미터이다.
	파라미터와 프로퍼티의 이름이 같다면 param을 생략해주어도 된다.
-->

<h2><%=vo.getMid() %></h2>
<h2><%=vo.getMname() %></h2>
<h2><%=vo.getMpw() %></h2>




</body>

</html>