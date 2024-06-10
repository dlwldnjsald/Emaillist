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
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	
	try {
		//드라이버 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//connection 얻기
		Connection conn = DriverManager(dburl, dbuser, dbpass);
		//PreparedStatement 준비 -> sql실행계획 준비해주기
		//sql실행계획 준비해주기
		String sql ="insert into emaillist (no, last_name, first_name, email)" + 
				" values (seq_emaillist_pk.nextval, ?, ?, ?)";
		
		//PreparedStatement 
		PreparedStatement pstm = conn.prepareStatement(sql);
		
		
	}