SELECT EMPNO,
    ENAME,
    JOB,
    SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        'ANALYST', SAL,
        SAL*1.03) AS UPSAL -- DECODE함수의 맨 마지막 데이터, 즉 조건에 해당하는 값이 없을 때 반환 값을 지정하지 않으면 NULL이 반환된다.
FROM EMP;