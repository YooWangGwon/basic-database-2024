-- file : sql24_Index.sql
-- date : 240403
-- desc : 인덱스

-- 인덱스 : 책의 목차와 기능이 동일
-- Book의 bookname 열에 넌클러스티링 인덱스 IX_Book_bookname을 생성하시오.
CREATE INDEX IX_Book_bookname ON Book(bookname);

-- Customer의 name 열에 클러스터링 인덱스 CIX_Customer_name을 생성하시오.
-- 일반적으로 기본키에 클러스터드, 나머지 컬럼에는 넌클러스터드 인덱스 설정
-- 모든 테이블에 클러스터형 인덱스는 테이블당 한개 뿐이다. 
-- 클러스터형 인덱스가 있는 상태에서 새로운 클러스터형 인덱스를 생성할 경우, 기존 클러스터형 인덱스는 비클러스터형 인덱스로 변경된다.
CREATE CLUSTERED INDEX CIX_Customer_name ON Customer(name);

-- Book에 publisher, price 동시에 인덱스 IX_Book_pubprice 인덱스를 생성하시오.
CREATE INDEX IX_Book_pubprice ON Book(publisher, price);

-- 인덱스 재구성
-- PK인 기본키는 값이 추가되면  자동으로 인덱스 재구성
-- 넌클러스티드 인덱스는 재구성 필요할 수 있음(DBA 정기적으로...)
-- IX_Book_pubprice를 재구성하라.
ALTER INDEX IX_Book_pubprice ON Book REBUILD; 
ALTER INDEX IX_Book_pubprice ON Book REORGANIZE; -- 인덱스 재정리 

-- 인덱스 삭제
DROP INDEX IX_BOOK ON Book;
DROP INDEX CIX_Customer_name ON Customer;
