SELECT B.EMPNO, B.ENAME, A.DEPTNO, A.DNAME
FROM DEPT A, EMP B
WHERE A.DEPTNO = B.DEPTNO(+)
AND B.EMPNO(+) > 7700
ORDER BY B.EMPNO, B.ENAME, A.DEPTNO, A.DNAME
;
-- A.DEPTNO와 비교해서 없는 값이 있으면 B.DEPTNO에 NULL로 표현
-- OUTER JOIN이 되는 테이블 EMP의 모든 컬럼에 대해 (+) 기호를 붙여야함

SELECT D.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO (+)= D.DEPTNO
AND D.DEPTNO = 40
AND E.EMPNO (+)= 7788
;
-- JOIN할 데이터가 부족한 쪽에 위치


SELECT * FROM EMP;

SELECT ENAME, CASE WHEN ENAME = 'ALLEN'
                                        OR JOB = 'PRESIDENT'
                                        OR SAL = 800 THEN 'Y'
                                      --  ELSE NULL
                                        END YN
FROM EMP
;
--NVL(컬럼, NULL일경우 반환값)
--NVL2(컬럼, NULL이 아닐경우 반환값, NULL일경우 반환값)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, NVL(COMM, 0) COMM, DEPTNO
FROM EMP
;
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, NVL2(COMM, '있음', '없음') COMM, DEPTNO
FROM EMP
;
-- COMM 컬럼은 INTEGER 값을 가지니 주의!
