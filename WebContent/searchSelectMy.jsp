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
	MemberDao dao = MemberDao.getInstance();		// MemberDao 객체 생성
	String column = request.getParameter("column");		//  column 파라미터 받아오기
	String find = request.getParameter("find");		// find 파라미터 받아오기
	// 자바스크립트 실행을 위해서 애트리뷰트 저장
	pageContext.setAttribute("column", column);		// column 애트리뷰트 set 하고 페이지로 넘기기
	pageContext.setAttribute("find", find);			// find 애트리뷰트 set 하고 페이지로 넘기기
	
// 검색에 필요한 Map 설정
	Map<String, String> map = new HashMap<>();
// 검색할 항목
	map.put("column", column);		
// "name", "address", "city", "grade" 4가지로 변경할 때마다 검색 컬럼이 달라진다.
	map.put("find", find);
	List<Member> list = dao.search(map);	// .search(map) 메소드 호출 후 List에 담기			
%>

<form action="searchSelectMy.jsp">		<!-- form 태그 활용하여 페이지 넘기기 -->
		<select name="column" id="column">		<!-- 이름 / 주소 / 고객등급 / 거주지역 선택하는 select -->
			<option value="name">이름</option>
			<option value="address">주소</option>
			<option value="grade">고객등급</option>
			<option value="city">거주지역</option>
		</select>
				<!-- 아래 find는 2개 중에 하나만 화면에 표시 -->
				<!-- 1번 find -->
				<span>		<!-- 이름 / 주소 / 거주지역 option 선택 시 사용할 input box -->
					<input name="find" placeholder="검색할 내용 입력" value="<%= (find != null) ? find : "" %>" id="content">
				</span>
				<!-- 2번 find -->
				<span id="grade">	<!-- 고객등급 option 선택 시 사용할 select box -->
					<select name="find" id="grades">
							<!-- 사용자가 선택하는 텍스트와 db테이블에 저장된 값이 다르다. -->
							<option value="A">VIP</option>
							<option value="B">일반</option>
							<option value="C">직원</option>
					</select>
				</span>
				<button>검색</button>	<!-- submit! -->
				<button type="button" onclick="location.href='searchSelectMy.jsp'">전체보기</button>
</form>
		<!-- 이제 검색 완료하면 데이터 출력될 부분! -->
<%
	if (list != null && list.size() != 0) {		// list가 null이 아니고 list의 size가 0이 아니면		
%>
	<p><%= list %></p>			<!-- 출력하기! -->
<%
	}
%>
		<!-- 필요한 javascript 변수, 함수! -->
 <script type="text/javascript">
		// const sel2 = document.getElementById('sel');		// 1개 요소만 가져온다.
		// selector(., #, 태그 이름, >)를 이용해서 여러개 요소를 가져온다. => 배열!
		
		// 파라미터로 전달받은 column으로 옵션 4개의 값 중 선택하기
    	const sel = document.querySelectorAll("#column>option");  /* > 자식요소 */
    	// sel은 배열이다. querySelectorAll로 가져왔기 때문!
    	
    	sel.forEach(function(item) {	// sel배열(column)의 요소인 item으로 forEach 돌리기!
    		console.log(item);			// 여기서 item은 이름 / 주소 / 고객등급 / 거주지역
    		if(item.value == '${column}') {		// sel배열의 요소인 item의 value와 애트리뷰트로 가져온 column의 값이 일치할 때 
    											// = column 애트리뷰트 값과 일치하는 option 항목일 때
    			item.selected = 'selected';		// 그 item은 선택된다.
    		}
    	});
    	
    	document.querySelectorAll("#grades>option").forEach(function(item) {
    		console.log(item);				// grades 자식 요소인 option에 대하여 forEach 돌리기
    										// 여기서 item은 A(VIP) / B(일반) / C(직원)
    		if(item.value == '${find}') {		// item의 value와 애트리뷰트로 가져온 find의 값이 일치할 때
							    				// = grade를 선택한 것에 따라 일치하는 option을 표시 
    			item.selected = 'selected';		// 그 item은 선택된다.
    		}
    	});
    	
    	/* 화면표시 변경 */
    	const grade = document.getElementById('grade');			// select 감싸는 span
    		// '고객등급' option의 span 태그
    	const grade_sel = document.getElementById('grades');	// select find
    		// 고객등급의 option들
    	const content = document.getElementById('content');		// input
    		// 고객등급 이외에서 활용할 input box
    
    	if('${column}' == 'grade') {		// 애트리뷰트로 가져온 column의 값 = '고객등급' option일 때
    		grade.style.display = 'inline-block';	// span태그 나오고
			grade_sel.disabled = false;				// 고객등급 옵션 활성화
			content.style.display = 'none';			// input box 들어가고
			content.disabled = 'disabled';			// input 비활성화
    	} else {
			grade.style.display = 'none';			// span태그 들어가고
			grade_sel.disabled = 'disabled';		// 고객등급 옵션 비활성화
    		content.style.display = 'inline-block';	// input box 나오고
			content.disabled = false;				// input 활성화
    	}
    			// grade.style.display = 'none';		// 안보이게 하는 방법
    	
    	// 검색 컬럼 선택 sel이 변경될 때 (즉, option을 바꿀 때)
    	document.getElementById('column').addEventListener("change", changeView);
    			// column으로 된 id를 가진 놈이 change될 때, changeView 함수를 실행한다.
    			
    	function changeView() {
    		// form요소 가져오기 - select 
    		const col = document.forms[0].column.value;		// 첫번째 form의 column의 value
    														// name, address, grade, city 중에서!
    		if(col == 'grade'){		// 고객 등급을 선택하면
        		grade.style.display = 'inline-block';	// span태그 나오고
    			grade_sel.disabled = false;				// 고객등급 옵션 활성화
    			content.style.display = 'none';			// input box 들어가고
    			content.disabled = 'disabled';			// input 비활성화
    			// input의 find 파라미터는 비활성화하기
    		} else { 
    			grade.style.display = 'none';			// span태그 들어가고
    			grade_sel.disabled = 'disabled';		// 고객등급 옵션 비활성화
        		content.style.display = 'inline-block';	// input box 나오고
    			content.disabled = false;				// input 활성화
    			// form요소 가져오기 - input 요소 find
    			document.forms[0].elements[1].value = "";	// input 활성화 시키면서 빈칸으로 만들어버림!
    			// 이게 없으면 전에 쓴 내용이 남는다.
    		}
    	}
    	// Line 99 ~ 109의 if문을 함수로 만들었다.
    	// 왜? 검색 컬럼 선택 sel이 변경될 때(즉, option을 바꿀 때) 필요하니까!
    </script>
</body>
</html>