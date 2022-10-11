<%@page import="hrd.vo.Member"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao dao = MemberDao.getInstance();
	String temp = request.getParameter("custno");
	int custno = Integer.parseInt(temp);
	
	int result = dao.delete(custno);
	out.print("delete 결과 : " + result);
	// 실행은 url에 파라미터를 추가하면 된다. => deleteTest.jsp?custno=99999

%>

