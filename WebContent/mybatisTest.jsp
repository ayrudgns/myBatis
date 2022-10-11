<%@page import="mybatis.SqlSessionBean"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	/// mybatis 설정한 것으로 데이터베이스 연결되는지 확인하기
	SqlSessionFactory factory = SqlSessionBean.getSessionFactory();
	out.print(factory);
%>

</body>
</html>