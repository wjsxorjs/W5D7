<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--
	첨부파일을 받기 위해서는 servlets.com에 있는 cosㄹ이브러리가 필요하다.
	사이트 좌측 [COS File upload Libarary]라는 메뉴를 선택한 후
	화면 하단부에 [Download]항목에 있는 표에 cos-22.05.zip을 다운받아
	압축해제 후 /lib/cos.jar파일을 현재 프로젝트 webapp/WEB-INF/lib에
	복사해 넣는다.
--%>
    
<%
	// 첨부파일을 받아서 서버에 올리기 위해 필요한 객체를 생성한다.
	// 해당 인자를 보내줄 때 enctype을 mulipart/form-data로 해주었기에
	// 받을 때도 MultipartRequest로 받아준다.
	String dir = (String) session.getAttribute("dir");
	String uploadPath = application.getRealPath("/members/"+dir);
	int maxPostSize = 5 * 1024 * 1024; // 5 MB
	MultipartRequest mr = new MultipartRequest(request,uploadPath,maxPostSize,new DefaultFileRenamePolicy());
	
	// 이때 첨부되는 파일들이 지정된 realPath에 저장된다.
	
	// 파일명이 변경될 수도 있으므로 확인을 위해
	// 먼저 첨부파일을 File객체로 얻어낸다.
	File f = mr.getFile("upload");
	String f_name = f.getName(); // 현재파일명
	String o_name = mr.getOriginalFileName("upload"); // 변경전 파일명
	
	
	// 페이지 강제이동 :get방식
	// response.sendRedirect("myDisk.jsp?cPath="+dir);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>upload.jsp</title>
</head>
<body onload="movePage()">
	<form action="myDisk.jsp" method="post">
		<input type="hidden" name="cPath" value="<%=dir%>" />
	</form>
	<script>
		function movePage(){
			document.forms[0].submit();
		}
	</script>
</body>

</html>