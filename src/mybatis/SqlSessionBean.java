package mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionBean {
/*
 * Mybatis 라이브러리의 SqlSession 클래스가 SQL 실행 메소드를 제공한다.
 * SqlSessionFactoryBuilder --> SqlSessionFactory 객체 생성
 *  --> dao 클래스에서 SqlSession 객체 생성  : 클래스 의존 관계
 * 	SqlSession 객체로 db sql을 실행합니다.
 * 
 * https://mybatis.org/mybatis-3/ko/getting-started.html 참고하여 작성합니다.
 * String resource = "org/mybatis/example/mybatis-config.xml";
 * InputStream inputStream = Resources.getResourceAsStream(resource);
 * SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
 */
	
	public static SqlSessionFactory sqlSessionFactory;		// 변수 선언!
	static {   // 변수들(resource, inputStream)이 static 영역에 저장됩니다.
		String resource = "mybatis/mybatis-config.xml";    	// mybatis 설정 파일
						// 해당 .xml 설정 내용에 따라 SqlSessionFactory 객체를 생성한다.
		InputStream inputStream = null;			// 파일을 읽기 위한 입력 스트림
	
		try {
			inputStream = Resources.getResourceAsStream(resource);   // 리소스 파일 읽어오기
		}catch(IOException e) {
			System.out.println("mybatis 설정 파일 읽기 오류입니다.");
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);   
		// 읽어온 파일로 factory 생성
	}
	
	public static SqlSessionFactory getSessionFactory() {    // 생성된 sqlSessionFactory 리턴하는 메소드
		return sqlSessionFactory;
	}
}
