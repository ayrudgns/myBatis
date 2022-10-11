<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="hrd.vo.Member"%>
<%@page import="java.util.List"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao dao = MemberDao.getInstance();
	String find = request.getParameter("find");	

	// 검색에 필요한 Map 설정하기
	Map<String, String> map = new HashMap<>();
	
	// 검색
	map.put("column", "name");
					// "name", "address", "city", "grade" 4가지 변경 가능!
					// 변경할 때마다 검색 컬럼이 달라진다. (쿼리 스트링도 달라져야 함!)
	map.put("find", find);
	List<Member> list = dao.search(map);	
	out.print(list);
%>

<!-- 실행 예시 : searchTest.jsp?find=김 -->