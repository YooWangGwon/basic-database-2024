-- file : sql014_집합종류.sql
-- date : 240401
-- desc : 집합

-- 전체 고객 중 도서를 구매하지 않은 고객의 이름을 조회
-- 차집합
SELECT [name]
  FROM Customer
EXCEPT
SELECT [name]
  FROM Customer
 WHERE custid IN(SELECT custid FROM Orders);

-- 합집합, 중복을 허용안함
SELECT [name]
  FROM Customer
 UNION
SELECT [name]
  FROM Customer
 WHERE custid IN(SELECT custid FROM Orders);

-- 합집합, 중복을 허용
SELECT [name]
  FROM Customer
 UNION ALL 
SELECT [name]
  FROM Customer
 WHERE custid IN(SELECT custid FROM Orders);

-- 교집합
   SELECT [name]
     FROM Customer
INTERSECT
   SELECT [name]
     FROM Customer
    WHERE custid IN(SELECT custid FROM Orders);

-- UNION - 각 컬럼의 타입형이 일치해야함
SELECT bookid   -- int
     , bookname -- varchar(40)
  FROM Book
 UNION
SELECT custid   -- int
     , [name]   -- varcher(40)
  FROM Customer;

-- EXIST, 하나의 테이블에 존재하는 값만 보고싶다
SELECT [name]
     , [address]
  FROM Customer AS c
 WHERE EXISTS(SELECT*
               FROM Orders AS o
              WHERE o.custid = c.custid);