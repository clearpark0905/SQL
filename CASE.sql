-- 기준 데이터가 JOB인 CASE문
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
FROM EMP;
-- 기준 데이터 없이 사용하는 CASE문
SELECT EMPNO, ENAME, COMM,
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당 없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS COMM_TEXT
FROM EMP;

-- 모든 DECODE문은 CASE문으로 바꿀 수 있다. 하지만 모든 CASE문이 DECODE로 바꿀 수 있진 않다. 즉, CASE문의 범용성이 더 높다.