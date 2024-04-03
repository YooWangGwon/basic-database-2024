-- file : sql22_서브쿼리_리뷰.sql
-- date : 240403
-- desc : 서브쿼리 리뷰

-- ALL, ANY, SOME
-- 3번 고객이 주문한 도서의 최고금액 보다 더 비싼 도서를 구입한 다른 주문의 주문번호, 금액 표시

SELECT *
  FROM Customer;

-- 장미란이 주문한 내역
SELECT MAX(saleprice)
  FROM Orders
 WHERE custid = 3;

-- 13000원보다 비싼 도서를 구입한 주문번호, 금액
SELECT o1.orderid
    , o1.saleprice
  FROM Orders as o1
 WHERE o1.saleprice > ALL(SELECT MAX(saleprice)
                           FROM Orders
                           WHERE custid =3);

-- EXIST, NOT EXISTS : 열을 명시 안함
-- 대한민국 거주 고객에게 판매한 도서의 총판매액

SELECT SUM(saleprice) AS '대한민국 고객 판매액'
  FROM Orders AS o
 WHERE EXISTS(SELECT *
                FROM Customer AS c
               WHERE c.address LIKE '%대한민국%'
                 AND c.custid = o.custid);

-- 조인으로도 가능
-- 서브쿼리는 성능에 영향을 미치기 때문에 최소한으로 사용!!
SELECT SUM(saleprice) AS '대한민국 고객 판매액'
  FROM Orders AS o, Customer AS c
 WHERE o.custid = c.custid
   AND c.address LIKE '%대한민국%';

-- SELECT절 서브쿼리, JOIN으로 변경가능
-- 이미 쿼리가 너무 복잡해서 더이상 테이블을 추가하기 힘들면 많이 사용
-- 마당서점의 고객별 판매액을 보이시오
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , o.custid
     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
  FROM Orders AS o
 GROUP BY o.custid; -- GORUP BY가 들어가면 SELECT절에 반드시 집계함수가 들어가야 함

-- UPDATE에서도 사용가능
-- 사전준비
ALTER TABLE Orders ADD bookname VARCHAR(40);

-- 조인으로 가능 바로 다음장
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , o.custid
  FROM Orders AS o
 GROUP BY o.custid;

-- 업데이트 : 한꺼번에 필요한 필드값을 한 테이블에서 다른 테이블로 복사할 때 아주 유용함.
UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book
                    WHERE Orders.bookid = Book.bookid)
            
-- FROM절 서브쿼리(인라인 뷰[가상테이블])
-- 고객별 판매액을 고객명과 판매금액을 보이시오(서브쿼리 --> 조인)
-- 고객별 판매액 집계 쿼리가 FROM 절에 들어가면 모든 속성(컬럼)에 이름이 있어야함(집계함수 값들에 이름을 지정할 것)
SELECT c.[name], b.total
  FROM (SELECT SUM(o.saleprice) AS 'total' -- 이름을 지정해줘야함
             , o.custid
          FROM Orders AS o
         GROUP BY o.custid) AS b, Customer AS c
  WHERE b.custid = c.custid;

-- 고객번호가 2 이하인 고객의 판매액을 보이시오
SELECT c.custid
     , c.[name]
     , b.total
  FROM (SELECT SUM(o.saleprice) AS 'total' -- 이름을 지정해줘야함
             , o.custid
          FROM Orders AS o
         GROUP BY o.custid) AS b, Customer AS c
  WHERE b.custid = c.custid
    AND c.custid <= 2;

-- (!!!주의!!!)GROUP BY에 들어갈 컬럼(속성)은 최소화. 중복등의 문제가 있으면 결과가 다 틀어짐
SELECT (SELECT [name] FROM Customer WHERE custid = c.custid) AS '고객명'
     ,SUM(o.saleprice) AS '고객별 판매액'
  FROM (SELECT custid
             , [name]
          FROM Customer
         WHERE custid <= 2) AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.custid;