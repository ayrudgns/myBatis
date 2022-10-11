<%@page import="hrd.vo.Member"%>
<%@page import="java.util.List"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao dao = MemberDao.getInstance();
	List<Member> list = dao.selectAll();
	
	out.print(list);
%>
<!-- 
	데이터베이스의 sql 실행에 필요한 데이터와 자바클래스 사이의 매핑을 구현해준다.
	(db 테이블의 컬럼과 자바클래스의 변수를 바로 매핑해줌!)

	mybatis를 사용하면 구현할 때 작성할 코드가 줄어든다.
	rs.next() 하고 list.add(new Member(rs.getInt(1), ....) 이런 코딩이 없음!
 -->
