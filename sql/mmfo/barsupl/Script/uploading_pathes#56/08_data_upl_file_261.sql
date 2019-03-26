-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������)
define sfile_id = 261
define ssql_id  = 261

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: &&sfile_id');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (&&sfile_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # &&ssql_id');
end;
/
-- ***************************************************************************
-- ETL-19880  UPL - ��������� � �������� ������ bpkproect (327) � acc_pkprct (329)
-- NEW TYPE: 22, '���������� ������'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (261, 
'select 1  "TYPE_ID", ''�������� ��'' "DESCRIPT" from dual
 union all
select 2, ''�������� ��'' from dual
 union all
select 3, ''�������''  from dual
 union all
select 4, ''���'' from dual
 union all
select 5, ''������������'' from dual
 union all
select 6, ''������� �����'' from dual
 union all
select 7, ''������'' from dual
 union all
select 8, ''������������'' from dual
 union all
select 9, ''������ ������'' from dual
 union all
select 10, ''����������'' from dual
 union all
select 11, ''�������� ���'' from dual
 union all
select 12, ''�������� ���������'' from dual
 union all
select 13, ''³�������� ����������� ��'' from dual
 union all
select 14, ''������������ ��������'' from dual
 union all
select 15, ''���������� ����������������'' from dual
 union all
select 16, ''³�������� ����������� ���'' from dual
 union all
select 17, ''³�������� �������� Գ�. ��������'' from dual
 union all
select 18, ''��������� �����'' from dual
 union all
select 19, ''�������� ��'' from dual
 union all
select 20, ''�������� �����������'' from dual
 union all
select 21, ''�������� ���'' from dual
 union all
select 22, ''��������� �������'' from dual
', NULL, NULL, '���� ����', 
    '3.8');

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************


