-- file : sql008_연습문제_part2.sql
-- date : 240329
-- desc : 연습문제 part2

-- 1. 마당서점 도서의 총 개수
SELECT COUNT(*) AS '총 도서 개수'
  FROM Book;

-- 2. 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT *
  FROM Book;

SELECT COUNT(DISTINCT publisher) AS '출판사의 수'
  FROM Book;


-- 3. 모든 고객의 이름, 주소
SELECT [name], [address]
  FROM Customer;

-- 4. 2014년 7월 4일 ~ 7일 사이에 주문 받은 도서의 주문번호
SELECT orderid, orderdate
  FROM Orders
 WHERE orderdate BETWEEN '2023-07-04' AND '2023-07-07';


SELECT orderid, orderdate
  FROM Orders
 WHERE orderdate >= '2023-07-04' AND orderdate <= '2023-07-07';

-- 5. 2014년 7월 4일 ~ 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
SELECT orderid, orderdate
  FROM Orders
 WHERE orderdate NOT IN(SELECT orderdate
						  FROM Orders
						 WHERE orderdate BETWEEN '2023-07-04' AND '2023-07-07');

SELECT orderid, orderdate
  FROM Orders
 WHERE orderdate NOT BETWEEN '2023-07-04' AND '2023-07-07';

SELECT orderid, orderdate
  FROM Orders
 WHERE orderdate < '2023-07-04' OR orderdate > '2023-07-07';

-- 6. 성시 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT [name], [address]
  FROM Customer
 WHERE [name] LIKE '김%';

-- 7. 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT [name], [address]
  FROM Customer
 WHERE [name] LIKE '김%'
   AND [name] LIKE '%아';

SELECT [name], [address]
  FROM Customer
 WHERE [name] LIKE '김%아'

-- 8. 주문하지 않은 고객의 이름
SELECT [name]
  FROM Customer
 WHERE custid NOT IN(SELECT custid
					   FROM Orders);

-- 9. 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) AS '총 주문금액'
	 , AVG(saleprice) AS '평균 주문금액'
  FROM Orders;

-- 10. 고객의 이름과 고객별 구매액
SELECT Customer.[name]
	 , SUM(saleprice) AS '주문 금액' 
  FROM Orders
	 , Customer
 WHERE Customer.custid = Orders.custid
 GROUP BY [name];

-- 11. 고객의 이름과 고객이 구매한 도서목록
SELECT Customer.[name]
     , bookname 
  FROM Customer
	 , Book
	 , Orders
 WHERE Book.bookid = Orders.bookid 
   AND Customer.custid = Orders.custid
 ORDER BY [name] ASC;
