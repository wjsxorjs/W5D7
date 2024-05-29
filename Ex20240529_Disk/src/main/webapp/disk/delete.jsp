<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	String cPath = request.getParameter("cPath");
	String f_name = request.getParameter("f_name");
	
	String realPath = application.getRealPath("/members/"+cPath+"/"+f_name);

	File f = new File(realPath);
	
	if(f.exists()){
		f.delete(); // 파일 삭제
	}
	

%>
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body onload="movePage()">
	<form action="myDisk.jsp" method="post">
		<input type="hidden" name="cPath" value="<%=cPath %>" />
	</form>
<script>
	function movePage(){
		document.forms[0].submit();
	}
</script>
</body>
</html>