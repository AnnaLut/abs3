-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 544
--define ssql_id  = 544

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 544');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (544))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 544');
end;
/
-- ***************************************************************************
-- TSK-0001285  UPL - ��������� �������� �� ��� ������ ������������ ��������� ����� � ������ ���������������� ������� FNV
-- PRVN_FLOW
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (544);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (544);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (544, 544, 'PRVN_FLOW', 'prvn_flow', 0, '09', NULL, '10', 0, '������� ����.������ ��� �������', 544, 'null', 'WHOLE', 'ARR', 0, NULL, 1, 'prvn_flow', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (544);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (544);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (544);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (544);

--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 544, 544);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 544, 544);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 544, 544);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 544, 544);

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
