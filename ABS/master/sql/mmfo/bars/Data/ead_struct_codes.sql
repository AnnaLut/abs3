MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1 as ID,
  '�������������� ��������� ��' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  11 as ID,
  '���������, �� ���������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  111 as ID,
  '������� ����������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  112 as ID,
  '��������� ���������� ����������� ������ (�������� ������, �� ������ ������������ ������ �� ����� ����������� ��������� �������� ������������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  113 as ID,
  '��������� ����������, �� ��������� ����� ����������� ������ (��������  �� ���������� ����� � ��� ������ ��� ���������� ��������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  114 as ID,
  '������� ��.������ ��� ����� �� ������ ��� ������, �� ����. ������� ����������  �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  115 as ID,
  '������� ��. ������ ��� ����� �� ������ � ���. � ����. ��� ����. ������. �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  116 as ID,
  '���������� �������� �������� � �������� �� ������� ���� ���������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  117 as ID,
  '������� �� ������� ���������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  118 as ID,
  '���������� ������, �� ������ � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  119 as ID,
  '������������ ������� ����������� ���� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1110 as ID,
  '���������� ����� ��� ������������ ��� ����� �� ������, �� ������ � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1111 as ID,
  '�������� ��� ���������� ����������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1112 as ID,
  '������� ��������� � ���� �� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1113 as ID,
  '������� ����������� ������ ��� ����� �� ������ � ������� ��� ������ �� ���� � �������������� ������������� ��� ����������� ������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1114 as ID,
  '������� ����������� ������, � ����������������/�������� ����������� �� ������� ��� �����, ��� ������� ������ ��� ������ �� ���� �� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  12 as ID,
  '���������� ��� ����� ������� ������ �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  121 as ID,
  '������ ��� ��������� ������������� ������ ������� ������ �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  122 as ID,
  '������� �������� � ������� ��� ������ �� ��������� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  123 as ID,
  '������� �������� � ������ ��� ������������ ����� ������� ������ �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  13 as ID,
  '������ ��ﳿ ���������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  131 as ID,
  '���� �������� ����������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  132 as ID,
  '���� ����������� ���������� ����������� ������ (�������� ������, �� ������ ������������ ������ �� ����� ����������� ��������� �������� ������������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  133 as ID,
  '���� ����������� ����������, �� ��������� ����� ����������� ������ (��������  �� ���������� ����� � ��� ������ ��� ���������� ��������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  134 as ID,
  '���� �������� ��.������ ��� ����� �� ������ ��� ������, �� ����. ������� ����������  �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  135 as ID,
  '���� �������� ��. ������ ��� ����� �� ������ � ���. � ����. ��� ����. ������. �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  136 as ID,
  '���� ����������� ��������� �������� � �������� �� ������� ���� ���������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  137 as ID,
  '���� ������� �� ������� ���������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  138 as ID,
  '���� ���������� ������, �� ������ � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  139 as ID,
  '���� ������������� �������� ����������� ���� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1310 as ID,
  '���� ���������� ����� ��� ������������ ��� ����� �� ������, �� ������ � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1311 as ID,
  '���� �������� ��� ���������� ����������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1312 as ID,
  '���� ������� �� ������� ���� ���������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1313 as ID,
  '���� ������� �� ��������� ���� ���������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1314 as ID,
  '���� ���������, �� ��������� ���� ����������� ����������� ��� ��������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1315 as ID,
  '���� ������ ��� ��������� ������������� ������ ������� ������ �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1316 as ID,
  '���� ������� �������� � ������� ��� ������ �� ��������� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1317 as ID,
  '���� ���������, �� ��������� ����������� ��������� / �������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1318 as ID,
  '���� ���������, �� ��������� ������ ��������� ������������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1319 as ID,
  '���� ������ ��� ������ �� ���� �������� ������� (4-���)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1320 as ID,
  '���� ��������� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1321 as ID,
  '���� ������� �������� � ������ ��� ������������ ����� ������� ������ �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1322 as ID,
  '���� �������� ����������� ������ ��� ����� �� ������ � ������� ��� ������ �� ���� � �������������� ������������� ��� ����������� ������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1323 as ID,
  '���� �������� ����������� ������, � ����������������/�������� ����������� �� ������� ��� �����, ��� ������� ������ ��� ������ �� ���� �� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  14 as ID,
  '���� ���������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  141 as ID,
  '����� �� ���� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  142 as ID,
  '��������, �� ��������� ����������� ��������� / �������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  143 as ID,
  '������� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  144 as ID,
  '�������� ��� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  145 as ID,
  '��������, �� ��������� ������ ��������� ������������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  146 as ID,
  '����� �볺��� �� ������ ����� ���-����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  147 as ID,
  '��������, �� ��������� ���� ����������� ����������� ��� ��������� � �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  148 as ID,
  '������ ��� ������ �� ���� �������� ������� (4-���)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  149 as ID,
  '������� �� ��������� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  2 as ID,
  '��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  21 as ID,
  '��������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  211 as ID,
  '����� �� ���������� �������� ��������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  212 as ID,
  '������ �� �������� ��������� (�����������) �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  213 as ID,
  '�������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  214 as ID,
  '��������� ���� ������� ������ � ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  215 as ID,
  '����� �� �������� ������� ��� �����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  216 as ID,
  'ϳ������������� ��������� ��� ���������� ����� ��� �����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  217 as ID,
  '������ ��� ���������� � ������ (�����������-���������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  218 as ID,
  '������ � ������� ������ ������������ ����� (14-16 ����), ������ ���������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  219 as ID,
  '����� ��� ���� ������� ��� ������������� ������ �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  2110 as ID,
  '����� ��� ������ �� ��������������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  22 as ID,
  '��������� �� ������������� �������� 3-�� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  221 as ID,
  '������ � �������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  222 as ID,
  '���������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  223 as ID,
  '������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  224 as ID,
  '����� �� ������ �� ��������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  225 as ID,
  '����� �� ���������� ���������, ��������� � ������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  226 as ID,
  '����� �� ���������� ������������� �������������, ����������� � ������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  227 as ID,
  '����� �� ������� �������� ������ ���� ��������� �� �������, ��������� �� �� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  3 as ID,
  '������ ��������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  31 as ID,
  '������  �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  311 as ID,
  '��������� ���������� ���������, ������, ������, ��������� ���� ��� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  312 as ID,
  '��������� ���������� ���������, ��������� �������, ������ ���� ��� ������ ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  313 as ID,
  '������������� ��� ���������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  32 as ID,
  '�����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  321 as ID,
  'г����� (���������) ���� ���� �������� ��� ������� �볺��� ���������; ������ ���� ��� ��������� ����������� � ����� ��� ����������� �볺���; ������ (������) ���� ��� ���������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  322 as ID,
  '����� ���������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  323 as ID,
  '³������ ���������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  324 as ID,
  '�������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  325 as ID,
  '������� ������ (������) ��������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  33 as ID,
  '���������, �� ���������� ��������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  331 as ID,
  '��������� ����� ��� ����� �볺��� �� ��������� ��������� ������� ������ ����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  332 as ID,
  'г����� (������) ���� ��� ��������� ����������, ��� � ���������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  333 as ID,
  '������ �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  4 as ID,
  'Գ�������� ���������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  40 as ID,
  'Գ�������� ���������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  401 as ID,
  '������������ ���� �볺���-������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  402 as ID,
  '���������� � �볺���� ���� ����������� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5 as ID,
  '������ ������������ ����������� ��������������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  51 as ID,
  '��������� ����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  511 as ID,
  '����� ��� ��������� �� �������� ������������ ����������� �������������� �������� ��� �� �������� ��������� ������� � ������������� ������������ ��������� ������ (������� ������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  512 as ID,
  '����� �� ������������ ����������� �������� �� (�������) �������� ��  ���� �������� ������������ �������������� �������� ��� (����)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  513 as ID,
  '����� ��� ������ ��������� ������ � ������ �������� ������������ �������������� �������� ��� (����)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  514 as ID,
  '����� �� ���� ������� ��������� ������� �������� �� ���� �������� ������������ ����������� �������������� �������� ���, ���������� ��  ������ �� �볺����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  515 as ID,
  '����� ��� ��������� �������� ������������ ����������� �������������� �������� ��� ��/��� �������� ������� (��)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  516 as ID,
  '����� �������� ������� ��� ����� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  517 as ID,
  '����� ��������� ������ ��� ����� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  518 as ID,
  '����� ���� ����������� ������� ������ �� ����� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  519 as ID,
  '����� ������ ���������� ������� ��� ������������ ���������� �� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5110 as ID,
  '������ ��� ������ / �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5111 as ID,
  '�������� �� ����������� ������� ����������� ����� ������������ �������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  52 as ID,
  '�������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  521 as ID,
  '������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  522 as ID,
  '������������ ����� ������� ������ �������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  523 as ID,
  '������ ��� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  524 as ID,
  '������ ��� ����� ����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  525 as ID,
  '�������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  526 as ID,
  '������ ��� �������� �������� �������������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  527 as ID,
  '��������� ��� ������ ��� ����������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  528 as ID,
  '������� ��� ��������� ����������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  529 as ID,
  '������� � ��� ��� ���������/��������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5210 as ID,
  '������� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5211 as ID,
  '³�������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5212 as ID,
  '����� ��� ��������� � �������� ������ (��� ��������� ���������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5213 as ID,
  '�������� ��� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5214 as ID,
  '����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5215 as ID,
  'ϳ��������� ��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  53 as ID,
  '��������� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  531 as ID,
  '����� �볺���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  532 as ID,
  '����� �� ������������ �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  533 as ID,
  '������ �볺��� - ������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  534 as ID,
  '������������ �볺��� - ������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  535 as ID,
  '����� �� ���������� ��������� ���������� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  536 as ID,
  '����� ��� ���������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  537 as ID,
  '����� ��� ����� ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  538 as ID,
  '����� ��� ���� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  539 as ID,
  '����� ��� ������ ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5310 as ID,
  '����� ��� ����������� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5311 as ID,
  '����� ��� ����������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5312 as ID,
  '����� ��� ������ �� ����������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5313 as ID,
  '����������� ��� ����� ������������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5314 as ID,
  '����� ��� ������ ���� �� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5315 as ID,
  '����� ��� ������������ ���� �� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5316 as ID,
  '����� ��� ������ �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5317 as ID,
  '��������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5318 as ID,
  '����� ��� ������������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5319 as ID,
  '��������� ����� W4 ���� % ������ (�����������)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5320 as ID,
  '���� ��������� �� ������ ��\��' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5321 as ID,
  '������� ������� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5322 as ID,
  '������� ������� ������� � WAY4 + 2.5% ������ ������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5323 as ID,
  '����� ��� ����������� ��� ��������� ����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5324 as ID,
  '����� ��� ����������� ��� �������� ����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5325 as ID,
  '����� ��������� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5326 as ID,
  '����� �� �������� ����������� ���������� �� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5327 as ID,
  '����� ����������� �������� �� �������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5328 as ID,
  '������ ��� ������ �� ���� ������������������� ���' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  54 as ID,
  '��������� ��������� � WEB-�������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  541 as ID,
  '����� ��� �������� �������� ����� ���� 24/7' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  542 as ID,
  '����� ��� ������ �� ��������������� �� ��������� ����� ���� 24/7' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  543 as ID,
  '����� ��� ���� ������� ������� ������� �� ��� �������� ����� ���� 24/7' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

COMMIT;
