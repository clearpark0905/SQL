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