-- file : sql015_연습문제_part2.sql
-- date : 240401
-- desc : 연습문제 part2

-- 1. 주문하지 않은 고객의 이름(서브쿼리 사용)
SELECT DISTINCT [name]
  FROM Customer AS c
 WHERE custid NOT IN (SELECT DISTINCT custid
                        FROM Orders);
-- 2. 주문금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) AS '주문총액'
     , AVG(saleprice) AS '평균 주문 금액'
  FROM Orders;

-- 3. 고객의 이름과 고객별 구매액
SELECT c.[name]
     , SUM(saleprice) AS '구매액'
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.[name]

SELECT (SELECT [name] FROM Customer c WHERE c.custid = custid)
     , SUM(o.saleprice) AS '고객별 구매액'
  FROM Orders AS o
 GROUP BY o.custid

-- 4. 고객의 이름과 고객이 구매한 도서 목록
SELECT c.[name], b.bookname
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
 ORDER BY c.[name] ASC;

-- 5. 도서의 가격(Book테이블)과 판매가격(Orders테이블)의 차이가 가장 많은 주문
SELECT o.*, b.price, b.price - o.saleprice
  FROM Orders AS o, Book AS b
 WHERE b.bookid = o.bookid

-- 5-1
SELECT o.orderid AS '가격 차이가 가장 많은 주문'
  FROM Book AS b, Orders AS o
 WHERE b.bookid = o.bookid
   AND ABS(b.price - o.saleprice) = ABS((SELECT MAX(b.price - o.saleprice)
                                  FROM Book AS b, Orders AS o
                                 WHERE b.bookid = o.bookid))

-- 5-2
SELECT TOP 1 o.orderid -- 1
     , o.saleprice -- 2
     , b.price -- 3
     , (b.price - o.saleprice) AS '금액차' -- 4
  FROM Orders AS o, Book AS b
 WHERE o.bookid = b.bookid
 ORDER BY 4 DESC

-- 6. 도서 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT AVG(saleprice) AS '도서 판매액 평균'
  FROM Orders AS o;

SELECT AVG(saleprice) AS '자신의 평균 구매액'
  FROM Orders AS o
 GROUP BY o.custid;

-- 6-1
SELECT DISTINCT c.[name]
  FROM Customer AS c, Orders AS o1
 WHERE c.custid = o1.custid
   AND (SELECT AVG(saleprice) AS '자신의 평균 구매액'
          FROM Orders AS o2
         WHERE o1.custid = o2.custid
         GROUP BY o2.custid) > (SELECT AVG(saleprice) AS '도서 판매액 평균'
                                  FROM Orders);

-- 6-2
SELECT b.AVG AS '구매액 평균'
     , c.[name]
  FROM (SELECT AVG(o1.saleprice) AS AVG
             , o1.custid
          FROM Orders AS o1
         GROUP BY o1.custid) AS b, Customer AS c
 WHERE b.custid = c.custid
   AND b.avg >= (SELECT AVG(saleprice)
                   FROM Orders);

-- 6-3
SELECT (SELECT [name] FROM Customer WHERE custid = base.custid) AS '고객명'
     , base.Average
  FROM (SELECT o.custid
             , AVG(o.saleprice) AS Average
          FROM Orders AS o
         GROUP BY o.custid) AS base
 WHERE base.Average >= (SELECT AVG(saleprice)
                          FROM Orders)