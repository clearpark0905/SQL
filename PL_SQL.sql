-- DECLARE   : (선택) 실행에 사용될 변수, 상수, 커서 등을 선언
-- BEGIN     : (필수) 조건문, 반복문, DML, 함수 등을 정의
-- EXCEPTION : (선택) PL/SQL 실행 도중 발생하는 오류(예외 상황)를 해결하는 문장 기술

-- DECLARE
--     [실행에 필요한 여려 요소 선언];
-- BEGIN
--     [작업을 위해 실제 실행하는 명령어];
-- EXCEPTION
--     [PL/SQL 수행 도중 발생하는 오류 처리];
------------------------------------------------
SET SERVEROUTPUT ON; -- PL/SQL 실행 전 먼저 실행해야 할 명령어 (실행시 한번만 하면 된다)

BEGIN
   DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL!');
END;


--HELLO, PL/SQL!

--PL/SQL procedure successfully completed.
------------------------------------------------

DECLARE
	V_EMPNO NUMBER(4) := 7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;

-- 상수(CONSTANT)는 한번 저장한 값이 프로그램 종료 시까지 유지되는 저장 요소
-- 기본값(DEFAULT)는 변수에 저장할 기본값
-- NOT NULL 지정 가능

DECLARE
	V_TAX CONSTANT NUMBER(1) := 3;
	V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TEX : ' || V_TAX);
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;

-- 스칼라형(SCALAR TYPE) : 숫자, 문자열, 날짜 등과 같이 오라클에서 기본으로 정의해 놓은 자료형
-- 참조형(REFERENCE TYPE) : DB에 존재하는 특정 테이블 열의 자료형이나 하나의 행 구조를 참조하는 자료형
--     열참조 : %TYPE, 행참조 : %ROWTYPE

DECLARE
	V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;

DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
	SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
	FROM DEPT 
	WHERE DEPTNO = 40;
	DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
	DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;

-- 복합형(COMPOSITE TYPE) : 여러 종류 및 개수의 데이터를 저장하기 위해 사용자가 직접 정의하는 자료형 (컬렉션, 레코드)
-- LOB형(LARGE OBJECT) : 대용량의 텍스트 이미지 동영상 사운드데이터 등 대용량 데이터를 저장하기 위한 자료형 (BLOB, CLOB)

-- IF 조건식 THEN
--     수행 명령어;
-- END IF;

DECLARE
	V_NUMBER NUMBER := 13;
BEGIN
	IF MOD(V_NUMBER, 2) = 1
		THEN DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
	END IF;
END;

-- IF 조건식 THEN
-- 	   수행 명령어;
-- ELSE
-- 	   수행 명령어;
-- END IF;

DECLARE
	V_NUMBER NUMBER := 13;
BEGIN
	IF MOD(V_NUMBER, 2) = 1
		THEN DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수입니다!');
	END IF;
END;


-- ELSIF 사용가능 (ELSE IF 역할)
-- CASE 조건문 : 비교 기준을 두거나, 여러 조건식을 나열하여 작업을 수행할 수 있음
-- CASE 비교기군
--     WHEN 값1 THEN
--	       수행할 명령어;
--	   WHEN 값2 THEN
--		   수행할 명령어;
--     ELSE
--	       수행할 명령어;
-- END CASE;
DECLARE
	V_SCORE NUMBER := 87;
BEGIN
	CASE TRUNC(V_SCORE/10)
		WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A학점');
		WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A학점');
		WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B학점');
		WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C학점');
		WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D학점');
	ELSE DBMS_OUTPUT.PUT_LINE('F학점');
	END CASE;
END;

--

DECLARE
	V_SCORE NUMBER := 87;
BEGIN
	CASE 
		WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A학점');
		WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B학점');
		WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C학점');
		WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D학점');
	ELSE DBMS_OUTPUT.PUT_LINE('F학점');
	END CASE;
END;

-- LOOP

DECLARE
	V_NUM NUMBER := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
		V_NUM := V_NUM + 1;
		EXIT WHEN V_NUM > 4;
	END LOOP;
END;

-- WHILE LOOP

DECLARE
	V_NUM NUMBER := 0;
BEGIN
	WHILE V_NUM < 4 LOOP
		DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
		V_NUM := V_NUM + 1;
	END LOOP;
END;

-- FOR LOOP

BEGIN
	FOR I IN 0..4 LOOP
		DBMS_OUTPUT.PUT_LINE('현재 I의 값 : ' || I);
	END LOOP;
END;

-- FOR LOOP REVERSE

BEGIN
	FOR I IN REVERSE 0..4 LOOP
		DBMS_OUTPUT.PUT_LINE('현재 I의 값 : ' || I);
	END LOOP;
END;

-- CONTINUE IN FOR LOOP

BEGIN 
	FOR I IN 0..4 LOOP
		CONTINUE WHEN MOD(I, 2) = 1;
		DBMS_OUTPUT.PUT_LINE('현재 I의 값 : ' || I);
	END LOOP;
END;

--Q1
BEGIN
	FOR I IN 0..10 LOOP
		CONTINUE WHEN MOD(I, 2) = 0;
		DBMS_OUTPUT.PUT_LINE('현재 I의 값 : ' || I);
	END LOOP;
END;

--Q2

DECLARE
	V_DEPTNO DEPT.DEPTNO%TYPE := 10;
BEGIN
	CASE V_DEPTNO
		WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ACCOUNTING');
		WHEN 20 THEN DBMS_OUTPUT.PUT_LINE('DNAME : RESEARCH');
		WHEN 30 THEN DBMS_OUTPUT.PUT_LINE('DNAME : SALES');
		WHEN 40 THEN DBMS_OUTPUT.PUT_LINE('DNAME : OPERATIONS');
	ELSE DBMS_OUTPUT.PUT_LINE('N/A');
	END CASE;
END;
