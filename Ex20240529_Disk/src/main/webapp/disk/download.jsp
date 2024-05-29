<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 요청 시 한글처리
    request.setCharacterEncoding("UTF-8");

    // 파일명, 경로을 읽어온다.
    String f_name = request.getParameter("f_name");
    String cPath = request.getParameter("cPath");

    // 위의 값들을 연결하여 절대경로로 만든다.(서버의 특정 위치)
    String realPath = application.getRealPath("/members/" + cPath+ "/" + f_name);

    // 파일을 읽어온다.
    File f = new File(realPath);

    // 파일 존재여부 확인
    if(f.exists()){
        byte[] buf = new byte[4096];
        int size = -1;
        // 다운로드에 필요한 스트림들 준비
        BufferedInputStream bis = null;
        FileInputStream fis = null;

		BufferedOutputStream bos = null;
		ServletOutputStream sos = null; // 응답이 접속자 PC로 다운로드 시키는
										// 것이기에 response를 통해 스트림을
										// 생성해야한다. 즉, response로부터
										// 얻어지는 OutputStream이 바로
										// ServletOutputStream이다.
		try{
			// 접속자화면에 다운로드 창을 보여준다.
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition",
					"attachment;filename="+
			new String(f_name.getBytes(),"8859_1"));
		// --------------------------------------------------
		
		// 다운로드할 File과 연결되는 스트림을 생성
			fis = new FileInputStream(f);
			bis = new BufferedInputStream(fis);
			
			// response를 통해 이미 out이라는 스트림이 존재하므로
			// 오류 방지를 위해 해당 out 초기화
			out.clear();
			out = pageContext.pushBody();
			
			sos = response.getOutputStream();
			bos = new BufferedOutputStream(sos);
			
			// 스트림이 모두 준비완료 > 읽은 후 바로 쓰기를 통해
			// 요청한 곳에서 바로 다운로드가 되도록 한다.
			
			while((size = bis.read(buf)) != -1){
				bos.write(buf,0,size);
				bos.flush();
			}
		}catch(Exception e){
			
		}finally{
			try{
				if(fis!=null){
					fis.close();
				}
				if(bis!=null){
					bis.close();
				}
                if(sos!=null){
                    sos.close();
                }
                if(bos!=null){
                    bos.close();
                }
			}catch(Exception e){

				
			}
		}
    	
    }




%>
