-- p.196  3-1

SELECT DISTINCT c.name
  FROM Customer c, Orders o1
 WHERE c.custid = o1.custid
   AND o1.orderid IN (SELECT orderid
					    FROM Orders o2, Book b
					   WHERE o1.custid = o2.custid
						 AND o2.bookid = b.bookid
						 AND b.publisher IN (SELECT DISTINCT b.publisher
											   FROM Book AS b, Orders AS o, Customer AS c
											  WHERE b.bookid = o.bookid
											    AND o.custid = c.custid
											    AND c.[name] = '박지성'))
EXCEPT
SELECT [name]
  FROM Customer
 WHERE [name] = '박지성';

-- p.196  3-2
SELECT DISTINCT c.name
  FROM Customer c, Orders o1
 WHERE c.custid = o1.custid
   AND o1.custid IN (SELECT custid
					   FROM Orders o2, Book b
					  WHERE o1.custid = o2.custid
						AND o2.bookid = b.bookid
					  GROUP BY custid
					 having COUNT(DISTINCT b.publisher) >= 2)

-- p.196  3-3
SELECT b.bookname
  FROM Book as b, Orders as o1
 WHERE b.bookid = o1.bookid
   AND (SELECT COUNT(o2.bookid) AS '판매수'
		  FROM Orders as o2
		 WHERE o1.bookid = o2.bookid
		 GROUP BY bookid)/10 > 0.3;