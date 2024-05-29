<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex3_UseBean2</title>
</head>
<body>
	<jsp:useBean id="v1" class="pm.vo.Count" scope="application" />
	<jsp:useBean id="v2" class="pm.vo.Count" scope="page" />
	<jsp:useBean id="v3" class="pm.vo.Count" scope="session" />
	
<%
	v1.inc();
	v2.inc();
	v3.inc();
%>

	<h1>Ex3_UseBean2.jsp</h1>
	<h2>v1.count - application : <%=v1.getCount() %></h2>
	<h2>v2.count - page : <%=v2.getCount() %></h2>
	<h2>v3.count - session : <%=v3.getCount() %></h2>
	
	<a href="Ex3_UseBean.jsp">[이전페이지]</a>
	 
	
	<!-- 
		v2는 생명주기가 끝난다.
		v2: 현재 페이지까지만
	 -->
</body>
</html>