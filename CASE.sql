SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
FROM EMP;

-- ��� DECODE���� CASE������ �ٲ� �� �ִ�. ������ ��� CASE���� DECODE�� �ٲ� �� ���� �ʴ�. ��, CASE���� ���뼺�� �� ����.