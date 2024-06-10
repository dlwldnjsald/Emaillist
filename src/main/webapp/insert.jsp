<%@ page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 

	//데이터베이스 접속정보확인
	ServletContext context = getServletContext();
	
	String dbuser = context.getInitParameter("dbuser");
	String dbpass = context.getInitParameter("dbpass");

	//폼 입력 데이터
	String firstName = request.getParameter("fn");	// firstname 키->fn
	String lastName = request.getParameter("ln");	// lastname 키->ln
	String email	= request.getParameter("email"); // email 키->email
	
	// db연결
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	
	try {
		//드라이버 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//connection 얻기
		Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
		//PreparedStatement 준비 -> sql실행계획 준비해주기
		//sql실행계획 준비해주기
		String sql ="insert into emaillist (no, last_name, first_name, email)" + 
				" values (seq_emaillist_pk.nextval, ?, ?, ?)";
		
		//PreparedStatement 
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		// 폼데이터로부터 전달받은 데이터 바인딩 
		pstmt.setString(1, lastName);
		pstmt.setString(2, firstName);
		pstmt.setString(3, email);
		
		int insertedCount = pstmt.executeUpdate();	//영향 받은 레코드 카운트
	
		if(insertedCount == 1) { //insert 성공
			//다른 페이지로 리다이렉트 하기 : 3xx
			response.sendRedirect(request.getContextPath());
		} else {
			%>
			<h1>Error</h1>
			<p>데이터 입력중 오류가 발생했습니다</p>
			<%
		}
		
		//자원 정리
		pstmt.close();
		conn.close();
		
	} catch (Exception e) {
		throw e;
		
	}	
%>	