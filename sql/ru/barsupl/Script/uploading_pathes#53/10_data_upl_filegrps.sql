-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- ����� ������������ ����� ����� ��� DWH
-- ======================================================================================


--
-- UPL - ETL-18652 ��������� ���������� KL_S250 � ��������� ��������������� ������ �� nbu23rez
-- UPL - ETL-18654 ��������� ���������� GRP_PORTFEL � ��������� ��������������� ������ �� nbu23rez
--
delete from BARSUPL.UPL_FILEGROUPS_RLN 
    where file_id in ( 158, 113, 139 );

--
-- 139 (accpardeb) ETL-18831 UPL -��������� � MIR ����� �������������� ��������� ������ (������������� ����������� �������������)  
--
prompt  ���������� ������� 139 accpardeb

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 139, 139);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 139, 139);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 139, 139);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 139, 139);

 -- 158 (arracc2) ETL-18961 UPL - �������� �������� arracc2 � receivables � ���� ������������� ��������� ���������� ����������� �������������
 -- ��������� �������� ������ ��� �������� ��� � �����
 -- ���������� ������� �� � ��
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 158);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 1158);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 158);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 1158);

 -- 113 (RECEIVABLES) ETL-18961 UPL - �������� �������� arracc2 � receivables � ���� ������������� ��������� ���������� ����������� �������������
 -- ��������� �������� ��������� ��� �������� ��� � �����
 -- ��� �� �������� ��� �� ����������� - 
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 113, 113);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 113, 1113);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 113, 113);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 113, 1113);
/*
-- ��� ���� � �� ������ �����
begin
  --mmfo as ( select case when barsupl.bars_upload_utl.is_mmfo > 1 then 1 else 0 end mmfo  from dual ),
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     -- ************* MMFO *************

     -- 158 (arracc2) ETL-18961 UPL - �������� �������� arracc2 � receivables � ���� ������������� ��������� ���������� ����������� �������������
     -- ��������� �������� ������ ��� �������� ��� � �����
     -- ���������� ������� �� � ��
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 1158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 1158);

     -- 113 (RECEIVABLES) ETL-18961 UPL - �������� �������� arracc2 � receivables � ���� ������������� ��������� ���������� ����������� �������������
     -- ��������� �������� ��������� ��� �������� ��� � �����
     -- ��� �� �������� ��� �� ����������� - 
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 113, 113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 113, 1113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 113, 1113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 113, 1113);
  else
     -- ************* RU *************

     -- 158 (arracc2) ETL-18961 UPL - �������� �������� arracc2 � receivables � ���� ������������� ��������� ���������� ����������� �������������
     -- ��������� �������� ������ ��� �������� ��� � �����
     -- ���������� ������� �� � ��
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 3158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 3158);

     -- 113 (RECEIVABLES) ETL-18961 UPL - �������� �������� arracc2 � receivables � ���� ������������� ��������� ���������� ����������� �������������
     -- ��������� �������� ��������� ��� �������� ��� � �����
     -- ��� �� �������� ��� �� ����������� - 
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 113, 2113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 113, 3113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 113, 2113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 113, 3113);

  end if;
end;
/
*/

--
-- ����� 99 �� ������� ������������
--
begin
    -- 99-� ����� - ETL-17786 - �������� ������������ ��� ������� ���������� �������� 
    --      �� ����� 01/11/2016 - 08/02/2017, ������ 99104, 99196

--1. ��� NDBO ����� cusvals.
--2. arracc2 - �������� ������ ���.���������
--3. recivebles - �������� ��������� ���. ���������.
--4. dpt_agrements - �������� ������������� ���. ���������� �� ��������.
--5. customer + person ��� ����������� ������ ������ � ��������.
--6. ��������� ��� �������� ����������� (credits � ����� 10) + arracc1

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 5116);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 201, 99201);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 159, 99159);
  else
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 2116);
  end if;
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 224, 224 );
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 121, 121 );
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 123, 123 );
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 113, 113);
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 158, 158 );
end;
/

COMMIT;

