-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 261
--define ssql_id  = 261

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 261');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (261))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 261');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - ������ �������� ���������� ����� ����
-- TSK-0003096 UPL - ������� ������������ �������� ����������� ��� (�������), �������� ������� �� �� ��������� �� ������ ������ �������� ����
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (261);

declare l_clob clob;
begin
l_clob:= to_clob('select 1  "TYPE_ID", ''�������� ��'' "DESCRIPT" from dual
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
select 13, ''³������� ����������� ��'' from dual
 union all
select 14, ''����������� ��������'' from dual
 union all
select 15, ''���������� ���������������'' from dual
 union all
select 16, ''³������� ����������� ���'' from dual
 union all
select 17, ''³������� �������� Գ�. ��������'' from dual
 union all
select 18, ''�������� �����'' from dual
 union all
select 19, ''�������� ��'' from dual
 union all
select 20, ''�������� �����������'' from dual
 union all
select 21, ''�������� ���'' from dual
 union all
select 22, ''�������� �������'' from dual
 union all
select 23, ''�������� Instolment �� ���'' from dual
 union all
select 24, ''�������� ������ ����'' from dual
 union all
select 25, ''������ �� ������ ����'' from dual');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values  (261, l_clob, NULL, NULL, '���� ����', '3.9');

end;
/


-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (261);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (261);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (261);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (261);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (261);

/*
begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
    else
         -- ************* RU *************
    end if;
end;
/
*/
