-- file : sql012_외부조인.sql
-- date : 240401
-- desc : 외부조인

-- Customer를 기준으로 Orders테이블과 외부조인하기
SELECT c.custid
      ,c.[name]
      ,c.[address]
      ,c.phone
      ,o.orderid
      ,o.custid -- LEFT OUTER JOIN에서는 이 외래키는 필요X
      ,o.bookid
      ,o.saleprice
      ,o.orderdate
  FROM Customer AS c LEFT OUTER JOIN Orders AS o -- LEFT, RIGHT, FULL 등으로 변경하면서 실행
    ON c.custid = o.custid

-- Inner Join에서는 10개가 출력됨
-- Outer Join에서는 11개가 출력됨 -> 1에서 10번까지는 Customer와 Orders의 교집합, 11번은 Customer만의 값