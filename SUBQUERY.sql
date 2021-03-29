-- 기본 형식(JONES라는 이름을 가진 사원이 2명 이상일 땐 오류가 발생)
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
                        FROM EMP
                        WHERE ENAME = 'JONES')
;

-- 대부분의 서브쿼리에서는 ORDER BY절을 사용할 수 없다.
-- 단일행 서브쿼리 : 실행 결과가 단 하나의 행으로 나오는 서브쿼리
-- 단일행 연산자 : >, >=, =, <=, <, <>, ^=, !== 
-- 서브쿼리에서 특정 함수를 사용한 결과 값이 하나일 때 역시 단일행 서브쿼리로서 사용 가능
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 20
AND E.SAL > (SELECT AVG(SAL)
                      FROM EMP)
;

-- 다중행 서브쿼리 : 실행 겨로가 행이 여러 개로 나오는 서브쿼리
-- 다중행 연산자 : IN, ANY/SOME, ALL, EXISTS
-- IN 연산자
SELECT *
FROM EMP
WHERE DEPTNO IN (20, 30)
;
SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                          FROM EMP
                          GROUP BY DEPTNO)
;
-- ANY, SOME 연산자
SELECT *
FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)
                                 FROM EMP
                                 GROUP BY DEPTNO)
;
-- 950, 1250, 1500, 1600보다 큰 값이더라도 2850 하나의 값보다만 작으면 TRUE
SELECT *
FROM EMP
WHERE SAL < ANY (SELECT MAX(SAL)
                                FROM EMP
                                WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO
;                                        
-- ALL 연산자 : 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야함
SELECT *
FROM EMP
WHERE SAL < ALL (SELECT SAL
                               FROM EMP
                               WHERE DEPTNO = 30)
;
--EXISTS 연산자 : 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 모두 FALSE
SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
                            FROM DEPT
                            WHERE DEPTNO = 10)
;                
--다중열 서브쿼리 : 서브쿼리의 SELECT절에 비교할 데이터를 여러 개 지정하는 방식
SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                            FROM EMP
                                            GROUP BY DEPTNO);
--인라인 뷰(INLINE VIEW) : FROM절에서 사용하는 서브쿼리
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT *
             FROM EMP
             WHERE DEPTNO = 10) E10,
            (SELECT *
            FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO
;
-- WITH절을 사용하여 위의 쿼리와 같은 쿼리 짜기
WITH E10 AS (
    SELECT *
    FROM EMP
    WHERE DEPTNO = 10),
    D AS (
    SELECT *
    FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO
;
--스칼라 서브쿼리 : SELECT 절에 하나의 열 영역으로서 결과를 출력
SELECT EMPNO
             ,ENAME
             ,JOB
             ,SAL
             ,(SELECT GRADE
                FROM SALGRADE
                WHERE E.SAL BETWEEN LOSAL AND HISAL)        SALGRADE
             ,DEPTNO
             ,(SELECT DNAME
                FROM DEPT
                WHERE E.DEPTNO = DEPT.DEPTNO)                      DNAME
FROM EMP E
;
--Q1
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'ALLEN')
    AND E.DEPTNO = D.DEPTNO
;
--Q2
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE 1=1
    AND E.SAL > (SELECT AVG(SAL)
                         FROM EMP)
    AND E.DEPTNO = D.DEPTNO
    AND E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY SAL DESC, EMPNO ASC
;
--Q3
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = 10
AND E.DEPTNO = D.DEPTNO
AND E.JOB NOT IN (SELECT JOB
                               FROM EMP
                               WHERE DEPTNO = 30)
;
--Q4 : 다중행 함수를 사용하지 않는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, G.GRADE
FROM EMP E, SALGRADE G
WHERE 1=1
    AND E.SAL > (SELECT MAX(SAL)
                        FROM EMP
                        WHERE JOB = 'SALESMAN')
    AND E.SAL BETWEEN G.LOSAL AND G.HISAL
ORDER BY E.EMPNO
;
--Q4 : 다중행 함수 사용하는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ALL (SELECT DISTINCT SAL
                           FROM EMP
                           WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO
;













