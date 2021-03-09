SELECT EMPNO,
    ENAME,
    JOB,
    SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        'ANALYST', SAL,
        SAL*1.03) AS UPSAL -- DECODE�Լ��� �� ������ ������, �� ���ǿ� �ش��ϴ� ���� ���� �� ��ȯ ���� �������� ������ NULL�� ��ȯ�ȴ�.
FROM EMP;