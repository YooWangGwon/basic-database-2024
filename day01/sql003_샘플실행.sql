-- file : sql003_예제DB_샘플실행.sql
-- date : 240328
-- desc : 샘플 실행

-- 책 중에서 '축구의 역사'라는 도서의 출판사와 가격을 알고싶어
-- dbo는 DataBase Owner라는 뜻 -> 데이터의 소유자
-- DML(4가지) 중 SELECT(조회)
SELECT publisher, price --키워드로 들어갈 파란색 글자는 모두 대문자로
  FROM Book
 WHERE bookname = '축구의 역사';

 /*
 - SQL에서는 equal연산자에 == 사용 안함. 무조건 =
 - SQL에서는 문자열에 " 사용 안함. 무조건 '
 - SQL에서는 대소문자 구분없음. but 키워드는 대문자로 사용할 것
 - SQL에서는 ;이 필수가 아님. 하지만, 중요한 사항에서는 사용할 것
 */

 -- 김연아 고객의 전화번호를 찾으시오
 -- 모든 데이터 : *
 -- 1 step
 SELECT * /* All 이라고 호칭 */
   FROM Customer;

-- 2 step(1 step에서 수정)
SELECT *
  FROM Customer
 WHERE [name] = '김연아'; --[]:키워드가 아님을 의미

 -- 3 step(2 step에서 수정)
SELECT phone
  FROM Customer
 WHERE [name] = '김연아'; --[]:키워드가 아님을 의미

 SELECT *
   FROM Customer
  WHERE [name] = '김연아';