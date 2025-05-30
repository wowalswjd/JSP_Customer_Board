<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- JDBC 클래스 사용하려면 반드시 import -->

<h2>JDBC 드라이버 테스트</h2>
<%
	Connection conn = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp?useUnicode=true&characterEncoding=utf8";
		String dbId="jspid";
		String dbPass = "jsppass";
		
		Class.forName("com.mysql.jdbc.Driver"); // JDBC Driver 생성 및 객체 등록
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); // DB와 JSP 연동할 수 있는 객체 리턴
		out.println("제대로 연결되었습니다.");
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>