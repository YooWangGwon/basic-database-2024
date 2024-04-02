-- file : sql018_DML.sql
-- date : 240402
-- desc : DML

-- 1. 삽입(INSERT)
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES (11, '스포츠의학', '한솔의학서적', 90000);

-- 컬럼 순서를 변경

INSERT INTO Book(bookid, bookname, price, publisher)
    VALUES (11, '스포츠의학', 90000, '한솔의학서적');

-- 속성리스트를 생략 가능
INSERT INTO Book
    VALUES (12, '스포츠의학2', '한솔의학서적', 90000);

-- 값을 생략가능(NULL값이 들어감)
INSERT INTO Book(bookid, bookname, publisher)
    VALUES (13, '스포츠의학3', '한솔의학서적');

-- 새 테이블 생성
-- 여기는 3장에서 사용되는 Imported_book 테이블
CREATE TABLE Imported_Book (
  bookid      INT,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INT 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

-- 특수 INSERT(INSERT INTO SELECT 구문) : 한꺼번에 여러개의 투플을 삽입
INSERT INTO Book(bookid, bookname, price, publisher)
     SELECT bookid, bookname, price, publisher
       FROM Imported_Book;

-- 2. 수정(UPDATE)
-- 사전 준비 : 이전의 Customer 테이블의 내용을 CustomerNew로 복사
SELECT custid, [name], [address], phone
  INTO CustomerNew
  FROM Customer

-- Customer 테이블에서 고객번호가 5인 고객의 주소를 대한민국 부산으로 변경
UPDATE Customer
   SET [address] = '대한민국 부산'
 WHERE custid = 5;

-- CustomerNew 에서 고객번호가 5인 고객의 주소를 대한민국 광주로 변경
UPDATE CustomerNew
   SET [address] = '대한민국 광주'
 WHERE custid = 5;

-- Customer 테이블에서 박세리 고객의 주소를 김연아 주소로 변경
UPDATE Customer
   SET [address] = (SELECT [address]
                      FROM Customer
                     WHERE [name] = '김연아')
 WHERE [name] = '박세리';

-- 수정은 여러 컬럼 같이 가능
UPDATE CustomerNew
   SET [name] = '박체리'
     , [address] = '미국 보스턴'
     , [phone] = '+01 010-9999-0000'
 WHERE custid = 5;

-- 수정, 삭제는 항상 트랜잭션과 같이 실행해야 함

-- 3.삭제(DELETE)
DELETE FROM CustomerNew
 WHERE custid = 5;

-- 연습문제
-- 4-1
INSERT INTO Book(bookid,bookname, publisher, price)
    VALUES(14,'스포츠세계','대한미디어',10000)

-- 4-2
DELETE FROM Book
 WHERE publisher = '삼성당'

-- 4-3
-- c참조 제약조건에 걸리기 떄문에 삭제가 불가
DELETE FROM Orders -- '이상미디어' 도서들을 Orders에서 참조하고 있기 때문에 Orders에서 '이상미디어'도서들을 참조하고 있는 투플을 제거
 WHERE bookid IN (SELECT bookid
                    FROM Book
                   WHERE publisher ='이상미디어')

DELETE FROM Book
 WHERE publisher = '이상미디어'

-- 4-4
UPDATE Book
   SET publisher = '대한출판사'
 WHERE publisher = '대한미디어'

UPDATE Book
   SET publisher = '대한출판사'
 WHERE bookid IN (SELECT bookid
                    FROM Book
                   WHERE publisher = '대한미디어')

