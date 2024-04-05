-- file : sql30_인덱스예제.sql
-- date : 240405
-- 인덱스 예제

USE basic2024
GO
-- 유저 테이블
CREATE TABLE Users (
	userid BIGINT IDENTITY(1,1) NOT NULL, -- 유저 아이디 IDENTITY(1,1) 자동증가 insert문에 values에 추가할 필요 없음
	username NVARCHAR(40) NOT NULL, -- 유저 이름
	guildno INT DEFAULT 0,
	regdate DATETIME DEFAULT GETDATE() -- 등록일시
);

-- 인벤토리 테이블 생성
CREATE TABLE Inventory(
	itemno BIGINT IDENTITY(1,1) NOT NULL,
	userid BIGINT NOT NULL,
	itemid INT NOT NULL,
	regdate DATETIME DEFAULT GETDATE()

);

COMMIT

-- 5000만건 더미데이터 생성
DECLARE @i INT;
SET @i = 0;

WHILE (@i < 50000000)
BEGIN
	SET @i = @i + 1;
	INSERT INTO Users (username, guildno, regdate)
	VALUES (CONCAT('user', @i), @i/100, DATEADD(dd, -@i/100, GETDATE()));
END;

SELECT *	
  FROM Users;

-- 완전히 삭제
TRUNCATE Table Users; -- 1부터 초기화