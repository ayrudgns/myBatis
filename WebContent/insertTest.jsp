<%@page import="hrd.vo.Member"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao dao = MemberDao.getInstance();
	Member mb = new Member(99999, "최예나", "010-9090-7878", "강원도 강릉시", null, "B", "22");
	int result = dao.insert(mb);
	out.print("insert 결과 : " + result);
%>

<!-- 실행 결과는 오라클(dbeaver)에서 확인하기, insert 결과 : 1 화면에 출력됨! -->