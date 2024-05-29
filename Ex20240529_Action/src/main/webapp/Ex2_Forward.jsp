<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 요청시 한글처리
	request.setCharacterEncoding("utf-8");

	// 파라미터들 받기
	String name = request.getParameter("name"); // 이름
	String year = request.getParameter("year"); // 생년
	String age = request.getParameter("age"); // 나이


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex2_Forward</title>
</head>
<body>
<%
	if(name == null || year == null || age == null){
%>
		<form action="Ex2_Forward2.jsp" method="post">
			<label>이름: </label>
			<input type="text" name="name" id="name" /><br/>
			<label>생년: </label>
			<input type="text" name="year" id="year" placeholder="2000"/><br/>
			<button type="submit">보내기</button>
		</form>

<%
	} else {
		// 파라미터 세 개를 모두 받은 경우
%>
		<h2>
			<%=name %>님은 <%=year %>년생이므로<br/>
			<%=age %>세 입니다.
		</h2>
<%
	}




%>
</body>
</html>