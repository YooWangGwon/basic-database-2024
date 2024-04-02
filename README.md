# basic-database-2024
부경대학교 2024 IoT 개발자 과정 SQLServer 학습 리포지토리

## 1일차(24.03.28)
- MS SQL Server  설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 : 개발자(Developer) 버전으로 설치
        - ISO 다운로드 후 설치 추천(설치툴에서 바로 설치하는 것은 권장하지 않음)
        - 설치시 SQL Server에 대한 Azure 확장은 비활성화
        - 기능 선택

        ![기능선택](https://raw.githubusercontent.com/YooWangGwon/basic-database-2024/main/images/db001.png)


        - 데이터 베이스 엔진 구성부터 중요
            - Windows 인증 모드로 하면 기본적으로 외부에서 접근불가
            - 혼합모드(sa)에 대한 암호를 지정 / mssql_p@ss(8자 이상/대소문자 구분/특수문자 1자 이상 포함)
            - 데이터루트 디렉토리는 변경

    - 개발툴 설치 : https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16
        - SSMS(SQL Server Management Studio) : 
            - DB에 접근해서 여러 개발 작업을 할 수 있는 툴
            - 사용가능한 언어까지 내려가서 한국어 버전으로 설치

- 데이터베이스 시스템

    - 데이터, 정보, 지식
        - 데이터(Data) : 관찰의 결과로 나타난 정략적 혹은 정성적인 실제 값
        - 정보(Information) : 데이터에 의미를 부여한 것
        - 지식(Knowledge) : 사물이나 현상에 대한 이해

    - 데이터 베이스 개념
        - 데이터를 보관, 관리, 서비스하는 시스템
        - 조직에 필요한 정보를 얻기 위해 논리적으로 연관된 데이터를 모아 구조적으로 통합해 놓은 것
        - 검색과 변경 작업을 주로 수행
            - 변경 : 시간에 따라 변하는 데이터 값을 데이터 베이스에 반영하기 위해 수행하는 삽입, 삭제, 수정 등의 작업
            - 검색과 변경 빈도에 따른 데이터 베이스 유형

        - 검색과 변경 빈도에 따른 데이터 베이스 유형
            - 유형 1 : 검색과 변경 빈도가 낮음, 데이터베이스를 구축할 필요 없음. 보존가치가 있는 경우에 구축(예:공룡 데이터베이스)
            - 유형 4 : 검색과 변경 빈도가 높음, 사용자수가 많고 검색 빈도 및 거래로 인한 변경도 많음(예:증권 데이터베이스)
        - DBMS > Database > Data(Model)
        
    - DBMS
        - 사용자와 데이터 베이스를 연결시켜주는 소프트웨어
        - 데이터베이스 사용자가 데이터베이스를 생성, 공유, 관리할 수 있도록 지원해주는 총체적인 역할
        - DBMS의 장점
            - 데이터 중복 최소화
            - 데이터 일관성 유지(중복 제거)
            - 데이터 독립성 유지
            - 관리 기능 제공
            - 프로그램 개발 생상선 향상
            - 기타(데이터 무결성 유지, 데이터 표준 준수 용이)

    - DB 언어
        - SQL(Structured Query Language) : 구조화된 질의 언어(객체지향 언어 X)
            - DDL(Data Definition Language) - 데이터 베이스, 테이블, 인덱스 생성
                - 테이블이나 관계의 구조를 생성하는데 사용
                - CREATE, ALTER, DROP문 등

            - DML(Data Manipulation Language) - 검색(SELECT), 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 등의 기능 제공(중요!)
                - 테이블에 데이터를 검색, 삽입, 수정, 삭제하는데 사용
                - SELECT, INSERT, DELETE, UPDATE문 등

            - DCL(Data Control Language) - 보안, 권한 부여(GRANT)/제거(DELETE) 기능
                - 데이터의 사용 권한을 관리하는데 사용
                - GRANT, REVOKE문 등

            - TCL(Transaction Control Language)
                - 트랜스액션(트랜잭션)을 제어하는 기능. COMMIT,  ROLLBACK
                -  원래는 DCL의 일부, 기능이 특이해서 TCL로 분리

    - 데이터 모델
        - 계층 데이터 모델(hierarchical data model)
        - 네트워크 데이터 모델(network data model)
        - 객체 데이터 모델(object data model)
        - 관계 데이터 모델(relational data model) -> 가장 많이 쓰임(!)
        - 객체 - 관계 데이터 모델(object-relational data model) -> 관계 데이터 모델과 객체 데이터 모델의 장점을 결합한 모델

    - 데이터 베이스의 개념적 구조
        - 외부 스키마 (External schema)
            - 사용자가 보는 데이터
            - 서브 스키마, 뷰(view)의 개념

        - 개념 스키마 (Conceptual schema)
            - 전체 데이터베이스의 정의
            - 통합 조직별로 하나만 존재, DBA(DataBase Administrator)가 관리
            - 하나의 데이터 베이스에는 하나의 개념 스키마가 있음

        - 내부 스키마 (Internal schema)
            - 물리적 저장 장치에 데이터베이스가 실제로 저장되는 방법의표현
            - 내부 스키마는 하나

    - 데이터 베이스의 구조
        - 네모난 사각형이 줄 긋고 위에 있는 내용은 Key
        - PK(Primary Key:기본키) : 무조건 줄 위에 있어야함. Unique하고 NULL이 되선 안된다(Not NULL).
        - FK(Foreign Key:외래키) : 줄 위, 줄 밑에도 있을 수 있음.

- SQL 기본학습
    - SSMS 실행

    ![SSMS로그인](https://raw.githubusercontent.com/YooWangGwon/basic-database-2024/main/images/db002.png)

    - 특이사항 : SSMS 쿼리창에서 소스코드 작성시 빨간색 오류 밑줄이 가끔 표현(전부 오류는 아님!)

    - SSMS 사용
        - 데이터베이스 생성/ 최초에 새로운 DB를 생성할 때에는 master(기본)에서 생성해야함
        - USE : 해당 DB를 사용하겠다는 의미
        - C++ 동일하게 한 문장 끝은 ;을 붙여야한다.(생략 가능)
        - GO명령어 : T-SQL 문은 아니고, 현재까지 명령어를 SQL Server에 보내서 실행시키는 역할
            -> 명령어를 묶어서 배치로 서버에 보내는 역할
        - ctrl + shift + U -> 대문자로 변경, ctrl + shift + L -> 소문자로 변경
    
    - C/C++과 SQL의 차이
        - SQL에서는 equal연산자에 == 사용 안함. 무조건 = 만 사용
        - SQL에서는 문자열에 " 사용 안함. 무조건 ' 만 사용
        - SQL에서는 대소문자 구분없음. but 키워드는 대문자로 사용    
        - SQL에서는 ;이 필수가 아님. 하지만, 중요한 사항에서는 사용할 것
    
- DML 학습
    - SQL 명령어 키워드 : SELECT, INSERT, UPDATE, DELETE
    - IT개발 표현언어 : Request, Create, Update, Delete(CRUD로 부름. CRU개발 뜻  INSERT, UPDATE, SELECT를 할 수 있는 기능을 개발하라는 뜻)
    - SELECT
        ```sql
        SELECT [ALL | DISTINCT] 속성이름(들) -- ALL:중복포함, DISTINCT:중복제거
          FROM 테이블이름(들)
        [WHERE 검색조건(들)] -- 대괄호 안의 내용들은 생략가능
        [GROUP BY 속성이름(들)]
        [HAVING BY 속성이름(들)]
        [ORDER BY 속성이름(들) [ASC|DESC]]
        ```
    - SELECT문 학습
        - 기본, 조건검색 학습 중

## 2일차(24.03.29)
- Datbase 학습
    - DB 개발시 사용할 수 있는 툴
        - SSMS(기본)
        - Visual Studio - 아무런 설치 없이 개발 가능
        - Visual Studio Code - SQL Server (mssql)플러그인  설치하고 사용
    - Servername(Hostname) - [내 컴퓨터 이름|내 네트워크 주소|127.0.0.1(LoopBack IP)|localhost(LoopBack URL)] 중에서 선호하는거 아무거나
    - 관계 데이터 모델

- 관계 데이터 모델
    - 관계 데이터 모델의 개념
        - 릴레이션(relation) : 행과 열로 구성된 테이블
            - 릴레이션 내에서 새성되는 관계 : 릴레이션 내 데이터들의 관계
            - 릴레이션 간에 생성되는 관계 : 릴레이션 간의 관계
            - 관계의 화살표 시작점은 부모, 종착점은 자식

        - 릴레이션 스키마와 인스턴스
            - 릴레이션 스키마 : 릴레이션에 어떤 정보가 담길지 정의
                - 속성(attribute) : 릴레이션 스키마의 열
                - 도메인(domain) : 속성이 가질 수 있는 값의 집합(예시:4년제 대학교의 학년 도메인은 1~4학년만 들어갈 수 있다.)
                - 차수(degree) : 속성의 개수

            - 릴레이션 인스턴스 : 스키마에 실제로 저장된 데이터의 집합
                - 튜플(tuple) : 릴레이션의 행
                - 카디널리티(cardinality) : 튜플의 수
            
            - 실제 DB와 파일 에서 매핑되는 이름
                - 릴레이션 : 테이블, 파일
                - 튜플 : 행(row), 레코드
                - 속성 : 열(column), 필드
                - 스키마 : 내포(intension), 헤더
                - 인스턴스 : 외연(extension), 데이터

        - 릴레이션의 특징
            1. 속성은 단일 값을 가진다.(책 이름이 여러개 들어가면 안됨)
            2. 속성은 서로 다른 이름을 가진다.(책 이름이라는 속성이 두번 있으면 안됨)
            3. 속성의 값은 정의된 도메인 값을 가진다.(4년제 대학교에 5학년이 있으면 안됨)
            4. 속성의 순서는 상관없다.
            5. 릴레이션 내의 중복된 튜플은 허용하지 않는다(같은 책 정보를 두번 넣을 수 없음)
            6. 튜플의 순서는 상관없다. 

        - 관계 데이터 모델
            - 관계 데이터 모델은 데이터를 2차원 테이블 형태인 릴레이션(relation)으로 표현
            - 릴레이션에 대한 제약조건(constraints)과 관계 연산을 위한 관계대수(relational algebra)를 정의함
            - 구성요소 : 릴레이션, 제약조건, 관계대수 

    - 무결성 제약 조건

- DML 학습
    - SELECT문 학습
        - 복합조건(WHERE)
        ```sql
        -- 도서 중 축구에 관하고, 가격이 20,000원 이상인 책을 조회
        SELECT bookid
	         , bookname
	         , publisher
	         , price
          FROM Book
         WHERE bookname LIKE '%축구%'
	       AND price >= 20000;

        -- 출판사 굿스포츠 혹은 대한미디어 인 도서 검색
        SELECT *
          FROM Book
         WHERE publisher = '굿스포츠'
            OR publisher = '대한미디어';
        ```

        - 정렬(ORDER BY)
        ```sql
        -- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색
        SELECT *
          FROM Book
         ORDER BY price ASC,bookname DESC;

        -- 도서를 가격순으로 검색하고, 가격이 같으면 출판사명 내림차순으로 검색
        SELECT *
        FROM Book
        ORDER BY price ASC,publisher ASC;
        ```
        - 집계함수와 GROUP BY
            - 집계 함수
                - SUM(총합), AVG(평균), MIN(최소값), MAX(최대값), COUNT(개수)
                - COUNT를 제외한 집계함수들은 *(ALL)를 사용할 수 없음
            ```sql
            -- 고객이 주문한 도서의 총 판매액
            -- 의미있는 열 이름을 출력하고 싶으면 속성이름의 별칭을 지칭하는 AS워키워드를 사용
            SELECT sum(saleprice) AS [총 매출] -- '' 나 []로 감싸거나 감싸지 않아도 되지만 감싸지 않을 경우에는 스페이스를 써선 안된다. 
            FROM Orders;

            SELECT COUNT(saleprice) AS [주문개수]
                , SUM(saleprice) AS [총 판매액]
                , AVG(saleprice) AS [판매액 평균]
                , MIN(saleprice) AS [주문도서 최소금액]
                , MAX(saleprice) AS [주문도서 최대금액]
            FROM Orders
            ```

            - GROUP BY
                - 필요한 조건으로 그룹핑을 해서 결과(통계)를 내기 위함
                - 집계 함수 없이는 GROUP BY를 사용할 수 없음
                - 집계함수 외 일반컬럼은 GROUP BY절에 들어있는 컬럼만 SELECT문 사용 가능
            ```sql
            SELECT custid
                 , SUM(saleprice) '총판매액'
                 , COUNT(saleprice) AS '구매횟수'
                 , AVG(saleprice) AS '평균판매액'	-- custid로 GROUP BY를 했다면 custid와 집계 함수 결과만 출력 할 수 있다.
              FROM Orders
             GROUP BY custid;
            ```

            - HAVING
                - HAVING은 집계함수의 필터로 GROUP BY보다 뒤에, WHERE절보다 뒤에 작성
                - WHERE절과 필터링이 다름 -> 검색조건에 무조건 집계함수(SUM, AVG, MAX, MIN, COUNT)가 나와야함.
            ```sql
            SELECT custid, COUNT(*) AS '구매수'
              FROM Orders
             WHERE saleprice >= 8000
             GROUP BY custid
            HAVING COUNT(*) >= 2;
            ```
        
        - 내부조인(Inner Join)
            - 두개 이상의 테이블 질의
            - 관계형 DB에서 가장 중요한 기법 중 하나 : JOIN
            ```sql
            SELECT c.custid
                 , c.[name]
                 , c.phone
                 , o.orderdate
                 , o.saleprice
              FROM Customer AS c, Orders AS o -- 각 테이블의 별명으로 줄여서 쓰는게 일반적
             WHERE c.custid = o.custid
             ORDER BY c.custid ASC;

            SELECT <열 목록>
              FROM <첫 번째 테이블>
             INNER JOIN <두 번째 테이블>
                ON <조인 조건>
            [WHERE 검색 조건]
            ```
            - LEFT|RIGHT OUTER JOIN(외부조인) - 어느 테이블이  기준인지에 따라서 결과가 상이함
                - [학습참조]:https://sql-joins.leopard.in.ua/

            ![외부조인](https://raw.githubusercontent.com/YooWangGwon/basic-database-2024/main/images/db004.png)

## 3일차(24.04.01)
- Database 학습
    - 관계 데이터 모델
        - 무결성 제약조건
            - 키
                - 키(Key) 
                    - 릴레이션에서 특정 투플을 식별할 수 있는 속성 혹은 속성의 집합
                    - 키가 되는 속성은 반드시 값이 달라서 투플들을 서로 구분할 수 있어야함
                    - 키는 릴레이션 간의 관계를 맺는 데도 사용
                
                - 슈퍼키(super key)
                    - 투플을 유일하게 식별할 수 있는 하나의 속성 혹은 속성의 집합(고객번호 | 주민번호 | 고객번호,이름 | 고객번호|주소 | 고객번호/이름/전화번호 | 이름 속성만으로는 불가능!)
                    - 투플을 유일하게 식별할 수 있는 값이면 모두 수퍼키가 될 수 있음

                - 후보키(candidate key)
                    - 투플을 유일하게 식별할 수 있는 속성의 최소 집합(고객번호 | 주민번호)
                    - 복합키(composite key) : 후보키 중 속성을 2개 이상 집합으로 한 키

                - 기본키(Primary Key) ★★★
                    - 여러 후보키 중 하나를 선정하여 대표로 삼는 키(고객번호)
                    - 후보키가 하나라면 그 후보키를 기본키로 사용, 후보키가 여러개면 릴레이션의 특성을 반영하여 하나를 선택
                    - 기본키 선정시 고려사항
                        - 릴레이션 내 투플을 식벽할 수 있는 고유한 값을 가져야함
                        - NULL 값은 허용하지 않음
                        - 키값의 변동이 일어나선 안됨
                        - 최대한 적은 수의 속성을 가진 것이어야 함
                        - 향후 키를 사용하는 데 있어서 문제 발생 소지가 없어야 함 -> 개인정보 등의 보안사항은 사용을 자제

                - 대리키(surrogate key)
                    - 기본키에 보안을 요하거나 여러개의 속성으로 구성되어 복잡한 경우, 또는 마땅한 기본키가 없을 때, 일련번호 같은 가상의 속성을 만들어 기본키로 삼는 것
                    - 인조키(artificial key)라고도 함
                    - 대리키는 DBMS나 관련 소프트웨어에서 임의로 생성하는 값으로 사용자가 직관적으로 그 값의 의미를 알 수 없음

                - 대체키(alternate key) : 기본키로  선정되지 않은 후보키

                - 외래키 (foreign key) ★★★
                    - 다른 릴레이션의 기본키를 참조하는 속성
                    - 다른 릴레이션과의 관계
                    - 다른 릴레이션의 기본키를 호칭
                    - 고려사항
                        - 서로 같은 값이 사용되야 함
                        - 기본키가 변경되면 외래키도 변경되어야 함
                    - 반드시 NOT NULL은 아님. -> NULL과 중복을 허용
                    - 기본키를 가져와서 쓰지만 기본키의 특성을 가지진 않음
                    - 자기 자신의 기본키를 외래키로 사용할 수 있음
                    - 외래키가 기본키의 속성 중 하나가 될 수 있음

            - 무결성 제약조건
                - 데이터 무결성(Integrity) : 데이터베이스에 저장된 데이터의 일관성과 정확성을 지키는 것

                - 도메인 무결성 제약조건(Domain integrity constraint)
                    - 데이터 타입, NOT NULL, 기본값, 체크 특성을 지키는 것
                    - 투플들이 각 속성의 도메인에 지정된 값 만을 가져야함

                - 개체 무결성 제약조건(Entity integrity constraint)
                    - 기본키 제약조건으로도 부름 
                    - <U>기본키는 Unique이자 NOT NULL이어야 함(값이 중복되어서도, 빠져도 안됨)</U>

                - 참조 무결성 제약조건(Referential integrity constraint)
                    - 외래키 제약조건으로도 부름
                    - 자식 릴레이션은 부모의 키가 아닌값은 사용할 수 없음 -> 자식 릴레이션의 외래키는 부모키의 기본키와 도메인이 같아야함
                    - 외래키가 바뀔 때 기본키의 값이 아닌 것은 제약을 받음
                    - 참조무결성 제약조건의 옵션
                        - RESTIRCTED : 자식 릴레이션에서 참조하고 있으면 부모 릴레이션의 삭제 작업을 거부
                        - CASCADE : 자식 릴레이션의 관련 투플을 같이 삭제
                        - DEFAULT : 자식 릴레이션의 관련 투플을 미리 설정해둔 값으로 변경
                        - NULL : 자식 릴레이션의 관련 투플을 NULL 값으로 설정

                - 유일성 제약조건(Unique constraint)
                    - 일반 속성의 값이 중복되어선 안됨
                    - NULL은 허용

- DML 학습
    - SELECT문
        - OUTER JOIN(외부조인)
            - LEFT OUTER JOIN : 좌측 테이블을 기준으로 조건에 일치하지 않는 좌측 테이블 데이터도 모두 표시
            - RIGHT OUTER JOIN : 우측 테이블을 기준으로 조건에 일치하지 않는 우측 테이블 데이터도 모두 표시
            - FULL(거의 사용하지 않음)

        - 부속질의(SubQuery)
            - 쿼리 내에 다시 쿼리를 작성하는 것
            - 서브 쿼리를 쓸 수 있는 장소 -> 쓰는 장소마다 내용이 조금씩 다름
                - SELECT 절 - 한 컬럼에 하나의 값만 사용가능
                ```sql
                SELECT o.orderid
                     , o.custid
                     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
                     , o.bookid
                     , (SELECT bookname FROM Book WHERE bookid = o.bookid) AS '도서명'
                     , o.saleprice
                     , o.orderdate
                  FROM Orders AS o
                ```
                - FROM 절 - 가상의 테이블로 사용
                ```sql
                SELECT DISTINCT bookname
                  FROM (
                        SELECT b.bookid
                             , b.bookname
                             , b.publisher
                             , o.orderdate
                             , o.orderid
                          FROM Book AS b, Orders AS o
                         WHERE b.bookid = o.bookid
                       ) AS t
                ```
                - WHERE 절 - 여러 조건에 많이 사용
                ```sql
                SELECT [name] AS '고객명'
                  FROM Customer
                  WHERE custid IN(SELECT custid
                                    FROM Orders
                                   WHERE bookid IN (SELECT bookid
                                                      FROM Book
                                                     WHERE publisher = '대한미디어'));
                ```

        - 집합연산 - JOIN도 집합이지만, 속성별로 가로로 병합하기 때문에 집합이라 부르지 않음. 집합은 데이터를 세로로 합치는 것을 뜻함
            - 차집합(EXCEPT, 사용빈도 낮음) - 하나의 테이블에서 교집합 값을 뺀 나머지
            - 합집합(UNION, 사용빈도 높음) - UNION(중복제거), UNION ALL(중복허용)
            - 교집합(INTERSECT, 사용빈도 낮음) - 두 테이블에 모두 존재하는 값
            - EXISTS - 데이터 자체의 존재여부

- DDL 학습 - SSMS에서 마우스로 조작이 편리
    - CREATE : 개체(데이터베이스, 테이블, 뷰, 사용자 등등)를 생성하는 구문.
        ```sql
        -- 테이블 생성에 한정
        CREATE TABLE 테이블명
        ({속성이름 데이터타입
            [NOT NULL]
            [UNIQUE]
            [DEFAULT 기본값]
            [CHECK 체크조건]
        }
            [PRIMARY KEY 속성이름(들)]
            {[FOREIGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
                 [ON UPDATE[NO ACTION | CASADE | SET NULL | SET DEFAULT]]
            }
        )
        ```
    - ALTER : 개체를 변경(수정)하는 구문
        ```sql
        ALTER TABLE 테이블명
            [ADD 속성이름 테이터타입]   -- 새로운 컬럼(추가) 추가
            [DROP COLUMN 속성이름] -- 컬럼(속성) 삭제
            [ALTER COLUMN 속성이름 데이터타입]  -- 컬럼(속성)의 데이터 타입 변경
            [ALTER COLUMN 속성이름 [NULL | NOT NULL]]   -- 컬럼(속성)의 NULL 속성 변경
            [ADD PRIMARY KEY(속성이름)] -- 기본키가 없었는데 추가할 때
            [[ADD|DROP] 제약조건 이름];
        ```
    - DROP : 개체를 삭제하는 구문
        ```sql
        DROP TABLE 테이블명;
        ```

        - 외래키로 사용되는 기본키가 있으면, 외래키를 사용하는 테이블 삭제 후, 기본키의 테이블을 삭제해야 함

## 4일차(24.04.02)
- 관계 데이터 모델
    - 관계대수 : 릴레이션에서 원하는 결과를 얻기 위한 수학의 대수와 같은 연산 사용 기술하는 언어
        - 셀렉션(selection)
        - 프로젝션(projection)
        - 조인(join)
        - 집합
        - 카티션 프로덕트(cartesian product)
            - 두 릴레이션을 연결시켜 하나의 합칠 때 사용
            - 첫 번째 릴레이션의 오른쪽에 두 번째 릴레이션의 모든 투플을 순서대로 배열하여  반환
            - 기호는 'X'를 사용하며 속성과 도메인이 같을 필요는 없음
            - 결과 릴레이션의 차수는 두 릴레이션의 차수의 합, 카디널리티는 두 릴레이션의 카디널리티의 곱  

- DML 학습(SELECT외)
    - INSERT : 테이블에 새로운 투플을 삽입하는 명령

    ```sql
    INSERT INTO 테이블이름 [(속성리스트)]
        VALUES (값리스트);
    ```
    - UPDATE : 특정 속성값을 수정하는 명령

    ```sql
    -- 트랜잭션을 걸어서 항상 복구를 대비
    UPDATE 테이블이름
        SET 속성이름 1= 값1[, 속성이름2 = 값2...]
        WHERE <검색조건>; -- 실무에서는 빼면 안됨. 
    ```
    - DELETE : 테이블에 있는 기본 투플을 삭제하는 명령
    ```sql
    -- 트랜잭션을 걸어서 항상 복구를 대비
    DELETE FROM 테이블이름
     WHERE <검색조건> -- 실무에서는 빼면 큰일남 
    ```

- SQL 고급
    - 내장함수
        - 내장함수(built-in function) : DBMS가 제공하는 함수
            - 숫자함수, 문자열함수, 날짜/시간 함수, 변환함수 etc
            - 숫자함수
                - ABS() : 절대값
                - CEILING() : 올림
                - FLOOR() : 내림
                - ROUND() : 반올림
                - POWER() : 제곱

            - 문자 함수
                - REPLCAE() : 특정문자변경
                - FORMAT() : 문자열의 형식
                - LEN() : 문자열의 길이
                - LOWER(), UPPER() : 대소문자변환
                - LTRIM(), RTRIM(), TRIM() : 공백제거
                - SUBSTRING() : 특중위치의 일정 개수의 문자 리턴
                - CHARINDEX() : 문자 찾기

            - 날짜 및 시간함수
                - GETDATE() : 현재의 시간
                - DAY() : 일
                - MONTH() : 월
                - YEAR() : 년
                - DATEADD() : 기간 추가

        - NULL값 처리
            - 다음 내장 함수의 결과 NULL값이란?
                - 아직 지정되지 않은 값
                - NULL값은 '0','(빈문자)','(공백)' 등과는 다른 특별한 값
                - NULL 값은 비교연산자로 비교 불가
                - NULL 값에 연산을 적용하면 결과 역시 NULL값
            
            - 집계함수를 사용할 때 주의할 점
                - 'NULL + 숫자' 연산의 결과는 NULL
                - 집계 함수 계산 시 NULL이 포함된 행은 집계에서 빠짐
                - 해당되는 행이 하나도 없을 경우 SUM, AVG 함수의 결과는 NULL이 되며, COUNT 함수의 결과는 0
            
            - ISNULL() : NULL인 데이터를 다른 값으로 치환 -> 테이블의 값이 변경되는 것은 아님!

    - 서브쿼리 리뷰
        - 부속질의(subquery)
            - 하나의 SQL문 안에 다른 SQL 문이 중접된 nested 질의를 말함
            - 다른 테이블에서 가져온 데이터로 현재 테이블에 있는 정보를 찾거나 가공할 때 사용
            - 보통 데이터가 대량일 때 데이터를 모두 함쳐서 연산하는 조인보다 필요한 데이터만 찾아서 공급해주는 부속질의가 성능이 더 높음
            - 부속질의의 종료
                - 중첩질의(WHERE절) -> 다수행, 단일열
                    - 비교연산(단일행 단일열)
                    - 집합연산(다중행 다중열) : IN, NOT IN
                    - 한정연산(다중행 단일열)
                    - 존재연산(다중행 다중열)
                - 스칼라 부속질의(SELECT절) -> 단일행, 단일열 (스칼라 서브쿼리)
                - 인라인 뷰(FROM절) -> 다수행, 다수열

## 5일차(24.04.03)
- SQL 고급
    - 서브쿼리 리뷰
    - 뷰
    - 인덱스

- 파이썬 SQL Server 연동 프로그래밍
    - PyQT로 GUI 생성
    - SQL Server 데이터 핸들링

- 데이터베이스 모델링