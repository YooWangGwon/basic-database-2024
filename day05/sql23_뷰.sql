-- file : sql23_뷰.sql
-- date : 240403
-- desc : 뷰

-- 고객명과 책 이름을 같이 볼 수 있는 뷰를 만들어라
CREATE VIEW v_orderdetail
    AS
SELECT o.orderid
     , o.custid
     , c.[name]
     , o.bookid
     , b.bookname
     , o.saleprice
     , b.price
     , o.orderdate
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid;

-- 대한민국 고객으로 구성된 뷰를 만드시오
CREATE VIEW v_kcustomer
    AS
SELECT *
  FROM Customer
 WHERE [address] LIKE '%대한민국%';

--  조회
SELECT *
  FROM v_kcustomer;

-- 뷰로도 삽입, 수정,삭제가 가능
-- 하나의 테이블의 모든 컬럼을 가져와서 만들었기 때문
INSERT INTO v_kcustomer
VALUES (6,'손흥민','대한민국 강원도','010-1234-5432');

-- JOIN으로 만든 뷰는 삽입, 수정, 삭제가 불가
INSERT INTO v_orderdetail
VALUES (11, 6, '손흥민', 1, '축구의역사', 6500, 7000, '2024-04-03');

-- BUT 뷰에는 되도록 삽입, 수정, 삭제를 하지 말 것!!

-- 뷰 삭제
DROP VIEW v_kcustomer;

-- 시스템 뷰, DBMS가 미리 만들어 놓은 뷰들
SELECT * FROM sys.databases; -- 내 컴퓨터의 데이버베이스에 있는 db종류

-- Book 테이블의 컬럼(속성)들을 확인
-- 테이블 내에 존재하는 컬럼명 조회
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'Book';