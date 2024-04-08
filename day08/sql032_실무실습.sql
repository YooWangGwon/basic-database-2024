-- file : sql032_실무실습.sql
-- date : 240408
-- desc : 실무실습

-- HR 데이터베이스 연습

-- 샘플 문제 : 사원정보 테이블 사번, 이름, 급여, 입사일, 상사의 사원정보를 출력하시오.
SELECT EMPLOYEE_ID
     , FIRST_NAME +' '+ LAST_NAME AS [name]
     , SALARY
     , HIRE_DATE
     , MANAGER_ID
  FROM employees;

-- 1. 사원정보 사원의 성과 이름을 name 으로, 업무는 job, 급여는 salary
-- 연봉은 $100 보너스를 추가하여 계산한 연봉은 Increased Ann Salary,
-- 월급에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력

SELECT FIRST_NAME +' '+ LAST_NAME AS [name]
     , JOB_ID AS [job]
     , SALARY
     , SALARY*12 + 100 AS [Increased Salary]
     , (SALARY + 100) * 12 AS [Increased Ann Salary]
  FROM employees;

/* 2. 사원정보 테이블에서 모든 사원의 성(last_name)과 연봉을 "성: 1 Year Salary = $연봉"
   형식으로 출력하고, "1 Year Salary"라는 별칭을 붙여 출력하시오.*/
SELECT LAST_NAME + ': 1 Year Salary = $' + CONVERT(VARCHAR, SALARY*12) AS [1 Year Salary]
  FROM employees
 WHERE LAST_NAME LIKE 'Hartstein'

/* 3. 부서별로 담당하는 업무를 한 번씩만 출력하시오.*/
SELECT DISTINCT DEPARTMENT_ID
     , JOB_ID
  FROM employees;

-- WHERE, ORDER BY 

/* 샘플 문제 : hr부서에서 예산 문제로 급여 정보 보고서를 작성. 사원정보에서 급여가
    7000~10000 이외의 사람의 성과 이름을, 급여를 급여가 작은 순으로 출력하시오(75개행) */
SELECT FIRST_NAME + ' ' + LAST_NAME AS 'Name'
     , SALARY
  FROM employees
 WHERE SALARY NOT BETWEEN 7000 AND 10000
 ORDER BY SALARY ASC;

/* 4. 사원의 이름 중에 'e' 및 'o'글자가 포함된 사원을 출력하시오. 이때 머리글은 'e and 'o Name'라고 출력하시오.*/
SELECT LAST_NAME
  FROM employees
 WHERE LAST_NAME LIKE '%e%' 
   AND LAST_NAME LIKE '%o%'

/* 5. 현재 날짜 타입을 날짜 함수를 통해 확인하고, 2006년 05월 20일부터 
    2007년 5월 20일 사이에 고용된 사원들의 성과 이름(Name으로 별칭), 사원번호, 고용일자를 출력하시오.
    단, 입사일이 빠른 순으로 정렬하시오. */

SELECT GETDATE()

SELECT FIRST_NAME + ' ' + LAST_NAME AS 'Name'
     , EMPLOYEE_ID
     , HIRE_DATE
  FROM employees
 WHERE HIRE_DATE BETWEEN '2006-05-20' AND '2007-05-20'
 ORDER BY HIRE_DATE ASC;

/* 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당률을 출력하시오. 이때 급여가 큰
    순서대로 정렬하되, 급여가 같으면 수당률이 큰 순서대로 정렬하시오. */

SELECT FIRST_NAME + ' ' +LAST_NAME AS 'NAME'
     , SALARY
     , JOB_ID
     , COMMISSION_PCT
  FROM employees
 WHERE COMMISSION_PCT IS NOT NULL
 ORDER BY COMMISSION_PCT DESC;