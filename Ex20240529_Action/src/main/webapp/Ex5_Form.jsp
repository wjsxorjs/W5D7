<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="Ex5_Add.jsp" name="f5" method="post">
		<label>제목: </label>
		<input type="text" name="title"/><br/>
		<label>작성자: </label>
		<input type="text" name="writer"/><br/>
		<label>내용: </label>
		<textarea name="content"></textarea><br/>
		<button type="button" onclick="exe()">보내기</button>
	</form>

<script>
	function exe(){
		//유효성 검사
		let title = document.f5.title.value.trim();
		if(title.length == 0){
			alert("제목을 입력하세요");
			document.f5.title.value = "";
			document.f5.title.focus();
			return;
		}
		if(document.f5.writer.value.length == 0){
			alert("작성자를 입력하세요");
			document.f5.writer.value = "";
			document.f5.writer.focus();
			return;
		}
		if(document.f5.content.value.length == 0){
			alert("내용을 입력하세요");
			document.f5.content.value = "";
			document.f5.content.focus();
			return;
		}
		document.f5.submit();
		
		document.f5.title.value = "";
		document.f5.writer.value = "";
		document.f5.content.value = "";
		
	}


</script>

</body>

</html>