# basic-database-2024
부경대학교 2024 IoT 개발자 과정 SQLServer 학습 리포지토리

## 1일차(24.03.28)
- MS SQL Server  설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 : 개발자(Developer) 버전으로 설치
        - ISO 다운로드 후 설치 추천(설치툴에서 바로 설치하는 것은 권장하지 않음)
        - 설치시 SQL Server에 대한 Azure 확장은 비활성화
        - 기능 선택
            - 데이터 베이스 엔진 서비스 
            - 데이터 베이스 복제
            - 검색을 위한 전체 텍스트 및 의미 체계 추출
            - Integration Services

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

            - DCL(Data Control Language) - 권한, 트랜스액션 부여(GRANT)/제거(DELETE) 기능
                - 데이터의 사용 권한을 관리하는데 사용
                - GRANT, REVOKE문 등

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

- SQL 기봅학습
    - SSMS 실행
    
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

## 2일차