<%@page import="himedia.dao.EmaillistDaoOracleImpl"%>
<%@page import="himedia.dao.EmaillistDao"%>

<%@ page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//	데이터베이스 접속 정보 확인
	ServletContext context = getServletContext();
	String dbuser = context.getInitParameter("dbuser");
	String dbpass = context.getInitParameter("dbpass");
	
	
	//폼 입력 데이터
	long no = Integer.valueOf(request.getParameter("no"));	//	pk
	
	EmaillistDao dao = new EmaillistDaoOracleImpl(dbuser, dbpass);
	boolean success = dao.delete(no);
    
/*
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

try {
	//	드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");
	//	커넥션 얻기
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
	//	실행 계획
	String sql = "DELETE FROM emaillist WHERE no=?";
	
	//	PreparedStatment
	PreparedStatement pstmt = conn.prepareStatement(sql);
	//	데이터 바인딩
	pstmt.setString(1, no);
	
	int deletedCount = pstmt.executeUpdate();	//	영향 받은 레코드 카운트
	
	if (deletedCount == 1) {	//	DELETE 성공
		//	다른 페이지로 리다이렉트 : 3xx
		response.sendRedirect(request.getContextPath());
	} else {
		
*/
	
	
	// 삭제 결과에 따라 다른 페이지로 리다이렉트 또는 오류 메시지 출력
	if (success) {
		response.sendRedirect(request.getContextPath() + "/emaillist/");	
	
	} else {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "아이템을 삭제하지 못했습니다.");
	
	}

	
	/*
		}
		//	자원 정리
		pstmt.close();
		conn.close();
	} catch (Exception e) {
		throw e;
	}
	*/

%>
