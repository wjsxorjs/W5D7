<%@page import="java.util.List"%>
<%@page import="pm.vo.DataVO2"%>
<%@page import="pm.service.FactoryService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");

	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");

    if(title == null || writer == null || content == null){
    	response.sendRedirect("Ex5_Form.jsp");
    	return;
    }
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <jsp:useBean id="dvo" class="pm.vo.DataVO2" />
    <jsp:setProperty name="dvo" property="*" />

    <%
        SqlSession ss = FactoryService.getFactory().openSession();
        int chk = ss.insert("board.add", dvo);
        if(chk == 1){
        	ss.commit();
        } else{
        	ss.rollback();
        }
        
        List<DataVO2> d_list = ss.selectList("board.all");
        for(DataVO2 dvo2: d_list){
	%>
		<p><%=dvo2.getTitle() %> / <%=dvo2.getWriter() %> / <%=dvo2.getContent() %></p>
		
	<%
        }

  	%>
  		<a href="Ex5_Form.jsp">[이전페이지]</a>
  	<%
    	ss.close();
    	
    %>
	

</body>

</html>