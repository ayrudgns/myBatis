<%@page import="hrd.vo.Member"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="hrd.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>
</head>
<body>
<%
	MemberDao dao = MemberDao.getInstance();
	String column = request.getParameter("column");
	String find = request.getParameter("find");
	//자바스크립트 실행을 위해서 애트리뷰트 저장
	pageContext.setAttribute("column", column);
	pageContext.setAttribute("find", find);
	
//검색에 필요한 Map 설정
	Map<String,String> map = new HashMap<>();
//1) 이름으로 검색 2) 주소로 검색 3) 지역 4)등급
	map.put("column", column);		
//"name","address","city","grade" 4가지 로 변경할때 마다 검색 컬럼이 달라집니다.
	map.put("find",find);
	List<Member> list = dao.search(map);
				
%>
<form action="searchSelectFirst.jsp">
<select name="column" id="column">
					<option value="name">이름</option>
					<option value="address">주소</option>
					<option value="grade">고객등급</option>
					<option value="city">거주지역</option>
				</select>
				
				<!-- 아래 find는 2개중에 하나만 화면에 표시 -->
				<span id="content">
					<input name="find" placeholder="검색할 내용 입력" value="<%= (find!=null)? find : "" %>">
				</span>
				<span id="grade">
					<select name="find" id="grades">
							<!-- 사용자 선택하는 텍스트와 db테이블에 저장된 값이 다릅니다. -->
							<option value="A">VIP</option>
							<option value="B">일반</option>
							<option value="C">직원</option>
					</select>
				</span>
				<button>검색</button>
				<button type="button" onclick="location.href='searchSelectFirst.jsp'">전체보기</button>
</form>
<% if (list !=null && list.size() !=0) { %>
	<p><%= list %></p>
<% } %>

 <script type="text/javascript">
    				// const sel2 = document.getElementById('sel');		//1개 요소만 가져옵니다.
    				//selector(.  , #  ,태그이름, > )를 이용해서 여러개요소 가져옵니다.
    	const sel = document.querySelectorAll("#column>option");  /* > 자식요소 */
			    	//console.log(sel);
    	sel.forEach(function(item){
    		if(item.value=='${column}'){
    			item.selected='selected';
    				//column 애트리뷰트값과 일치하는 option 항목일때입니다.
    		}
    	});
    	
    	document.querySelectorAll("#grades>option").forEach(function(item){
    		if(item.value=='${find}'){
    			item.selected='selected';
    				//grade를 선택한 것에 따라 일치하는 option을 표시합니다. 
    		}
    	});
    	/* 화면표시 변경 */
    	const grade = document.getElementById('grade');			//select
    	const content = document.getElementById('content');		//input
    	if('${column}'=='grade') {
    		grade.style.display ='inline-block';
			content.style.display ='none';
    	}else {
    		content.style.display ='inline-block';
			grade.style.display ='none';
    	}
    	//	grade.style.display ='none';		//안보이게 하는 방법
    	// 검색 컬럼선택 sel 이 변경될떄
    	document.getElementById('column').addEventListener("change",changeView);
    	function changeView(){
    		//form요소 가져오기 - select 
    		const col = document.forms[0].column.value;
    		if(col=='grade'){
    			grade.style.display ='inline-block';
    			content.style.display ='none';
    			
    		}else {
    			content.style.display ='inline-block';
    			grade.style.display ='none';
    			//form요소 가져오기 - input 요소 find
    			document.forms[0].elements[1].value="";
    		}
    	}
    </script>
</body>
</html>