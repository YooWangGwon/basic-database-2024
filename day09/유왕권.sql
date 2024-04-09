-- file : 유왕권.sql
-- date : 240409
-- desc : 데이터베이스 기본 코딩테스트

-- 1번.회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.
-- (결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 31개입니다)

SELECT Email
	 , Mobile
	 , Names
	 , Addr
  FROM membertbl
 ORDER BY Addr DESC, Email ASC;

-- 2번. 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.(전채 행의 개수는 59개입니다)

SELECT Names AS '도서명'
	 , Author AS '저자'
	 , ISBN
	 , Price AS '정가'
  FROM bookstbl
 ORDER BY Price DESC;

-- 3번. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.(책을 한번도 빌린적이 없는 회원을 뜻합니다)

SELECT Names AS '회원명'
	 , Levels AS '회원등급'
	 , Addr AS '회원주소'
	 , rentalDate AS '대여일'
  FROM membertbl m
  LEFT OUTER JOIN rentaltbl r
  ON m.memberIdx = r.memberIdx
 WHERE r.rentalDate IS NULL
 ORDER BY m.Levels ASC;

-- 4. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.
-- (SELECT Names FROM divtbl WHERE Division = b.Division) AS '책 장르'

SELECT d.Names AS '책 장르'
	 , FORMAT(SUM(b.price),'#,# 원') AS '총합계금액'
  FROM divtbl AS d
	 , bookstbl AS b
 WHERE d.Division = b.Division
 GROUP BY d.Names

-- 5. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.

SELECT CASE WHEN GROUPING(d.Names) = 1 THEN '합계'
	   ELSE d.Names 
	   END AS '책 장르'
	 , COUNT(*) AS '권수'
	 , FORMAT(SUM(b.price),'#,# 원') AS '총합계금액'
  FROM divtbl AS d
	 , bookstbl AS b
 WHERE d.Division = b.Division
 GROUP BY ROLLUP(d.Names)
