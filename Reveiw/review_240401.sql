-- p.196  3-1 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름

SELECT DISTINCT c.[name]
  FROM Customer c, Orders o1
 WHERE c.custid = o1.custid
   AND c.[name] != '박지성'
   AND o1.orderid IN (SELECT orderid
					    FROM Orders o2, Book b
					   WHERE o1.custid = o2.custid
						 AND o2.bookid = b.bookid
						 AND b.publisher IN (SELECT DISTINCT b.publisher
											   FROM Book AS b, Orders AS o, Customer AS c
											  WHERE b.bookid = o.bookid
											    AND o.custid = c.custid
											    AND c.[name] = '박지성'))

-- p.196  3-2 두개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름

SELECT DISTINCT c.name
  FROM Customer c, Orders o1
 WHERE c.custid = o1.custid
   AND o1.custid IN (SELECT custid
					   FROM Orders o2, Book b
					  WHERE o1.custid = o2.custid
						AND o2.bookid = b.bookid
					  GROUP BY custid
					 having COUNT(DISTINCT b.publisher) >= 2)

-- p.196  3-3 전체 고객의 30% 이상이 구매한 도서
/*
SELECT b.bookname
  FROM Book as b, Orders as o1, Customer as c
 WHERE b.bookid = o1.bookid
   AND c.custid = o1.custid
   AND b.bookname IN ((SELECT COUNT(o2.bookid) AS '판매수'
		  FROM Orders as o2
		 WHERE o1.bookid = o2.bookid
		 GROUP BY o2.bookid)/5 >= 0.3);

SELECT COUNT(o2.bookid) AS '판매수'
  FROM Orders as o2
 GROUP BY o2.bookid
*/
SELECT b.bookname, COUNT(b.bookname)
FROM ORDERS O, BOOK B
WHERE o.bookid = b.bookid
GROUP BY b.bookname
HAVING COUNT(b.bookname) >= (
                            SELECT (COUNT(*) * 0.3)
                            FROM customer
                            );

SELECT b.custid
	 , CONVERT(float, b.custCount) / b.totalCount
  FROM (SELECT custid
			 , COUNT(custid) AS custCount
			 , (SELECT COUNT(custid) FROM Orders) AS totalCount
		  FROM Orders
		 GROUP BY custid) AS b
 WHERE CONVERT(float, b.custCount) / b.totalCount >= 0.3;

-- p.196 연습문제 4번
-- 4-5
CREATE TABLE Bookcompany(
	[name]		VARCHAR(20),
	[address]	VARCHAR(20),
	[begin]		DATE
);

-- 4-6
ALTER TABLE Bookcompany
	ADD webaddress VARCHAR(30);

-- 4-7
INSERT INTO Bookcompany
	VALUES('한빛아카데미','서울시 마포구','1993-01-01','webaddress=http://hanbit.co.kr')

-- p.196 연습문제 5번
SELECT *
  FROM Customer c1
 WHERE EXISTS (SELECT *
 					 FROM Orders c2
					WHERE c1.custid = c2.custid)
-- 5-1 : '박세리'에 관한 튜플이 출력됨
-- 5-2 : '박세리'를 제외한 튜플들이 출력됨

-- p.197 연습문제 6번

CREATE TABLE CLUBLIST
(
	grade INT,
	club CHAR,
	students INT,
	projects INT
)

ALTER TABLE CLUBLIST ALTER COLUMN club CHAR;

INSERT INTO CLUBLIST VALUES(1,'A',20,20)
INSERT INTO CLUBLIST VALUES(1,'B',10,20)
INSERT INTO CLUBLIST VALUES(1,'C',5,8)
INSERT INTO CLUBLIST VALUES(2,'A',15,10)
INSERT INTO CLUBLIST VALUES(2,'B',15,20)
INSERT INTO CLUBLIST VALUES(3,'A',5,12)
INSERT INTO CLUBLIST VALUES(3,'B',12,20)
INSERT INTO CLUBLIST VALUES(3,'C',8,15)

SELECT club, SUM(projects)
  FROM CLUBLIST c1
 WHERE (SELECT SUM(students)
 		  FROM CLUBLIST c2
		 WHERE c1.club = c2.club
		 GROUP BY club) >= 10
 GROUP BY club

SELECT club, SUM(students)
  FROM CLUBLIST
 GROUP BY club