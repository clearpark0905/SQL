-- ROLLUP, CUBE, GROUPING SETS함수는 GROUP BY절에 지정할 수 있는 특수 함수
-- 기존 그룹화
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;
-- ROLLUP 함수 : 명시한 열을 소그룹부터 대그룹의 순서로 각 그룹별 결과를 출력하고 마지막에 총 데이터의 결과를 출력
-- N개의 열이면 N+1개 조합이 출력됨
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
;
-- CUBE 함수 : 지정한 모든 열에서 가능한 조합의 결과를 모두 출력 (ROLLUP보다 많은 결과가 출력됨)
-- N개의 열이면 2^N개의 조합이 출력됨
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB
;
-- 조합의 경우의 수가 올라가면 조합의 수가 감당하기 어려울 정도가 될 수 있음
-- 따라서 그룹화 열 중 일부만을 지정 가능
-- PARTIAL ROLLUP
SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB)
;
