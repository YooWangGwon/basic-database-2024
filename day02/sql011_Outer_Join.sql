-- file :
-- date : 240329
-- desc : 외부조인(OUTER JOIN)

-- LEFT OUTER JOIN VS RIGHT OUTER JOIN

SELECT *
  FROM TableA A
  LEFT OUTER JOIN TableB B
	ON A.key = B.key;

-- 같은 의미의 쿼리
SELECT*
  FROM TableB B
 RIGHT OUTER JOIM TableA A
	ON A.key = B.key;