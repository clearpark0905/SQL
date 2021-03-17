SELECT EMPNO
    , ENAME
    , JOB
    , SAL
    , DECODE(
        (SELECT DEPTNO
        FROM DEPT
        WHERE DEPTNO = 20),
        10, 'GOD',
        20, 'GOOD',
        30, 'GOOOD',
        40, 'GOOOOD') DEPTNO
FROM EMP
;
-- 위와 아래는 같은 결과
SELECT EMPNO
    , ENAME
    , JOB
    , SAL
    , CASE (SELECT DEPTNO
            FROM DEPT
            WHERE DEPTNO = 20)
            WHEN 10 THEN 'GOD'
            WHEN 20 THEN 'GOOD'
            WHEN 30 THEN 'GOOOD'
            WHEN 40 THEN 'GOOOOD'
        END DEPTNO
FROM EMP
;

--컬럼 타입 조회
SELECT COLUMN_NAME, DATA_TYPE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'DEPT'
;