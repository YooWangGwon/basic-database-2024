-- file : sql31_인덱스예제.sql
-- date : 240408
-- 인덱스 예제

-- 지난주에 잘못 만든 데이터를 전부 초기화
-- 삭제

DELETE FROM Users; -- WHERE 절이 없으면 모두 삭제
-- 단, identity(1,1)로 설정한 테이블에서 1부터 다시 넣도록 설정하려면

TRUNCATE TABLE Users; --identity를 다시 1부터 시작
-- 모두 지우고 테이블 초기화까지

-- 200만건으로 줄여서 다시 시작
DECLARE @i INT;
SET @i = 0;

WHILE (@i < 20000000)
BEGIN
	SET @i = @i + 1;
	INSERT INTO Users (username, guildno, regdate)
	VALUES (CONCAT('user', @i), @i/100, DATEADD(dd, -@i/100, GETDATE()));
END;

-- 인덱스가 없는 상태에서 조회

SELECT *
  FROM Users -- 200만개의 데이터를 조회하는데 8초가량 소요
 WHERE Username LIKE 'user1%'; -- WHERE절에 붙여서 조회하니 4초가량 소요

-- 인덱스가 있는 상태에서 조회
-- 인덱스를 걸리 위해서 uesrid에 기본키(PK)를 설정
ALTER TABLE Users ADD PRIMARY KEY(userid);

-- PK에 클러스터드 인덱스가 걸림
-- ! WHERE에 검색을 위해서 userename을 사용함
-- 인덱스를 PK에 거는게 아니라 username에 걸어야함
-- WHERE절에 넣는 검색조건에 따라 index를 다르게 설정
CREATE CLUSTERED INDEX IX_Users_username ON Users(username)

DROP INDEX IX_Users_username ON Users

-- 인덱스는 대량의 데이터에서 찾고자하는 데이터를 빨리 찾게 해주려는 목적
-- WHERE절, JOIN ON 절에 들어가는 컬럼에 인덱스를 설정하는게 속도 개선에 도움이 됨
-- 1번 PK(기본키), 2번 FK(외래키), 3번 WHERE절에 검색시 들어가는 컬럼에 인덱스를 설정
-- 단, NULL값이 많거나 중복이 많은 컬럼에 인덱스를 걸면 성능에 도움받지 않음