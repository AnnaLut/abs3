
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/be.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BE IS
/******************************************************************************
   ��������:   BE
   ����������: ����� ������� ������������ ����������� BARS Everywhere
   ������:     1.7
   ��������� � ����������:
   ����        �����            ��������
   ----------  ---------------  ------------------------------------
   15.02.2005  ����             7. ������ DBA_OBJECTS �� ALL_OBJECTS ���
                                   ���������� ���������� ������
   18.09.2003  ����             6. ����������� ������� Rollback_Until_Time
                                   �����������, 100% �������������� �� �������
   11.02.2003  ����             5. ������� ��������� ����������� ����, � �����
                                   ������� Clear_History_To_Depth
   07.02.2003  ����             4. �������� ������� �������������� �����
   06.10.2002  ����             3. ������� ������� ������ �� �������
                                   Rollback_Until_Time
   28.10.2002  ����             2. ������� ������� ������ � �������� �������
   03.09.2002  ����             1. ��������
******************************************************************************/

--�������������� ���������� �������� � �������� �����
PROCEDURE Compile_Schema (
       szSchemaName    VARCHAR2           --��� �����
     );

--�������� ������� ��������� ������� (����������)
PROCEDURE Clear_History(
       PATH_NAME_    VARCHAR2,           --��� �������
       DEPTH_      DATE              --������� �������� �� ������� �������� DEPTH_
     );

--����� � ���������� ������ ������� �� ������ ������������ DEPTH_
PROCEDURE Rollback_To_Ancesstor(
       PATH_NAME_    VARCHAR2,           --��� �������
       DEPTH_      DATE              --������� ������
     );

--����� ����� ������� �� ������� ������������� DEPTH_
PROCEDURE Rollback_Until_Time(
       DEPTH_      DATE              --������� ������ (����/�����)
     );

--�������� ������� �� ������� DEPTH_ ��������� ���������
PROCEDURE Clear_History_To_Depth(
       DEPTH_      NUMBER              --������� ������ (����� ����������������)
     );

END BE;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BE AS

FUNCTION Get_Iinvalids_Count (
       szSchemaName    VARCHAR2         --��� �����
     ) RETURN NUMBER IS
COUNT_ NUMBER;
BEGIN
  SELECT COUNT(*) INTO COUNT_ FROM ALL_OBJECTS WHERE OWNER=szSchemaName AND STATUS='INVALID';
  RETURN COUNT_;
END Get_Iinvalids_Count;

PROCEDURE Compile_Schema_Int (
       szSchemaName    VARCHAR2         --��� �����
     )
IS
CID      INTEGER;
RES      INTEGER;
SSS      VARCHAR2(200);
BEGIN
  CID := DBMS_SQL.OPEN_CURSOR;
  FOR CUR IN (SELECT OBJECT_TYPE, OBJECT_NAME FROM ALL_OBJECTS WHERE OWNER=szSchemaName AND STATUS='INVALID') LOOP
    IF CUR.OBJECT_TYPE='PACKAGE BODY' THEN
      SSS:='ALTER PACKAGE ' || CUR.OBJECT_NAME || ' COMPILE BODY';
    ELSE
      SSS:='ALTER ' || CUR.OBJECT_TYPE || ' ' || CUR.OBJECT_NAME || ' COMPILE';
    END IF;
    DBMS_OUTPUT.PUT_LINE(SSS);
    BEGIN
      DBMS_SQL.PARSE(CID, SSS, DBMS_SQL.V7);
      RES := DBMS_SQL.EXECUTE( CID );
    EXCEPTION
      WHEN OTHERS THEN NULL;
    END;
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR( CID );
END Compile_Schema_Int;

--�������������� ���������� �������� � �������� �����
PROCEDURE Compile_Schema (
       szSchemaName    VARCHAR2         --��� �����
     )
IS
IC_      NUMBER;
IN_      NUMBER;
CID      INTEGER;
RES      INTEGER;
BEGIN
  IF szSchemaName IS NULL THEN
    RETURN;
  END IF;
  -- �������������� �����
  IC_:=0;
  LOOP
    IN_:=Get_Iinvalids_Count(UPPER(LTRIM(RTRIM(szSchemaName))));
  DBMS_OUTPUT.PUT_LINE(IC_||' '||IN_);
    EXIT WHEN IN_=0 OR IC_=IN_;
    IC_:=IN_;
    Compile_Schema_Int(UPPER(LTRIM(RTRIM(szSchemaName))));
  END LOOP;
  -- ������ ���� ����������
  CID := DBMS_SQL.OPEN_CURSOR;
  BEGIN
    DBMS_SQL.PARSE(CID, 'BEGIN GRANT_ALL_PRIVS; END;', DBMS_SQL.V7);
    RES := DBMS_SQL.EXECUTE( CID );
  EXCEPTION
    WHEN OTHERS THEN NULL;
  END;
  DBMS_SQL.CLOSE_CURSOR( CID );
END Compile_Schema;

--�������� ������� ��������� ������� (����������)
--��� ������ �������� ��������
PROCEDURE Clear_History(
       PATH_NAME_    VARCHAR2,           --��� �������
       DEPTH_      DATE              --������� �������� ������� �������� DEPTH_
     )
IS
BEGIN
  DELETE FROM BE_LIBS_ARC WHERE PATH_NAME=PATH_NAME_ AND INS_DATE<=DEPTH_;
END Clear_History;

--����� � ���������� ������ ������� �� ������ ������������ DEPTH_
PROCEDURE Rollback_To_Ancesstor(
       PATH_NAME_    VARCHAR2,           --��� �������
       DEPTH_      DATE              --������� ������
     )
IS
  RESTORE_DATE DATE;
BEGIN
  --������� ������� ������ � �����
  DELETE FROM BE_LIBS_BODY WHERE PATH_NAME=PATH_NAME_;
  DELETE FROM BE_LIBS WHERE PATH_NAME=PATH_NAME_;
  --� ��������� ������� DEPTH_ ����� ���� ������� ������ �������� ���� �������
  --��� ��-�� ������� �� ������� ��� ��������� �������� � �������� BE_CHECK � � ��
  SELECT MAX(INS_DATE) INTO RESTORE_DATE FROM BE_LIBS_ARC WHERE INS_DATE<=DEPTH_;
  --��������� ������������ ��� ������ � �������� ��
  INSERT INTO BE_LIBS (PATH_NAME, DESCR, FILE_DATE, FILE_SIZE, VERSION, LINKS, CRITICAL, STATUS, CHECK_SUM)
  SELECT PATH_NAME, DESCR, FILE_DATE, FILE_SIZE, VERSION, LINKS, CRITICAL, 1, CHECK_SUM FROM BE_LIBS_ARC
  WHERE PATH_NAME=PATH_NAME_ AND INS_DATE=RESTORE_DATE;
  INSERT INTO BE_LIBS_BODY (PATH_NAME, FILE_BODY)
  SELECT PATH_NAME, FILE_BODY FROM BE_LIBS_BODY_ARC
  WHERE PATH_NAME=PATH_NAME_ AND INS_DATE=RESTORE_DATE;
END Rollback_To_Ancesstor;

--����� ����� ������� �� ������� ������������� DEPTH_
PROCEDURE Rollback_Until_Time(
       DEPTH_      DATE              --������� ������ (����/�����)
     )
IS
  CURSOR ALL_ROLLED_LIBS IS
  SELECT PATH_NAME FROM BE_LIBS WHERE INS_DATE>=DEPTH_
  UNION ALL
  SELECT PATH_NAME FROM BE_DELETED_LIBS;
  RESTORE_DATE DATE;
  RESTORE_START_DATE DATE;
BEGIN
  RESTORE_START_DATE := SYSDATE;
  --�����
  DELETE FROM BE_PATCHES WHERE INS_DATE>=DEPTH_;
  --�������������� ���������, ����������� � ����������� ��������� � ����� ������
  FOR C IN ALL_ROLLED_LIBS LOOP
    DBMS_OUTPUT.PUT_LINE( 'Restoring lib: ' || C.PATH_NAME );
    --������� ������� ������ � �����
    DELETE FROM BE_LIBS_BODY WHERE PATH_NAME=C.PATH_NAME;
    DELETE FROM BE_LIBS WHERE PATH_NAME=C.PATH_NAME;
    --����� ��������� ����������� ������ ���������� �� ������� ������ ���� ��� ������� ����!!
    SELECT MAX(INS_DATE) INTO RESTORE_DATE FROM BE_LIBS_ARC WHERE PATH_NAME=C.PATH_NAME AND INS_DATE<RESTORE_START_DATE;
    --���� ���� ���� ����������
    IF RESTORE_DATE IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE( 'Restoring lib for ' || TO_CHAR(RESTORE_DATE,'dd/mm/yyyy hh24:mi:ss') );
        --��������� ������������ ��� ������ � �������� ��
        INSERT INTO BE_LIBS (PATH_NAME, DESCR, FILE_DATE, FILE_SIZE, VERSION, CHECK_SUM, LINKS, CRITICAL, STATUS, INS_DATE, INS_USER)
        SELECT PATH_NAME, DESCR, FILE_DATE, FILE_SIZE, VERSION, CHECK_SUM, LINKS, CRITICAL, 1, INS_DATE_ORI, INS_USER_ORI FROM BE_LIBS_ARC
        WHERE
          PATH_NAME=C.PATH_NAME AND
        INS_DATE=RESTORE_DATE;
        INSERT INTO BE_LIBS_BODY (PATH_NAME, FILE_BODY)
        SELECT PATH_NAME, FILE_BODY FROM BE_LIBS_BODY_ARC
        WHERE PATH_NAME=C.PATH_NAME AND INS_DATE=RESTORE_DATE;
        --������� ����������� ������ ����������
      DELETE FROM BE_LIBS_BODY_ARC
      WHERE PATH_NAME=C.PATH_NAME AND INS_DATE=RESTORE_DATE;
      DELETE FROM BE_LIBS_ARC
      WHERE
        PATH_NAME=C.PATH_NAME AND
      INS_DATE=RESTORE_DATE;
    ELSE
      DBMS_OUTPUT.PUT_LINE( 'Lib destroyed (no prior version found)' );
    END IF;
    --������� �� ������� ��� ������� � ���� ������
    DELETE FROM BE_LIBS_ARC WHERE PATH_NAME=C.PATH_NAME AND
      INS_DATE>=DEPTH_;
  END LOOP;
END;

--�������� ������� �� ������� DEPTH_ ��������� ���������
PROCEDURE Clear_History_To_Depth(
       DEPTH_      NUMBER              --������� ������ (����� ����������������)
     )
IS
  CURSOR ALL_HISTORY_LIBS IS
  SELECT DISTINCT PATH_NAME FROM BE_LIBS_ARC;
  CURSOR LIB_HISTORY (LIB_NAME_ VARCHAR2) IS
  SELECT INS_DATE FROM BE_LIBS_ARC
  WHERE PATH_NAME=LIB_NAME_
  ORDER BY INS_DATE DESC;
  K NUMBER;
BEGIN
  FOR I IN ALL_HISTORY_LIBS LOOP
    K:=0;
    FOR J IN LIB_HISTORY(I.PATH_NAME) LOOP
    K:=K+1;
    IF K>DEPTH_ THEN
      DELETE FROM BE_LIBS_BODY_ARC WHERE PATH_NAME=I.PATH_NAME AND INS_DATE<=J.INS_DATE;
      DELETE FROM BE_LIBS_ARC WHERE PATH_NAME=I.PATH_NAME AND INS_DATE<=J.INS_DATE;
    END IF;
  END LOOP;
  END LOOP;
END;

END BE;
/
 show err;
 
PROMPT *** Create  grants  BE ***
grant EXECUTE                                                                on BE              to ABS_ADMIN;
grant EXECUTE                                                                on BE              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BE              to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/be.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 