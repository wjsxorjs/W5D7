<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex1_Include_Action</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<div id="wrap">
        <jsp:include page="Ex1_Menu.jsp"></jsp:include>
        <!--
			include 액션요소는
			포함된 jsp의 코드가 아닌 컴파일된 결과(HTML)가 포함된다.
			그래서 jsp 파일 안에 있던 변수나 함수 등을 현재 페이지에서 사용할 수 없다.
		-->
		<h1><%--=str 변수를 사용하지 못하므로 오류가 발생한다.--%></h1>
    </div>
</body>

</html>