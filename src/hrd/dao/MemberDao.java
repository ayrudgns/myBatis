package hrd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import hrd.vo.Member;
import hrd.vo.SaleVO;
import mybatis.SqlSessionBean;

public class MemberDao {
	SqlSessionFactory factory = SqlSessionBean.getSessionFactory();
	private static MemberDao dao = new MemberDao();
	private MemberDao() {  }
	public static MemberDao getInstance() {
		return dao;
	}

	// <select id="getNextSeq" resultType="int">
	public int getNextSeq() {
		SqlSession mapper = factory.openSession();
		// sql 실행은 SqlSession 객체로 실행한다.
		int result = mapper.selectOne("getNextSeq");
		mapper.close();
		return result;
	}

	// insert(), update(), delete() 메소드는 member.xml에 resultType이 없이도
	// 실행 결과가 반영된 행의 개수를 리턴한다.
	public int insert(Member vo) {
		SqlSession mapper = factory.openSession();
		int result  = mapper.insert("insert", vo);	
		mapper.commit();     // mybatis SqlSession 객체는 기본동작이 auto commit이 아니다.
		mapper.close();
		return result;
	}

	// commit 해야할 명령어 : insert, update, delete
	public int update(Member vo) {
		SqlSession mapper =factory.openSession();
		int result = mapper.update("update", vo);
		mapper.commit();
		mapper.close();
		return result;
	}
	
	public int delete(int custno) {
		SqlSession mapper = factory.openSession();
		int result = mapper.delete("deleteOne", custno);
		mapper.commit();
		mapper.close();
		return result;
	}
	
	public Member selectOne(int custno) {
		SqlSession mapper = factory.openSession();
		// 리턴을 받는 메소드
		Member result = mapper.selectOne("selectOne", custno);   
		// select 결과 행이 1개이면 selectOne(기본키 컬럼 조건 또는 unique와 not null 적용 컬럼 조건)
		mapper.close();
		return result;
	}
	
	public List<Member> selectAll(){
		SqlSession mapper = factory.openSession();
		List<Member> result = mapper.selectList("selectAll");  // select 결과 행이 1개 이상일 수 있다면 selectList
		mapper.close();
		return result;
	}
	
	// search 결과는 여러 행이 될 수 있으며, map은 jsp에서 전달한다.
	// 실행 쿼리는 LIKE 연산으로, 부분 일치 검색이다. (city와 grade는 완전 일치 검색이다.)
	// 예) WHERE CUSTNAME LIKE '%길%' => '길' 문자열은 #{find}로 전달되고, % 기호와 문자열을 연결하는 연산자가 ||이다. 
	public List<Member> search(Map<String, String> map) {
		SqlSession mapper = factory.openSession();
		List<Member> list = mapper.selectList("search", map); 
		mapper.close();
		return list;
	}
	
	// JOIN 결과를 확인하기 위한 메소드
	public List<SaleVO> sales() {
		SqlSession mapper = factory.openSession();
		List<SaleVO> list = mapper.selectList("sales");
		mapper.close();
		return list;
	}
 
	
}
