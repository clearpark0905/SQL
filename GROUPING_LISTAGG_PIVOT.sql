﻿-- GROUPING SETS 함수 : 같은 수준의 그룹화 열이 여러 개일 때 각 열별 그룹화를 통해 결과 값을 출력하는 데 사용함
SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB
;
-- GROUPING 함수 : ROLLUP 또는 CUBE 함수를 사용한 GROUP BY 절에 그룹화 대상으로 지정한 열이 그룹화된 상태로 결과가 집계되었는지 확인하는데 사용
-- 0은 GROUPING 함수에 지정한 열이 그룹화 되었음을 의미
-- 1은 그룹화되지 않은 데이터를 의미
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL), GROUPING(DEPTNO), GROUPING(JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB
;
-- DECODE문으로 GROUPING 함수를 적용하여 결과 표기하기
SELECT DECODE(GROUPING(DEPTNO), 1, 'ALL_DEPT', DEPTNO) AS DEPTNO,
       DECODE(GROUPING(JOB), 1, 'ALL-JOB', JOB) AS JOB,
       COUNT(*), MAX(SAL), MIN(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB
;
-- GROUPING_ID 함수 : GROUPING 함수와 마찬가지로 ROLLUP 또는 CUBE 함수로 연산할 때 특정 열이 그룹화되었는지를 출력
-- GROUPING과 달리 GROUPING_ID 함수는 한 번에 여러 열을 지정할 수 있다.
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL), GROUPING(DEPTNO), GROUPING(JOB), GROUPING_ID(DEPTNO, JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB
;
-- LISTAGG 함수 : 그룹에 속해있는 데이터를 가로로 나열할 때 사용
SELECT DEPTNO, LISTAGG(ENAME, ', ') WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
FROM EMP
GROUP BY DEPTNO
;
--PIVOT/UNPIVOT 함수 : 기존 테이블 행을 열로 바꾼다 / 기존 테이블 열을 행으로 바꾼다
SELECT *
FROM(SELECT DEPTNO, JOB, SAL
        FROM EMP)
    PIVOT(MAX(SAL)
        FOR DEPTNO IN (10, 20, 30)
        )
ORDER BY JOB
;
--PIVOT 함수 사용하여 부서별, 직책별 최고 급여를 2차원 표 형태로 출력하기
SELECT *
FROM(SELECT JOB, DEPTNO, SAL
        FROM EMP)
    PIVOT(MAX(SAL)
        FOR JOB IN ('CLERK' AS CLERK,
                    'SALESMAN' AS SALESMAN,
                    'PRESIDENT' AS PRESIDENT,
                    'MANAGER' AS MANAGER,
                    'ANALYST' AS ANALYST)
        )
ORDER BY DEPTNO
;
-- DECODE문 활용하여 PIVOT 함수와 같은 출력 구현하기
SELECT DEPTNO,
    MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK",
    MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN",
    MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT",
    MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER",
    MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO
;
-- UNPIVOT 함수를 사용하여 열로 구분된 그룹을 행으로 출력하기(PIVOT 함수와 반대 기능)
SELECT *
FROM (SELECT DEPTNO,
        MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK",
        MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN",
        MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT",
        MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER",
        MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
        FROM EMP
        GROUP BY DEPTNO
        ORDER BY DEPTNO)
    UNPIVOT(
    SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
ORDER BY DEPTNO, JOB
;