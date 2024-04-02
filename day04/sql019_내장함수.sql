-- file : sql019_내장함수.sql
-- date : 240402
-- desc : 내장함수

/* 수학함수 */
-- 함수의 결과값은 (열이름 없음) 이름 지정이 필요
-- 절대값
SELECT ABS(-5), ABS(5);

-- 올림, 내림, 반올림
SELECT CEILING(4.01) AS '올림'
     , FLOOR(4.4) AS '내림'
     , ROUND(4.5, 1) AS '반올림'
     , POWER(2, 10) AS '제곱';

-- 고객별 평균 주문 금액
SELECT custid
     , SUM(saleprice) AS '고객별 총 주문금액'
     , AVG(saleprice) AS '고객별 평균 주문금액'
     , COUNT(*) AS '고객별 주문수'
     , SUM(saleprice)/COUNT(*) AS '계산한 평균금액'
  FROM Orders
 GROUP BY custid;

/* 문자열함수 */
-- DATABASE는 python, C, C++과 다르게 인덱스가 1부터 시작한다

-- 책 제목에 야구를 농구로 바꿔서 출력
-- FORMAT(VAL, '포맷값')
SELECT bookid
     , REPLACE(bookname, '야구', '농구') bookname -- 함수를 쓰면 열 이름 지정이 필요함
     , publisher
     , FORMAT(price, '#,#') AS price
  FROM Book;

-- LEN() : 글자수
SELECT bookname AS '제목'
     , LEN(bookname) '제목별 길이'
  FROM Book
 WHERE publisher = '굿스포츠';

-- LOWER(), UPPER() : 대소문자
SELECT LOWER('Hello') '소문자'
     , UPPER('hello') '대문자';

-- LTRIM(), RTRIM(), TRIM() : 공백제거
SELECT '|' + LTRIM('     HELLO     ') + '|'
     , '|' + RTRIM('     HELLO     ') + '|'
     , '|' + TRIM('     HELLO     ') + '|';

-- LECT(), RIGHT() , SUBSTRING()
SELECT LEFT('Hello World!',5)
     , RIGHT('Hello World!',6)
     , SUBSTRING('Hello World!',7,5)

-- SUBSTRING : 문자열 중 특정위치에서 시작하여 지정한 길이만큼의 문자열을 반환하는 함수
-- DB는 인덱스가 1부터 시작
SELECT SUBSTRING([name], 1, 1) '성씨'
     , COUNT(*) AS '인원 수'
  FROM Customer
 GROUP BY SUBSTRING([name], 1, 1)

-- CHARINDEX() : 문자 찾기
SELECT CHARINDEX('sql','Microsoft SQL Server 2022'); -- sql의 s가 11번째 글자에서부터 시작해서 11 출력

-- SUBSTRING()과의 연계
SELECT SUBSTRING('Microsoft SQL Server 2022',
               CHARINDEX('sql','Microsoft SQL Server 2022'),
               LEN('sql'));

/* 날짜 및 시간함수 */
SELECT GETDATE();
SELECT YEAR(GETDATE()) '년';
SELECT MONTH(GETDATE()) '월';
SELECT DAY(GETDATE()) '일';

-- 날짜 형태를 원하는 형태로 변경가능
SELECT FORMAT(GETDATE(), 'yyyy-mm-dd') '년월일';
SELECT FORMAT(GETDATE(), 'HH:MM:ss') '시분초';

-- 주문 테이블에서 주문 10일후에 각 주문을 확정짓는다. 확정일자를 출력
-- dd(날짜), mm(달), yy(년), qq(분기), wk(주)
SELECT orderid
     , saleprice
     , orderdate AS '주문일자'
     , DATEADD(dd, 10, orderdate) '확정일자' -- orderdate의 날짜에 10일(dd)이 추가됨
     , DATEADD(mm, 1, orderdate) '통계일자' -- orderdate의 날짜에 1달(mm)이 추가됨
  FROM Orders;

-- TOP n
SELECT TOP 3 orderid, custid, saleprice
  FROM Orders
 ORDER BY saleprice DESC;