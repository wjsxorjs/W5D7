<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 요청시 한글처리
	request.setCharacterEncoding("utf-8");

	// 파라미터들 받기
	String name = request.getParameter("name"); // 이름
	String year = request.getParameter("year"); // 생년


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex2_Forward2</title>
</head>
<body>
<%
	// 파라미터 값들 중 하나라도 받지 못했다면 앞 페이지로 이동
	if(name == null || year == null){
		// response.sendRedirect("Ex2_Forward.jsp");
		
%>
		<jsp:forward page="Ex2_Forward.jsp" />
<%
		
	} else {
		// 파라미터를 모두 받은 경우
		// 나이 구하기
		// Date now = new Date(System.currentTimeMillis());
		// 년-월-일 형식으로 나온다.
		Calendar now = Calendar.getInstance();
		int cYear = now.get(Calendar.YEAR); // 년
		// int cMonth = now.get(Calendar.MONTH)+1; // 월
		// int cDate = now.get(Calendar.DAY_OF_MONTH); // 일
		
		int bYear = Integer.parseInt(year);
		int age = cYear - bYear;
		
		//바로 앞 페이지로 Forward시킨다.
%>
		<jsp:forward page="Ex2_Forward.jsp" >
			<jsp:param value="<%=age %>" name="age"/>
		</jsp:forward>
<%
	}
%>
</body>
</html>