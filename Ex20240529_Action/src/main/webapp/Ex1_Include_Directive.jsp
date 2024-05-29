<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex1_Include_Directive</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<div id="wrap">
        <%@ include file="Ex1_Menu.jsp" %>
        <!--
			include 지시자는
			컴파일된 결과(HTML)가 아닌 포함된 jsp의 코드가 포함시켜 한 번에 컴파일한다.
			그래서 jsp 파일 안에 있던 변수나 함수 등을 현재 페이지에서 사용할 수 있다.
		-->
		<h1><%=str %></h1>
    </div>
</body>

</html>