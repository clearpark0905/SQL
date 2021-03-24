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