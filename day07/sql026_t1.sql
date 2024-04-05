
BEGIN TRANSACTION;
USE madang;
SELECT * 
FROM   Book
WHERE  bookid=1;

 

UPDATE Book 
SET    price=7200
WHERE  bookid=1;
-- 1. 일단 여기까지

SELECT * 
FROM   Book
WHERE  bookid=1;

 
COMMIT;
ROLLBACK;