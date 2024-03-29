-- file : sql007_집계함수.sql
-- date : 240329
-- desc : 집계 함수, GROUP BY, HAVING

-- 고객이 주문한 도서의 총 판매액
-- 의미있는 열 이름을 출력하고 싶으면 속성이름의 별칭을 지칭하는 AS워키워드를 사용
SELECT sum(saleprice) AS [총 매출] -- '' 나 []로 감싸거나 감싸지 않아도 되지만 감싸지 않을 경우에는 스페이스를 써선 안된다. 
  FROM Orders;

-- 김연아 고객이 주문한 도서의 총 판매액
SELECT *
  FROM Customer;

SELECT sum(saleprice) AS '김연아 고객 총 판매액'
  FROM Orders
 WHERE custid = 2;

-- COUNT() 는 *(all)을 사용할 수 있음.
-- 나머지 집계 함수는 열(컬럼) 하나만 지정해서 사용할 것.

SELECT COUNT(saleprice) AS [주문개수]
     , SUM(saleprice) AS [총 판매액]
	 , AVG(saleprice) AS [판매액 평균]
	 , MIN(saleprice) AS [주문도서 최소금액]
	 , MAX(saleprice) AS [주문도서 최대금액]
  FROM Orders

-- 중복제거한 출판사 개수
SELECT COUNT(DISTINCT publisher)
  FROM Book;

-- GROUP BY : 필요한 조건으로 그룹핑을 해서 결과(통계)를 내기 위함
-- GROUP BY절에 들어있는 컬럼 외에는 SELECT문 절대(!) 쓸 수 없음
-- 단, saleprice는 집계함수 안에 들어있으므로 예외
SELECT custid
	 , SUM(saleprice) '총판매액'
	 , COUNT(saleprice) AS '구매횟수'
	 , AVG(saleprice) AS '평균판매액'	-- custid로 GROUP BY를 했다면 custid와 집계 함수 결과만 출력 할 수 있다.
  FROM Orders
 GROUP BY custid;

 -- HAVING -WHERE절은 일반 필터링 조건
 -- HAVING은 통계, 집합함수의 필터링 조건
 -- 가격이 8000원 이상인 도서를 구매한 고객에 고객별 주문도서 총수량
 -- 단 2권 이상 구매한 경우만
SELECT custid, COUNT(*) AS '구매수'
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
HAVING COUNT(*) >= 2;