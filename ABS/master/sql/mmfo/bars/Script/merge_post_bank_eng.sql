DELETE FROM POST_BANK_ENG;

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  1 as POST_ID,
  '�������� 1 �������' as POST_ENG_DESC,
  '1st Category Economist ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  2 as POST_ID,
  '�������� ' as POST_ENG_DESC,
  'Economist ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  3 as POST_ID,
  '�������� ��������' as POST_ENG_DESC,
  'Leading Economist' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  4 as POST_ID,
  '�������� ����/����. ������. - �.�.�. ���.����/�.�. ���.���� - ����. ������./�����.-����� -�.�.�. ���.����/�����. �����.-����� -�.�.�. ���.����/�.�.���.-���.�������/
���.������� ���. ������.-�.�. ���.����/�.�.���.���� - ���. ������� ���. ������./�.�.���.����/����. ���.-���. ����� ������� ����/����. ���.����/���. ����/���.�����' as POST_ENG_DESC,
  'Acting Head of Branch ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  5 as POST_ID,
  '�������� ��������' as POST_ENG_DESC,
  'Senior Economist' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  6 as POST_ID,
  '��������� - �����' as POST_ENG_DESC,
  'Head Cashier' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  7 as POST_ID,
  '������� ��������� - �����' as POST_ENG_DESC,
  'Senior Head Cashier ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  8 as POST_ID,
  '�������� ������� ������� ��������' as POST_ENG_DESC,
  'Head of Cash Payments Sector' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  9 as POST_ID,
  '�������� �������' as POST_ENG_DESC,
  'Head of Sector' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  10 as POST_ID,
  '��������� �����' as POST_ENG_DESC,
  'Head of Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  11 as POST_ID,
  '��������� ����� ������� ��������' as POST_ENG_DESC,
  'Head of Cash Payments Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  12 as POST_ID,
  '��������� ���������� �����' as POST_ENG_DESC,
  'Deputy Head of Division ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  13 as POST_ID,
  '�������� ������� ���������� ������' as POST_ENG_DESC,
  'Head of Retail Business Sector ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  14 as POST_ID,
  '��������� ����� ���������� ������' as POST_ENG_DESC,
  'Head of Retail Business Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  15 as POST_ID,
  '��������� ����� �볺��� ���������� ������' as POST_ENG_DESC,
  'Head of Ratel Business Customers Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  16 as POST_ID,
  '��������� ���������� ����� �볺��� ���������� ������' as POST_ENG_DESC,
  'Deputy Head of the Retail Customers Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  17 as POST_ID,
  '�������� ����/�������� ����' as POST_ENG_DESC,
  'Head of Branch ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  19 as POST_ID,
  '��������� ��������� ����/��������� ���������-��������� ����� ������� ����' as POST_ENG_DESC,
  'Deputy  Head of Branch ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  20 as POST_ID,
  '��������� ��������� ���������' as POST_ENG_DESC,
  'Head of the Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  21 as POST_ID,
  '��������� ���������� ��������� ���������' as POST_ENG_DESC,
  'Deputy Head of the Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  22 as POST_ID,
  '��������� ���������� ��������� ��������� � ���������� ������' as POST_ENG_DESC,
  'Deputy Head of Retail Business   of the  Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  23 as POST_ID,
  '��������� ���������� ��������� ��������� � ����-,������ �� ���������� ������' as POST_ENG_DESC,
  'Deputy Head of MSMB  of the  Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  24 as POST_ID,
  '�������� ������� ����, ������ �� ���������� ������' as POST_ENG_DESC,
  'Head of the MSMB Sector ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

COMMIT;
