
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/patch.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PATCH IS
/******************************************************************************
   NAME:       PATCH
   PURPOSE:    Intelectual patch work

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/11/2000  Ivan             1. Created this package.

   REQUREMENTS: P0000000.sql script executed

******************************************************************************/

   /*
     ����: �������� ������� ��������� ������
     ������������ ��������:

		<0	- ���� �� ���������� ��� ����������� ���������� ������ �����,
			  � ���������� PATCH_VERSION ������������ ������������ ������ �����,
			  ���� ���� �� ���������� � PATCH_VERSION ������������ Null

		0	- ���������� ���� � ������� PATCH_N � ������� PATCH_VERSION;

		>0	- ���������� ���� � ������� PATCH_N � ������� ���� PATCH_VERSION?
			  � ���������� PATCH_VERSION ������������ ������������ ������ �����;
	  ���������:
	    PATCH_N
		      ����� �����
	    PATCH_VERSION
		      ������ ����� (���� NULL ����������� �����), ����������� ������ �����
	*/
   FUNCTION CHECK_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION OUT VARCHAR2  ) Return Number;

   /*
     ����: �������� ����������� ���������� �����
     ������������ ��������:
		1	- ���� � �������� ������� � ������� ����� ���� ����������
              (�.�. �� ������ �� �� ���������� ���� � ������ ������� ���
			  ����������, �� � ���������� ������� � ��� �� ���������)

		0	- ���� � �������� ������� � ������� �� ����� ���� ����������
			  (�.�. �� ������ �� ��� ���������� ���� � ������ ������� ���
			  ���������� �� ��������� ������� ��� ��� �� �� ���������)
	  ���������:
	    PATCH_N
		      ����� �����
	    PATCH_VERSION
		      ������ ����� (���� NULL ����������� �����), ����������� ������ �����
	    DB_TYPE
		      ��� ���� ������ (��. Params.DB_TYPE)
			  ����������� ���� ���������� ��������� ������ ��
			  (������, �������...)
			  ������������� �������� GENERIC
			  !!! ����� ��� ���� �� GENERIC ������ ����������� �� ���� �����
			  ����� � ������ ����� ����������� ������ �� �� ���� DB_TYPE
   */
   FUNCTION CAN_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2, DB_TYPE VARCHAR2 DEFAULT 'GENERIC' ) Return Number;

   /*
      ����: ����������� ����� ����� ��������� ����������
	  ���������:
	    PATCH_N
		      ����� �����
	    PATCH_VERSION
		      ������ ����� (���� NULL ����������� �����), ����������� ������ �����
   */
   PROCEDURE REGISTER ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2 );

END PATCH;
/
CREATE OR REPLACE PACKAGE BODY BARS.PATCH AS

FUNCTION CHECK_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION OUT VARCHAR2 ) Return Number IS
tmp VARCHAR2(10);
BEGIN
  BEGIN
    SELECT patch_version INTO tmp FROM patches WHERE patch_number = PATCH_N;
	IF PATCH_VERSION IS NULL THEN
	  RETURN 0;
	ELSIF PATCH_VERSION > tmp THEN
	  PATCH_VERSION := tmp;
	  RETURN  -1;
	ELSIF PATCH_VERSION < tmp THEN
	  PATCH_VERSION := tmp;
	  RETURN  1;
	ELSIF PATCH_VERSION = tmp THEN
	  RETURN  0;
	END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	BEGIN
	  PATCH_VERSION := NULL;
	  RETURN -1;
	END;
  END;
  RETURN -1;
END CHECK_PATCH;

FUNCTION CAN_PATCH ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2, DB_TYPE VARCHAR2 DEFAULT 'GENERIC' ) Return Number IS
tmp VARCHAR2(50);
BEGIN
  BEGIN
    SELECT val INTO tmp FROM params WHERE par='DB_TYPE';
	IF (DB_TYPE<>'GENERIC') AND (DB_TYPE<>tmp) THEN
	  RETURN 0;   --Wrong DB_TYPE
	END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
  END;
  BEGIN
    SELECT patch_version INTO tmp FROM patches WHERE patch_number = PATCH_N;
	IF PATCH_VERSION IS NULL THEN
	  RETURN 1;
	ELSIF PATCH_VERSION > tmp THEN
	  RETURN 1;
	ELSE
	  RETURN 0;
	END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	  RETURN 1;
  END;
END CAN_PATCH;

PROCEDURE REGISTER ( PATCH_N VARCHAR2, PATCH_VERSION VARCHAR2 )IS
tmp VARCHAR2(10);
BEGIN
  IF PATCH_N IS NOT NULL THEN
    BEGIN
      SELECT patch_version INTO tmp FROM patches WHERE patch_number = PATCH_N;
	  UPDATE patches SET
	    patch_version=PATCH_VERSION,
	    apply_date=sysdate
	  WHERE
	    patch_number = PATCH_N;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
	  BEGIN
	    INSERT INTO patches
		(patch_number,patch_version,apply_date)
		VALUES
		(PATCH_N, PATCH_VERSION, sysdate);
      END;
    END;
  END IF;
END REGISTER;

END PATCH;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/patch.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 