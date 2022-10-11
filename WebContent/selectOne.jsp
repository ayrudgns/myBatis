<%@page import="hrd.vo.Member"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao dao = MemberDao.getInstance();
	String temp = request.getParameter("custno");
	int custno = Integer.parseInt(temp);
	
	Member mb = dao.selectOne(custno);
	out.print(mb);
	// 실행은 url에 파라미터를 추가하면 된다. => selectOne.jsp?custno=100002

%>