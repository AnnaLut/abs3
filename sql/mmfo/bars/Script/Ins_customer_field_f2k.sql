-- 13/06/2017  
-- ��� ��������� ����������� ��� ���������� ����� #2K
-- �� ������ 5872 ���� ������������� ��������� �볺��� 
--                (��������� ������ ���������)	
--�� ������ �볺��� �� ������� ���.��� ��������� ������ ������� ���.���������:
--1. SANKC - ����������� ������ (�������) - 
--2. RNBOR - ����� ������� ����� �� ��������� �������� �� ������ ���� ������.
--3. RNBOU - ����� ����� ���������� ������, ����� � ���� ������� � �� ������ ���� ������.
--4. RNBOS - ������� �������� �� ������ ���� ������
--5. RNBOD - ���� �������� � �� ������ ���� ������.

exec bc.home;

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'SANKC';
BEGIN
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


