-- ================================================================================
-- Module : UPL
-- Date : 05.05.2017
-- ================================================================================
-- ���� ���� ����� ������������
-- ================================================================================

delete from BARSUPL.UPL_COLUMNS
 where file_id in ( 181, 182, 123, 555, 120 )
;

--
-- STAFF (staff) / 181 (ETL-18165 - UPL - ���������� �� ���������� ������)
--
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 1, 'ID', '��� ������������', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 2, 'KF', '��� �������', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 2);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 3, 'FIO', '��� ������������', 'VARCHAR2', 60, NULL, NULL, NULL, 'N', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 4, 'LOGNAME', '��� ������������ ��', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 5, 'TYPE', '������� ���.���.', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 6, 'TABN', '��������� �', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 7, 'DISABLE', '������� ���������� ������������', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 8, 'CLSID', '��������� ������������ (CLSID<0 - ��������)', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 9, 'BRANCH', '��� ���������', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 10, 'ACTIVE', '���������� ������������', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 11, 'CREATED', '���� ��������� ����������� � ���', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 12, 'EXPIRED', '���� ����������� ����������� ���', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);

--
-- STAFF_AD (staffad) / 182 (ETL-18165 - UPL - �������� � �������� ����� STAFF ���� "������� ������ � AD")
--
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 1, 'ID', '��� ������������', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 2, 'FIO', '��� ������������', 'VARCHAR2', 60, NULL, NULL, NULL, 'N', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 3, 'LOGNAME', '��� ������������ ��', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 4, 'TYPE', '������� ���.���.', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 5, 'TABN', '��������� �', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 6, 'DISABLE', '������� ���������� ������������', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 7, 'CLSID', '��������� ������������ (CLSID<0 - ��������)', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 8, 'BRANCH', '��� ���������', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 9, 'ACTIVE', '���������� ������������', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 10, 'CREATED', '���� ��������� ����������� � ���', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 11, 'EXPIRED', '���� ����������� ����������� ���', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 12, 'ACTIVE_DIRECTORY_NAME', 'ACTIVE DIRECTORY NAME �����������', 'VARCHAR2', 255, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);

--
-- NBU23_REZ (nbu23rez) / 555 (�������� ������ ����� ACC_R0, ACC_R30 �� NUMBER(15.0) c NUMBER(22.10) ����� ������ �� ���� �� ����������)
--
-- DWH ETL-18425 UPL - �������� � �������� NBU_23_REZ ����
--  � �������� NBU_23_REZ ���� PD_0, FIN_Z, ISTVAL_351, RPB, S080, S080_Z, DDD_6B, FIN_P, FIN_D, Z, PD
-- 

Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 0, 'KF', '��� ������ (���)', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 1);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 1, 'FDAT', '��.����(01.11.2012.', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 2);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 2, 'ID', '���� ����:���+��', 'VARCHAR2', 50, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 3);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 3, 'RNK', '������������ ����� �볺��� (���)', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 4, 'NBS', '���.���', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 5, 'KV', '��� ���', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 6, 'ND', '��� ���', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 7, 'CC_ID', '��.���', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 8, 'ACC', '���������� ����� �����', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 9, 'NLS', '� ���', 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 10, 'BRANCH', '��� ���������', 'VARCHAR2', 22, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 11, 'FIN', '���.����', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 12, 'OBS', '�����.', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 13, 'KAT', '���.�����', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 14, 'K', '���������� ������', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 15, 'IRR', '���.% �� �� - ��������������', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 16, 'ZAL', '��������.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 17, 'BV', '���.����', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 18, 'PV', '�����.����', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 19, 'REZ', '���-���.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 20, 'REZQ', '���-���.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 21, 'DD', 'DD', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 22, 'DDD', 'DDD', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 23, 'BVQ', '���.���� ������, ��� � 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 24, 'CUSTTYPE', '��� �볺���', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 25, 'IDR', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 26, 'WDATE', 'WDATE', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 27, 'OKPO', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 28, 'NMK', '����� �볺���', 'VARCHAR2', 35, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 29, 'RZ', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 30, 'PAWN', '��� ������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 31, 'ISTVAL', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 32, 'R013', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 33, 'REZN', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 34, 'REZNQ', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 35, 'ARJK', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 36, 'REZD', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 37, 'PVZ', '��������� (������� ��� ��� �����.����) ������������, ��� � 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 38, 'PVZQ', '��������� (������� ��� ��� �����.����) ������������, ��� � 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 39, 'ZALQ', '�i��.�����~���~ZALq', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 40, 'ZPR', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 41, 'ZPRQ', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 42, 'PVQ', '�������� ������� �������� �������� ������ �� ����� ���� �� ���������� ������� (���������)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 43, 'RU', NULL, 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 44, 'INN', NULL, 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 45, 'NRC', NULL, 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 46, 'SDATE', '���� ������ ��������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 47, 'IR', '���.% �� �� - �������', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 48, 'S031', '��� ���� ������ �� ������������� ���', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 49, 'K040', 'K040', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 50, 'PROD', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 51, 'K110', 'K110', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 52, 'K070', 'K070', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 53, 'K051', 'K051', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 54, 'S260', NULL, 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 55, 'R011', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 56, 'R012', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 57, 'S240', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 58, 'S180', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 59, 'S580', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 60, 'NLS_REZ', '������� ��� �i�����~���~NLS_REZ', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 61, 'NLS_REZN', '������� ��� �i�����~���(���)~NLS_REZN', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 62, 'S250', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 63, 'ACC_R', 'ACC ����� ������� ���.� ���������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 64, 'FIN_R', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 65, 'DISKONT', '���� ��������� ��� �� ������� ��������', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 66, 'ISP', '���������� �� ������� ������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 67, 'OB22', NULL, 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 68, 'TIP', NULL, 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 69, 'SPEC', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 70, 'ZAL_BL', '���� ������ ����������', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 71, 'S280_290', '��� ���������� ���� ���������', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 72, 'ZAL_BLQ', '���� ������ ���������� (���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 73, 'ACC_RN', 'ACC ����� ������� �� ���.� ���������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 74, 'OB22_REZ', 'OB22 ��� ����� ������� ���.� ���������', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 75, 'OB22_REZN', 'OB22 ��� ����� ������� �� ���.� ���������', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 76, 'IR0', '���.% �� �� - ���������', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 77, 'IRR0', '���.% �� �� - ���������', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 78, 'ND_CP', '���.�������� ��� ����������� �� ��������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 79, 'SUM_IMP', '������� �� ���������� (���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 80, 'SUMQ_IMP', '������� �� ���������� (���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 81, 'PV_ZAL', '�����*�', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 82, 'VKR', '�����.����.�������', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 83, 'S_L', '�����*����.����.-������� �� ����.(���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 84, 'SQ_L', '�����*����.����.-������� �� ����.(���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 85, 'ZAL_SV', '����������� ������� ������������ (���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 86, 'ZAL_SVQ', '����������� ������� ������������ (���.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 87, 'GRP', '����� ������ ������������ ������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 88, 'KOL_SP', 'ʳ������ ��� ����������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 89, 'REZ39', '����� ������� (���.) �� FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 90, 'PVP', '���� ���������� �������� �������� ������ �� �������� �������� �� �������� ', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 91, 'BV_30', '���������� ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 92, 'BVQ_30', '���������� ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 93, 'REZ_30', '������ ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 94, 'REZQ_30', '������ ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 95, 'NLS_REZ_30', '���� ������� �� ���.% �����.>30 ����', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 96, 'ACC_R30', 'acc ����� ������� �� ���.% �����.>30 ����', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 97, 'OB22_REZ_30', 'Ob22 ����� ������� �� ���.% �����.>30 ����', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 98, 'BV_0', '���������� ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 99, 'BVQ_0', '���������� ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 100, 'REZ_0', '������ ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 101, 'REZQ_0', '������ ����� 30 ���� ���.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 102, 'NLS_REZ_0', '���� ������� �� ���.% �����.<30 ����', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 103, 'ACC_R0', 'acc ����� ������� �� ���.% �����.<30 ����', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 104, 'OB22_REZ_0', 'Ob22 ����� ������� �� ���.% �����.<30 ����', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 105, 'KAT39', '��������� ����� �� FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 106, 'REZQ39', '����� ������� (���.) �� FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 107, 'S250_39', '����� ������� ������� �� �������������� ��� ������������ ������', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 108, 'REZ23', '����� ������� �� 23 ���� (���.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 109, 'REZQ23', '����� ������� �� 23 ���� (���.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 110, 'KAT23', '��������� ����� �� FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 111, 'S250_23', '����� ������� ������� �� �������������� ��� ������������ ������', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 112, 'TIPA', '���.������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 113, 'DAT_MI', '���� �������� �������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 114, 'BVUQ', '����������� ���.����.���', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 115, 'BVU', '����������� ���.����.���', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 116, 'EAD', '(BV - SNA) - EAD(���.) ���������� �� ���-��� �� ���� ������', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 117, 'EADQ', '(BVQ - SNAQ) - EADQ(���.) ���������� �� ���-��� �� ���� ������', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 118, 'CR', '��������� ����� CR (���.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 119, 'CRQ', '��������� ����� CRQ (���.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 120, 'FIN_351', '������������ ���� (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 121, 'KOL_351', '�-�� ��� ���������� (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 122, 'KPZ', '����-� �������� ������������� (���)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 123, 'KL_351', '����.�������� ������������ (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 124, 'LGD', '������ � ��� ������� (LGD)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 125, 'OVKR', '������ �������� ���������� ������', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 126, 'P_DEF', '��䳿 �������', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 127, 'OVD', '������ �������� �������', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 128, 'OPD', '������ ���������� �������', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 129, 'ZAL_351', 'г���� ���������� ����� �� ������� ��������� ������������ ���.(CV*k)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 130, 'ZALQ_351', 'г���� ���������� ����� �� ������� ��������� ������������ ���.(CV*k)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 131, 'RC', 'г���� ���������� ����� �� ������� ����� ���������� ���.(RC)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 132, 'RCQ', 'г���� ���������� ����� �� ������� ����� ���������� ���.(RCQ)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 133, 'CCF', '���������� �������� ������� (CCF)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 134, 'TIP_351', '��� ������ 351 ���������', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS 
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 135, 'PD_0', '���������� (PD=0)', 'NUMBER',    22, 10, '999999999990D0099999999', NULL, 'Y',    NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 138, 'RPB', 'г���� �������� �����', 'NUMBER',  22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 139, 'S080', '�������� ���.����� �� FIN_351', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 136, 'FIN_Z', '���� �����������, ���������� �� ����� ������������� ���������', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 137, 'ISTVAL_351', '������� ������� ������� ����� � ���������� 351', 'NUMBER',  1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 140, 'S080_Z', '�������� ���.����� �� FIN_Z', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 141, 'DDD_6B', 'DDD ��� ����� #6B', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 142, 'FIN_P', '������������ ���� � ��. �����.', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 143, 'FIN_D', '������������ ���� �� ��䳿/������ �������', 'NUMBER',15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 144, 'Z', '������������ ��������', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 145, 'PD', '����. ��������� �������', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);


--
-- PERSON (person) / 123 (ETL-18224 - ��������� ������� "ORGAN")
--
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 1, 'RNK', '��������������� ����� �������', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 2, 'SEX', '���', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 3, 'BDAY', '���� ��������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 4, 'PASSP', '��� ��������������� ���������', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 5, 'NUMDOC', '� ���', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 6, 'SER', '����� ���', 'CHAR', 10, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 7, 'PDATE', '���� ������ ���', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 9, 'TELD', '�������� �������', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 10, 'TELW', '������� �������', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 11, 'KF', '��� �������', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 11);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 12, 'ORGAN', '�����������, �������� �������������� ��������', 'CHAR', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);

--
-- CUSTOMER_EXTERN (custext) / 120 (ETL-18284 - UPL - ��������� ��������� � �����)
--
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 1, 'ID', '��� ���������', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 2, 'NAME', '������������/���', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 3, 'DOC_TYPE', '��� ���������', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 4, 'DOC_SERIAL', '����� ���������', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 5, 'DOC_NUMBER', '����� ���������', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 6, 'DOC_DATE', '���� ������ ���������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 7, 'DOC_ISSUER', '����� ������ ���������', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 8, 'BIRTHDAY', '���� ��������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 9, 'BIRTHPLACE', '����� ��������', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 10, 'SEX', '���', 'CHAR', 1, NULL, NULL, NULL, 'N', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 11, 'ADR', '�����', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 12, 'TEL', '�������', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 13, 'EMAIL', 'E_mail', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 14, 'CUSTTYPE', '������� (1-��, 2-��)', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 15, 'OKPO', '����', 'VARCHAR2', 14, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 16, 'COUNTRY', '��� ������', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 17, 'REGION', '��� �������', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 18, 'FS', '����� ������������� (K081)', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 19, 'VED', '��� ��. ����-�� (K110)', 'CHAR', 5, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 20, 'SED', '���.-�������� ����� (K051)', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 21, 'ISE', '����. ������ ��������� (K070)', 'CHAR', 5, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 22, 'KF', '������', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2);


COMMIT;



--
-- FINISH
--