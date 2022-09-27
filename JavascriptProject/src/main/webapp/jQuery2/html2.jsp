<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// <h1>jQuery2/html2.jsp</h1>
String id = request.getParameter("id");
String result="";
// if(id.equals("kim")){
// 	// 아이디 중복
// 	result="아이디 중복";
// }else{
// 	result="아이디 사용가능";
// }
%>

	<%
		// 디비연결정보 (상수)
		final String DRIVER = "com.mysql.cj.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		final String DBID = "root";
		final String DBPW = "1234";
		
		// 1. 드라이버 로드
		Class.forName(DRIVER);
		System.out.println(" 드라이버 로드 성공! ");
		
		// 2. 디비 연결
		Connection con = DriverManager.getConnection(DBURL, DBID, DBPW); 
			//java 안에 있는 connection이라는 객체 안에 변수로 저장
		System.out.println(" 디비 연결 성공! ");
		System.out.println(" con : " + con);
		
		// 3. SQL 작성 & pstmt객체
		String sql
		= "select * from itwill_member where id=?"; 	// 순서정렬
		System.out.println(" SQL 구문 작성 완료! ");
			
		// PreparedStatement : SQL 구문을 실행하도록 도와주는 객체 (사전작업)
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		// ??? (SQL 구문에 ?가 있는 경우 실행)
 		pstmt.setString(1, id); // 큰 따옴표
			
		// 4. SQL문 실행
		// * 실행 구문은 sql 구문이 실행 시 테이블에 영향을 주는지 판단
		ResultSet rs = pstmt.executeQuery();
		System.out.println(" SQL 구문 실행 완료! ");
				
		// 5. 데이터 처리
		// => 정보를 가져다가 출력

		// rs.next() : 레코드셋의 커서를 움직여서 데이터가 있는지 없는지 체크
		if(rs.next()) {
			// 아이디 있음, 아이디 중복
			result="아이디 중복";
		} else{
			// 아이디 없음, 아이디 사용가능
			result="아이디 사용가능";
		}
	%>
	
<%=id+" : "+result%>