<%@page import="himedia.dao.EmaillistDaoOracleImpl"%>
<%@page import="himedia.dao.EmaillistDao"%>

<%@ page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//	데이터베이스 접속 정보 확인
	//ServletContext를 통해 웹 애플리케이션의 컨텍스트 정보를 가져옴
	ServletContext context = getServletContext();
	
	//웹 애플리케이션의 초기화 매개변수에서 데이터베이스 접속에 필요한 사용자 이름과 비밀번호를 가져오기
	String dbuser = context.getInitParameter("dbuser");
	String dbpass = context.getInitParameter("dbpass");
	
	
	//폼 입력 데이터 처리: HTTP 요청에서 "no" 매개변수를 가져와 문자열 형태로 반환
	//Integer.valueOf() -> 문자열을 정수형 Integer으로 변환
	long no = Integer.valueOf(request.getParameter("no"));	//	pk
	
	//가져온 데이터베이스 접속정보와 no를 사용하여 /DAO호출 및  impl의 새 객체 dao 생성
	EmaillistDao dao = new EmaillistDaoOracleImpl(dbuser, dbpass);
	
	//새객체dao에 delete 메서드 실행 no에 해당하는 이메일 삭제
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
	if (success) { //성공하면 클라이언트를 지정된 URL인 "/emaillist/"로 리다이렉트
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
