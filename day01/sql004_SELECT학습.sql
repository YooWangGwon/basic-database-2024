-- 모든 도서의 이름과 가격을 검색하시오
-- ctrl + shift + U -> 대문자로 변경, ctrl + shift + L -> 소문자로 변경
SELECT bookname, price
  FROM Book;

-- 모든 도서의 가격과 이름을 검색하시오
-- 쉼표로 속성의 순서를 변경할 수 있음
-- 컴퓨터 상에 저장된 영구적 데이터 테이블/메모리 상에 임시로 저장된 데이터 테이블
SELECT price, bookname 
  FROM Book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT *
  FROM Book;

-- 실무에서는 속성, 컬럼명을 다 적는게 일반적.
SELECT Bookid, Bookname, publisher, price 
  FROM Book;

-- 도서에서 출판사를 검색하시오.(중복제거)
-- ALL : 중복 포함 출력(default, 입력할 필요 없음), DISTINCT : 중복제거 출력
-- DISTINCT는 중복을 제거할 수 있는 컬럼에서만 사용가능
-- 중복값이 없는 bookname을 함께 검색할 경우 작동하지 않음
SELECT DISTINCT publisher
  FROM Book;

-- 조건 검색(조건 연산자)
-- 가격이 20,000원 미만인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE price < 20000;
 
-- 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE price >= 10000 and price <= 20000;

SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000;

-- 출판사가 굿스포츠와 대한미디어인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher IN('굿스포츠','대한미디어');

-- 출판사가 굿스포츠와 대한미디어가 아닌 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher NOT IN('굿스포츠','대한미디어');

 -- 축구의 역사를 출판한 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname = '축구의 역사';

 -- 도서 이름 중에 축구가 들어간 포함된 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%'; -- 축구라는 글자로 시작하는

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구'; -- 축구라는 글자로 끝나는

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구%'; -- 축구라는 글자가 들어간 모든 도서	

-- 도서이름이 두 글자에 '구'로 끝나는 단어로 시작되는 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '_구%'; -- _(무슨글자는 상관없이 한글자)구라는 글자로 시작하는