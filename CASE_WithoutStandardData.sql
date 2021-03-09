SELECT EMPNO, ENAME, COMM,
    CASE
        WHEN COMM IS NULL THEN '�ش���� ����'
        WHEN COMM = 0 THEN '���� ����'
        WHEN COMM > 0 THEN '���� : ' || COMM
    END AS COMM_TEXT
FROM EMP;