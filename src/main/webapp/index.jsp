<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//DB 접속정보를 컨텍스트 파라미터로부터 받아오기
	
ServletContext context  = getServletContext();	
String dbuser = context.getInitParameter("dbuser");
String dbpass = context.getInitParameter("dbpass");
 %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일링 리스트:메인</title>
</head>
<body>
	<h1>메일링 리스트</h1>
	
<%
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

try { 
	//드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");
	//데이터베이스 연결
	Connection conn = DriverManager.getConnection(dburl,dbuser,dbpass);
	Statement stmt = conn.createStatement();
	
	//sql
	String sql = "SELECT * from Emaillist ORDER BY created_at DESC";
	ResultSet rs = stmt. executeQuery(sql);
%>

	<!-- 리스트 -->
	<!-- vo 객체의 getter를 이용, 리스트를 표시 -->
	<table border="1" cellpadding="5" cellspacing="2">
		<tr>
			<th>성</th>
			<td></td>
		</tr>
		<tr>
			<th>이름</th>
			<td></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td></td>
		</tr>
	</table>
	<br />
	<!--  /end -->

<%

	rs.close();
	stmt.close();
	conn.close();

} catch (ClassNotFoundException e) {
	throw new ClassNotFoundException("드라이버를 찾을 수 없습니다.");
} catch (Exception e){
	throw e;
}

%>
	<p>
		<a href="#">추가 이메일 등록</a>
	</p>

</body>
</html>