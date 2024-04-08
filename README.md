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
                    - **기본키는 Unique이자 NOT NULL이어야 함(값이 중복되어서도, 빠져도 안됨)**

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
        - 스칼라 부속질의(scalar subquery)
            - 스칼라 값(scalar) : 하나의 수치만으로 완전히 표시되는 값
            - SELECT 절에서 사용되는 부속질의, 부속질의의 결과 값을 단일 행, 단일 열의 스칼라 값으로 반환
            - 스칼라 값이 들어갈 수 있는 모든 곳에 사용 가능하며, 일반적으로 SELECT 문과 UPDATE SET 절에 사용
            - 주 질의와 부속질의와의 관계는 상관/비상관 모두 가능
        - 인라인 뷰(inline view)
            - FROM절에서 사용되는 부속질의
            - 테이블 이름 대신 인라인 뷰 부속질의를 사용하면 보통의 테이블과 같은 형태로 사용 가능
            - 부속질의 결과 반환되는 데이터는 다중행, 다중데이터여도 상관없음
            - 가상의 테이블인 뷰 형태로 제공되어 상관 부속질의로 사용할 수는 없음

    - 뷰(view) : 하나 이상의 테이블을 합하여 만든 가상의 테이블
        - 장점
            - 편리성(및 재사용성) : 자주 사용되는 복잡한 질의를 뷰로 미리 정의해 놓을 수 있음 -> 복잡한 질의를 간단히 작성
            - 보안성 : 각 사용자별로 필요한 데이터만 선별하여 보여줄 수 있음. 중요한 질의의 경우 질의 내용을 암호화할 수 있음
                        -> 개인정보(주민번호)나 급여, 건강 같은 민감한 정보를 제외한 테이블을 만들어 사용
            - 논리적 독립성 제공 : 개념 스키마의 데이터베이스 구조가 변하여도 외부 스키마에 영향을 주지 않도록하는 논리적 데이터 독립성 제공

        - 특징
            - 원본 데이터 값에 따라 같이 변함
            - 독립적인 인덱스 생성이 어려움
            - 삽입, 삭제, 갱신 연산에 많은 제약이 따름 

        ```sql
        -- 생성
        CREATE VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문> -- 실제 뷰를 생성할 쿼리문
        
        -- 삭제
        DROP VIEW 뷰이름;
        ```

    - 인덱스(데이터베이스 튜닝)
        - 데이터 베이스의 물리적 저장
            - mdf : 저장되어 있는 실제 데이터 
            - ldf : 해당 데이터베이스에 실행된 쿼리들의 로그(기록)파일

        - 인덱스와 B-tree
            - 인덱스의 필요성
                - 질의 검색 시 data block을 읽는 횟수를 최소화해야함
                - 디스크에 있는 데이터는 메모리에 있는 데이터에 비해 읽는 속도가 10000배 정도 소요됨

            - 인덱스(index, 색인) : 데이터를 쉽고 빠르게 찾을 수 있도록 만든 데이터 구조

            - 인덱스의 특징
                - 인덱스는 테이블에서 한 개 이상의 속성을 이용하여 생성함.
                - 빠른 검색과 함께 효율적인 레코드 접근이 가능
                - 순서대로 정렬된 속성과 데이터의 위치만 보유하므로 테이블보다 작은 공간을 차지함
                - 저장된 값들은 테이블의 부분집합이 됨
                - 일반적으로 B(Balance)-tree 형태의 구조를 가짐
                - 데이터의 수정, 삭제 등의 변경이 발생하면 인덱스의 재구성이 필요

        - 클러스터드 인덱스 : 발생하면 인덱스의 재구성이 필요

        - 인덱스의 생성, 수정, 삭제
            
            ```sql
            -- 생성
            CREATE [UNIQUE] [CLUSETERD|NONCLUSTERED] INDEX 인덱스 이름
            ON 테이블명 (속성이름 [ASC|DESC][,...n]);
            
            -- 수정
            ALTER INDEX {인덱스 이름|ALL}
            ON 테이블명 { REBUILD | DISABLE | REORGANIZE };
            
            -- 삭제
            DROP INDEX 인덱스 이름 ON 테이블명;
            ```
            - SSMS에서 실행계획을 가지고 쿼리 실행 성능을 체크할 수 있음(실행 계획 확인:ctrl + L)

            - 인덱스 생성시 고려사항
                - 인덱스는 WHERE 절에 자주 사용되는 속성이어야 함. 
                - 인덱스는 조인에 자주 사용되는 속성이어야 함.
                - 단일 테이블에 인덱스가 많으면 속도가 느려질 수 있음(테이블 당 4~5개 정도 권장). 
                - 속성이 가공되는 경우 사용하지 않음. 
                - 속성의 선택도가 낮을 때 유리함(속성의 모든 값이 다른 경우).

- 파이썬 SQL Server 연동 프로그래밍
    - Madang DB 관리 프로그램
        - PyQT로 GUI 생성
        - SQL Server 데이터 핸들링
            - pymssql 라이브러리 설치
            ```shell
            > pip install pymssql
            ```
        - DB 연결 설정 : Oracle, MySQL 등은 설정이 없음. 구성관리자에서 TCP/IP로 접근을 허용하지 않으면 접속 안됨
            1. 시작메뉴 > 모든 앱 > Microsoft SQL Server 2022 > **SQL Server 2022 구성 관리자** 실행
            2. SQL Server 네트워크 구성 > **MSSQLSERVER에 대한 프로토콜** 클릭
            3. TCP/IP 프로토콜  상태가 사용안함(최초) > **TCP/IP**를 더블클릭
            4. **프로토콜 탭의 사용 > '예'** 로 변경
            5. IP주소 탭 > IP주소가 본인 아이피인 것 > **사용 > '예'**로 변경
            6. 127.0.0.1로 된 주소 > **사용 > '예'**로 변경
            7. 적용 후 SQL Server 서비스 > SQL Server (MSSQLSERVER) 더블클릭 후, **다시 시작** 버튼 클릭, 재시작 필요!! 

            ![기능선택](https://raw.githubusercontent.com/YooWangGwon/basic-database-2024/main/images/db005.png)

## 6일차(24.04.04)
- 파이썬 SQL Server 연동 프로그래밍
    - Madang DB 관리 프로그램
        - PyQt5 +pymssql

    - 문제점 : 한글 깨짐 문제
        1. DB 테이블의 varchar(ASCII) -> nvarchar(UTF-8)로 변경
        2. Python에서  pymssql로 접속할 때, Charset을 'UTF-8'로 설정
        3. INSERT 쿼리에 한글 입력되는 컬럼은 N''을 붙여줌(유니코드로 입력하라는 뜻)

    - 실행화면
	
	https://github.com/YooWangGwon/basic-database-2024/assets/158007390/53dc45c0-d50d-4186-8fc7-b7ef2ae51bfe

## 7일차(24.04.05)
- SQL 고급
    - 트랜잭션
        - 트랜잭션의 개념
            - DMBS에서 데이터를 다루는 논리적인 작업(INSERT, UPDATE, DELETE)의 단위
            - 데이터베이스에서 트랜잭션을 정의하는 이유
                - 데이터베이스에서 데이터를 다룰 때 장애가 일어날 때 데이터를 복구하는 작업의 단위가 됨
                - 데이터 베이스에서 여러 작업이 동시에 같은 데이터를 다룰 때 작업을 서로 분리하는 단위가 됨
            - **트랜잭션은 전체가 수행되거나 또는 전혀 수행되지 않아야 함(All or Nothing)**

        - 트랜잭션의 성질(ACID)
            - 원자성(Atomicity) : 트랜잭션에 포함된 작업은 전부수행되거나 아니면 전부 수행되지 않아야함.
            - 일관성(Consistency) : 트랜잭션을 수행하기 전이나 수행한 후나 데이버베이스는 일관된 상태를 유지해야함.
            - 고립성(Isolation) : 수행 중인 트랜잭션에 다른 트랜잭션이 끼어들어 변경 중인 데이터 값을 훼손하는 일이 없어야 함.
            - 지속성(Durability) : 수행을 성공적으로 완료한 트랜잭션은 변경한 데이터를 영구히 저장해야 함.

        - TCL(Transaction Control Language)
            - BEGIN {TRAN[SACTION]} : 트랜잭션의 시작
            - COMMIT {TRAN[SACTION]} : 트랜잭션의 종료
            - ROLLBACK {TRAN[SACTION]} : 트랜잭션 전체 혹은 <savepoint>까지 무효화
            - SAVE {TRAN[SACTION]} : <savepoint> 생성

        - SQL Server는 기본적으로 Auto Commit(시스텥ㅁ이 자동으로 트랜잭션을 건다)
        - SSMS > 도구 > 옵션 > 쿼리 실행 > SQL Server > ANSI
            -> SET IMPLICIT_TRANSACTIONS 체크, 프로그램 재시작
        
        - 트랜잭션 : 로직 처리시, 다른 트랜잭션의 간섭을 받지 않기 위한 것(Lock), 중요한 데이터 수정시 잘못된 변경을 방지하기 위한 것 

    - 동시성 제어(concurrency control)
        - 개념 : 트랜잭션이 동시에 수행될 때, 일관성을 해치지 않도록 트랜잭션의 데이터 접근을 제어하는 DBMS 기능
        - 갱신 손실(lost update) : 두 개의 트랜잭션이 한 개의 데이터를 동시에 갱신(update)할 때 발생
        - 락(Lock) : 데이터를 수정 중이라는 사실을 알리는 방법의 잠금장치

- 데이터베이스 모델링
    - 데이터베이스 생명주기
        - 1. 요구사항 수집 및 분석
        - 2. 설계
        - 3. 구현
        - 4. 운영
        - 5. 감시 및 개선

    - 설계 순서 : 개념 설계 -> 논리 설계 -> 물리 설계
        - 개념 설계(conceptual modeling)
            - 요구사항을 받으면서 정해지지 않은 여러 개체들을 정립화 하는 단계
            - 핵심 Entity(독립개체)도출하고 각 개체들 간의 관계를 정의
            - ERD 작성

        - 논리 설계(logicla modeling)
            - 기본키와 외래키 지정, 관계 정립, 속성명 지정을 통해 객체를 정하는 단계 -> 각 개념을 구체화
            - 개념 설계에서 만들어진 ER 을 사용하려는 다이어그램에 맞게 ERD-RDB 모델 사상(mapping)
            - 상세속성 정의
            - 정규화 및 데이터 표준화 수행

        - 물리 설계(physical)
            - DB에 맞춰서 컬럼이름, 컬럼데이터타입 및 크기 지정, DB에 대한 검토로 테이블을 만들기 직전의 설계를 완성
            - 데이터베이스 생성 계획에 따라 개체, 인덱스 등을 생성
            - DBMS의 특성에 맞춰 DB 개체 정의하고 테이블 및 인덱스 등을 설계

    - ER 모델링 : ERD를 그리기 위한 기본 이론
        - 개체와 개체 타입
            - 사물을 개체(entity)와 개체간의 관계(relationship)로 표현
            - 개체의 특성을 나타내는 속성(attribute)에 의해 식별
            - ER 다이어그램 : 개체와 개체 간의 관계를 표준화된 그림으로 나타낸 것
            - 개체(entity) : 유무형의 정보를 가지고 있는 독립적인 실체
            - 개체 타입 유형
                - 강한 개체 : 다른 개체 도움 없이 독자적으로 존재할 수 있는 개체
                - 약한 개체 : 독자적으로는 존재할 수 없고 반드시 상위 개체 타입을 가짐
        
        - 속성(attribute) : 개체가 가진 성질
        
        - 관계와 관계타입
            - 관계(relationship) : 개체 사이의 연관성을 나타내는 개념
            - 관계 타입(relationship type)
                - 개체 타입과 개체 타입 간의 연결 가능한 관계를 정의한 것
                - 관계집합 : 관계로 연결된 집합
                - 관계 타입 유형
                    - 일대일(1:1)
                    - 일대다(1:N), 다대일(N:1)
                    - 다대다(N:N) -> DB 설계시 가장 문제가 되는 관계

            - ISA 관계 : 상위 개체 타입의 특성에 따라 하위 개체 타입이 결정되는 형태
            - 개체타입 간의 관계를 표현할 때 각 객체들은 고유한 역할(role)이 존재
            - 순환적 관계  : 하나의 개체 타입이 동일한 개체 타입(자기 자신)과 순환적으로 관계를 가지는 형태
    
    - ER 모델을 관계 데이터 모델로 사상
        - 물리적인 다이어그램에서 다대다 관계는 없다
        - 논리 설계에서 다대다 관계를 풀어줘야 함

- 인덱스 예제
    - PK나 인덱스가 없는 상태에서 성능문제 체크
    - 인덱스가 설정되면 성능이 어떤지 비교
    - 더미 생성시 100만건으로 제약을 두고 시작

    <!-- md 주석. ![인덱스](https://raw.githubusercontent.com/YooWangGwon/basic-database-2024/main/images/db007.png) -->
    <!-- html 이미지 태그가 이미지 사이즈 조정 가능 -->
  
    <img src="https://raw.githubusercontent.com/YooWangGwon/basic-database-2024/main/images/db007.png" width="800">

## 8일차(24.04.08)
- 인덱스 예제
    - 인덱스는 대량의 데이터에서 찾고자하는 데이터를 빨리 찾게 해주려는 목적
    - WHERE절, JOIN ON 절에 들어가는 컬럼에 인덱스를 설정하는게 속도 개선에 도움이 됨
    - 1번 PK(기본키), 2번 FK(외래키), 3번 WHERE절에 검색시 들어가는 컬럼에 인덱스를 설정
    - 단, NULL값이 많거나 중복이 많은 컬럼에 인덱스를 걸면 성능에 도움받지 않음

- 정규화 
    - 이상 현상
        - 삭제 이상 : 투플 삭제 시 같이 저장된 다른 정보까지 연쇄적으로 삭제되는 현상 -> 연쇄삭제(triggered deletion) 문제
        - 삽입 이상 : 투플 삽입 시 특정 속성에 해당하는 값이 없어 NULL 값을 입력해야 하는 현상 ->  NULL 값 문제 발생
        - 수정 이상 : 투플 수정 시 중복된 데이터의 일부만 수정되어 데이터의 불일치 문제가 일어나는 현상 -> 불일치(inconsistency) 문제 발생

    - 정규화
        - DB상에서 이상현상이 발생하지 않는 정확한 데이터 베이스를 설계하는 것 -> 릴레이션(테이블)을  분리해서 데이터베이스를 설계
        - 이상현상이 생기는 테이블을 분리해서 해결
        - 기본키와 함수종속성을 파악 
        - 종류
            - 제 1정규형 : 도메인이 원자값을 가짐
            - 제 2정규형 : 기본키가 아닌 속성이 기본키에 완전 함수 종속일 때(학생번호[PK], 강좌이름 -> 성적을 결정)
            - 제 3정규형 : 기본키가 아닌 속성이 비곤키에 비이행적(non-transitive)으로 종속할 때(학생번호 --> 강좌이름 --> 수강료[이행종속성])
            - BCNF : 함수 종속성 X -> Y가 성립할 때 모든 결정자X가 후보키(기본키가 될수 있는 속성)인 경우
            - 보통 BCNF까지 정규화를 함
            - 4정규형(다치 종속성), 5정규형(조인 종속성, 무손실 분해)
            
- 실무실습(사용자, 권한...)
    1. DB관리자(SSMS)
        - hr데이터베이스 생성, 관계를 설정
        - hrDB를 사용할 사용자 계정을 생성, 필요한 권한 설정
            - 추가 : 만약에 sa의 비밀번호를 잊어버리면 Windows 인증으로 로그인 후
            - SSMS > 보안 > 로그인 > sa 존재 > 속성에서 비밀번호 변경 이후 SQL Server 인증으로 sa 비밀번호 입력 후 로그인 하면 됨
            - SSMS > 보안 > 로그인 > 새 로그인 클릭
            - 사용자 계정 : hr_user, 비밀번호 : hr_p@ss!
            - 일반 : 기본 데이터베이스를 hr 선택
            - 사용자 매핑 : hr 선택후 밑에서 데이터베이스 역할 멤버 db_owner 추가 선택
    
    2. HR 사용자 로그인()
