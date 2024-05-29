<%@page import="mybatis.vo.MemberVO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
	// 선언부: 멤버 변수, 멤버 메소드를 정의할 때 사용
	//	첫 호출시에만 수행
	
	// 개인이 사용한 용량을 측정하는 메서드 (File객체에서는 파일들만 용량을 얻어낼 수 있고,
	//							  폴더는 안에 파일들의 용량을 모두 더해야하기 때문에
	//								재귀함수를 이용한다.)
	
	public int totalSize = 1024*1024*10;
	public int useSize = 0;
	
	public int useSize(File f){
		// 인자로 전달된 File객체가 폴더여야한다.
		// 이 폴더의 하위 요소들의 File용량을 모두 더해야 한다.
		// 우선 하위요소들을 모두 얻어내라.
		
		File[] list = f.listFiles();
		//하위 요소들 중 폴더이면 재귀호출, 파일이면 용량 수집!
		int size = 0;
		
		for(File sf : list){
			if(sf.isFile()){
				size += sf.length(); // 용량 누적
			} else {
				size += useSize(sf); // 재귀호출
			}
		} //for의 끝
	
		return size;
	}

%>

<% // 스크립트릿: 호출할 때마다 수행

	
	Object obj = session.getAttribute("mvo");
	if(obj != null){
		MemberVO mvo = (MemberVO) obj;
		
		// 현재 사용자가 보고자하는 현재 위치값(cPath)을 인자로 받는다.
		String dir = request.getParameter("cPath");
		
		// 사용자가 폴더를 선택했을 경우라면 f_name이라는 파라미터도 받는다
		String fname = request.getParameter("f_name");	
		
		
		// index.jsp에서 들어온 경우 dir, fname에 null을 받는다.
		if(dir == null){
			// 현재 위치값을 받지 못한 경우. 무조건 해당 id로 지정
			dir = mvo.getM_id();
			String path = application.getRealPath("/members/"+dir);
			File f = new File(path);
			useSize = useSize(f); // 사용하고 있는 용량을 구해준다.
		} else {
			// 현재 영역은 MyDisk화면에서 원하는 폴더를 선택한 경우
			if(fname!=null && fname.trim().length()>0){
				dir = dir+"/"+fname;
			}
		}
		
		// 나중에 현재위치값을 잊어버리지 않기 위해 세션에 저장해두어라.
		session.setAttribute("dir", dir); // 나중에 파일올리기 때 이용
		
		
%>

<!doctype html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>myDisk.jsp</title>
<style type="text/css">
	table{
		width: 600px;
		border: 1px solid #27a;
		border-collapse: collapse;
	}
	table th, table td{
		border: 1px solid #27a;
		padding: 4px;
	}
	table th{ background-color: #bcbcbc; }
	.title { background-color: #bcbcbc; width: 25%; }
	
	.btn{
		display: inline-block;
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;	
		margin-right: 20px;	
	}
	.btn a{
		display: block;
		width: 100%;
		padding: 4px;
		height: 20px;
		line-height: 20px;
		background: #27a;
		color: #fff;
		border-radius: 3px;
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
	}
	.btn a:hover{
		background: #fff;
		color: #27a;
		border: 1px solid #27a;
	}
	
	#f_win{
		width: 220px;
		height: 80px;
		padding: 20px;
		border: 1px solid #27a;
		border-radius: 8px;
		background-color: #efefef;
		text-align: center;
		position: absolute;
		top: 150px;
		left: 250px;
		display: none;
	}
	#f_win2{
		width: 300px;
		height: 80px;
		padding: 20px;
		border: 1px solid #27a;
		border-radius: 8px;
		background-color: #efefef;
		text-align: center;
		position: absolute;
		top: 150px;
		left: 250px;
		display: none;
	}
</style>
</head>
<body>
	<h1>My Disk service</h1>
	<hr/><%=mvo.getM_name() %>
	(<span class="m_id"><%=mvo.getM_id() %></span>)님의 디스크
	&nbsp;[<a href="javascript:home()">Home</a>]
	<hr/>
	
	<table summary="사용량을 표시하는 테이블">
		<tbody>
			<tr>
				<th class="title">전체용량</th>
				<td><%=totalSize/1024 %>KB</td>
			</tr>
			<tr>
				<th class="title">사용량</th>
				<td><%=useSize/1024 %>KB</td>
			</tr>
			<tr>
				<th class="title">남은용량</th>
				<td><%=(totalSize-useSize)/1024 %>KB</td>
			</tr>
		</tbody>
	</table>
	<hr/>
		<div id="btn_area">
			<p class="btn">
				<a href="javascript:selectFile()">
					파일올리기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:makeFolder()">
				
					폴더생성
				</a>
			</p>
			<p class="btn">
				<a href="javascript:exe()">
					파일생성
				</a>
			</p>
		</div>		
	<hr/>
	
	<label for="dir">현재위치:</label>
	<span id="dir"><%=dir %></span>
	
	<table id="t1" summary="폴더의 내용을 표현하는 테이블">
		<colgroup>
			<col width="50px"/>
			<col width="*"/>
			<col width="80px"/>
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>폴더 및 파일명</th>
				<th>삭제여부</th>
			</tr>
		</thead>
		<tbody>
		<%
			// members폴더에서 로그인한 자신의 폴더를 최상위폴더로 지정
			// 그 안에 있는 모든 파일 또는 디렉토리를 표현
			// 현재위치(dir)의 내용과 사용자의 id가 같다면
			// 아래의 [상위로...] 기능은 표현하지 않아야한다.
			
			if(!dir.equals(mvo.getM_id())){
			// [상위로...] 기능 부여
			// 예를 들어 현재 위치 값(dir)이 "test/abc/123"라고
			// 가정하면 [상위로...] 기능은 "test/abc"의 위치를 의미한다.
			
			// 이를 위해서 현재 위치값에서 가장 뒤에 있는 "/"의 index를
			// 얻어내어 맨 앞에서 그 index까지만 substring하면 된다.
			int idx = dir.lastIndexOf("/");
			String upPath = dir.substring(0,idx);
			
			
			
		%>
			<tr>
				<td>↑</td>
				<td colspan="2">
					<a href="javascript:goUp('<%=upPath %>')">
						상위로...
					</a>
				</td>
				
			</tr>
		<% }
			// 현재 위치의 하위내용을 출력하기 위해 현위치값을 통해
			// 파일객체를 만들기 위해 절대경로를 필요하다.
			
			String realPath = application.getRealPath("/members/"+dir);
			
			File s_file = new File(realPath);
			
			File[] sub_list = s_file.listFiles();
		
		
			for(File f: sub_list){
		
		%>

			<tr>
				<td>
					<%if(f.isFile()){ %>
						<img src="../images/file.png"/>
					<%}else{ %>
						<img src="../images/folder.png"/>
					<%} %>

				</td>
				<td>

					<%if(f.isDirectory()){ %>
					<a href="javascript: gogo('<%=f.getName() %>')">
						<%=f.getName() %>
					</a>
					<%} else{ %>
					<a href="javascript:down('<%=f.getName() %>')">
						<%=f.getName() %>
					</a>
					<%} %>
				
				</td>
				<td></td>
			</tr>
		<% } // for문 끝
		
		%>

		</tbody>
	</table>
	
	<form name="ff" method="post">
		<input type="hidden" name="f_name"/>
		<input type="hidden" name="cPath" value="<%=dir %>"/>
	</form>
	
	
	<div id="f_win">
		<form action="makeFolder.jsp" method="post" name="frm">
			<input type="hidden" name="cPath" value="<%=dir %>"/>
			<label for="f_name">폴더명:</label>
			<input type="text" id="f_name" name="f_name"/><br/>
			<p class="btn">
				<a href="javascript:newFolder()">
					만들기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:closeWin()">
					닫 기
				</a>
			</p>
		</form>
	</div>
	
	<div id="f_win2">
	<!-- 
		파일 첨부가 되는 form은 반드시 enctype이라는 속성이 있어야 한다.
		enctype="multipart/form-data"
		해당 속성을 사용하지않으면 파일이 아닌 파일 이름만 전송된다.
	 -->
		<form action="upload.jsp" method="post" name="frm2"
		enctype="multipart/form-data">
			<label for="s_file">첨부파일:</label>
			<input type="file" id="s_file" name="upload"/><br/>
			<p class="btn">
				<a href="javascript:upload()">
					보내기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:closeWin2()">
					닫 기
				</a>
			</p>
		</form>
	</div>
	

	
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
	function gogo(fname){
		// 현재 문서 안에 이름이 ff인 form객체를 선택하고 그 안에 있는
		//  이름이 f_name이라는 객체에 값으로 인자오 받은 fname을 저장한다.
		document.ff.f_name.value = fname;
		
		//ff라는 폼의 action 지정
		document.ff.action = "myDisk.jsp";
		
		document.ff.submit();
		
		
		// GET방식으로 호출하는 방법 
		// location.href = "myDisk.jsp?cPath=<%=dir%>&f_name="+fname;
	}
	


	function goUp(upPath){
		document.ff.cPath.value = upPath;
		document.ff.action = "myDisk.jsp";
		document.ff.submit();
		
	}
	
	function makeFolder(){
		let fwin = document.getElementById("f_win");

		fwin.style.display = "block";

		// $("#f_win").dialog();
	}
	
	function closeWin(){
		let fwin = document.getElementById("f_win");

		fwin.style.display = "none";

		// $("#f_win").dialog("close");
	}

	
	function newFolder(){
		// let name = document.getElementByID("f_name").value;
		
		let name = document.frm.f_name.value;
		if(name.trim().length<1){
			alert("폴더명을 입력하세요.");
			document.frm.f_name.value = "";
			document.frm.f_name.focus();
			return;
		}
		// document.frm.submit(); // 서버로 보낸다.(makeFolder.jsp)
		

		let path = "<%=dir%>";
		
		
		let param = "cPath="+encodeURIComponent(path)+"&f_name="+encodeURIComponent(name);
		
		
		$.ajax({
			url: "makeFolder.jsp",
			type: "post",
			data: param,
		}).done(function(res){
			alert("생성 완료!");
			document.frm.f_name.value = "";
			let fwin = document.getElementById("f_win");
			fwin.style.display = "none";
			$("#t1 tbody").html(res);
		});
	}
	
	function selectFile(){
		document.getElementById("f_win2").style.display = "block";
	}

	function closeWin2(){
		document.getElementById("f_win2").style.display = "none";
	}

	function upload(){
		// 선택된 파일의 값을 가져온다.
		let select_file = document.frm2.upload.value;
		
		if(select_file.trim().length<1){
			alert("파일을 선택하세요.");

			return;
		}


		document.frm2.submit(); // 서버로 보낸다.(upload.jsp)
	}

	// 파일을 클릭할 때 호출되는 함수
	function down(fname){
		// 인자로 받은 파일명을 현재문서(document)의
		// ff 라는 form객체 안에
		// 이름이 f_name인 요소의 값으로 저장한다.
		document.ff.f_name.value = fname;
		
		// 해당 form의 action을 지정한다.
		document.ff.action = "download.jsp";
		
		// 해당 form을 서버로 보낸다.
		document.ff.submit();
		
		document.ff.f_name.value = ""; 	// 돌아올 때 파일명이 있어서
										// 오류가 발생할 수 있으므로
										// 해당 값을 청소함
	}




	
</script>

</body>
</html>
<%
	} else{
		response.sendRedirect("../index.jsp");
	}
%>

