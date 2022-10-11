<%@page import="hrd.vo.SaleVO"%>
<%@page import="java.util.List"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 조회</title>
</head>

<body>
<% 
	MemberDao dao = MemberDao.getInstance();
	List<SaleVO> slist = dao.sales();
	out.print(slist);
%>
</body>
</html>