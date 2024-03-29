-- file : sql008_연습문제_part1.sql
-- date : 240329
-- desc : 연습문제 part1

-- 1. 도서번호가 1인 도서 검색
SELECT *
  FROM Book
 WHERE bookid = 1;

-- 2. 가격이 2만원 이상인 도서 이름
SELECT *
  FROM Book
 WHERE price >= 20000;

-- 3. 박지성의 총 구매액(박지성의 고객번호(Custid)는 1번)
SELECT *
  FROM Customer;

SELECT SUM(saleprice) AS '박지성의 총 구매액'
  FROM Orders
 WHERE custid =1;

-- 4. 박지성의 총 구매수
SELECT COUNT(*) AS '박지성의 총 구매수'
  FROM Orders
 WHERE custid =1;

-- 5. 박지성이 구매한 도서의 출판사 수
SELECT COUNT(DISTINCT publisher)
  FROM Book
 WHERE Bookid IN(SELECT Bookid
				   FROM orders
                  WHERE custid IN(SELECT custid
									FROM Customer
								   WHERE [name] = '박지성'));

-- 6. 박지성이 구매하지 않은 도서의 이름
SELECT bookname
  FROM Book
 WHERE Bookid NOT IN(SELECT Bookid
				   FROM orders
                  WHERE custid IN(SELECT custid
									FROM Customer
								   WHERE [name] = '박지성'));
