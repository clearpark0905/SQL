-- �⺻ ����(JONES��� �̸��� ���� ����� 2�� �̻��� �� ������ �߻�)
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
                FROM EMP
                WHERE ENAME = 'JONES')
;

-- ��κ��� �������������� ORDER BY���� ����� �� ����.
-- ������ �������� : ���� ����� �� �ϳ��� ������ ������ ��������
-- ������ ������ : >, >=, =, <=, <, <>, ^=, !== 
-- ������������ Ư�� �Լ��� ����� ��� ���� �ϳ��� �� ���� ������ ���������μ� ��� ����
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 20
AND E.SAL > (SELECT AVG(SAL)
                FROM EMP)
;