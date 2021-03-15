SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
FROM EMP;

-- 모든 DECODE문은 CASE문으로 바꿀 수 있다. 하지만 모든 CASE문이 DECODE로 바꿀 수 있진 않다. 즉, CASE문의 범용성이 더 높다.