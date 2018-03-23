-- ======================================================================================
-- Module  : 
-- Author  : 
-- Date    : 29/08/2017
-- ======================================================================================
-- ��� ��������� ����������� ��� ���������� ����� #2K
-- �� ������ 5872 ���� ������������� ��������� �볺��� (��������� ������ ���������)
-- �� ������ �볺��� �� ������� ���.��� ��������� ������ ������� ���.���������:
-- 1. SANKC - ����������� ������ (�������) - 
-- 2. RNBOR - ����� ������� ����� �� ��������� �������� �� ������ ���� ������.
-- 3. RNBOU - ����� ����� ���������� ������, ����� � ���� ������� � �� ������ ���� ������.
-- 4. RNBOS - ������� �������� �� ������ ���� ������
-- 5. RNBOD - ���� �������� � �� ������ ���� ������.
--
-- COBUCDMCORP-64
-- ======================================================================================
Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'SANKC';
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('SANKC', '����������� ������ (�������) (���/ͳ) ', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOR';
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOR', '����� ������� ����� �� ��������� �������� (��� ������ ����)', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOU';
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOU', '����� ����� ���������� ������ (��� ������ ����)', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOS';
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOS', '������� �������� �� ������ ���� ������', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOD';
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOD', '���� �������� � �� ������ ���� ������', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

begin
  Insert
    into CUSTOMER_FIELD
    ( TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK
    , SQLVAL, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD )
  Values
    ( 'EXCLN', '��� � ����������� (�� ��������� �������� �� ���������)', 0, 0, 1, 'V_YESNO', 'N', 0, 'ID'
    , 'select ''0'' from dual', 'GENERAL', 1, 0, 0, 1 );
exception
  when dup_val_on_index then
    update CUSTOMER_FIELD
       set NAME            = '��� � ����������� (�� ��������� �������� �� ���������)'
         , B               = 0
         , U               = 0
         , F               = 1
         , TABNAME         = 'V_YESNO'
         , TABCOLUMN_CHECK = 'ID'
         , SQLVAL          = 'select ''0'' from dual'
         , TYPE            = 'N'
         , OPT             = 0
         , CODE            = 'GENERAL'
         , NOT_TO_EDIT     = 1
         , U_NREZ          = 0
         , F_NREZ          = 0
         , F_SPD           = 1
     where TAG             = 'EXCLN';
end;
/

COMMIT;

prompt add FMPOS reqv
begin
insert into customer_field (TAG, NAME, B, U, F, TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, U_NREZ, F_NREZ, F_SPD)
values ('FMPOS', '����. ���� �����.� ��-�� ������. �� ����. ���.����.��� ������. ����.', 1, 1, 1, 'FM_POSS', null, null, null, 'NAME', null, 'FM', 0, null, null, 0, 1, 1);
commit;
exception
when dup_val_on_index then null;
end;
/
